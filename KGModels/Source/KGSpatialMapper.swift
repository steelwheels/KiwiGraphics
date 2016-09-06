/**
 * @file	KGSpatialMapper.swift
 * @brief	Define KGSpatialMapper data structure
 * @par Reference
 *	http://marupeke296.com/COL_2D_No8_QuadTree.html
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation

let DO_DEBUG: Bool		= false

internal func hexString(_ value: UInt32) -> String {
	return NSString(format: "0x%08x", value) as String
}

public struct KGSpatialMapper
{
	public static func mapBounds(bounds b: CGRect,in layer: KGLayer) -> KGSpaceIndex {
		/* Calculate morton index */
		let res      = CGFloat(layer.partitionNum) /* Deepest resolution */
		let field    = layer.field
		let usize    = CGSize(width: field.size.width / res, height: field.size.height / res)
		let spaceidx = boundsToIndexe(bounds: b, unitSize: usize, partitionDepth: layer.partitionDepth)
		return spaceidx
	}

	private static func boundsToIndexe(bounds b: CGRect, unitSize u:CGSize, partitionDepth depth: Int) -> KGSpaceIndex {
		let ltidx  = KGSpatialMapper.positionToMortonIndex(x: b.minX, y: b.minY, unitSize: u)
		let rbidx  = KGSpatialMapper.positionToMortonIndex(x: b.maxX, y: b.maxY, unitSize: u)

		if DO_DEBUG {
			let ltstr = KGSpatialMapper.index2string(index: ltidx, depth: depth)
			let rbstr = KGSpatialMapper.index2string(index: rbidx, depth: depth)
			print("ltidx=\(hexString(ltidx)):\(ltstr), rbidx=\(hexString(rbidx)):\(rbstr)")
		}
		
		/* Get depth which has the given bounts in it */
		let spaceidx = mergeIndexes(leftTopIndex: ltidx, rightBottomIndex: rbidx, partitionDepth: depth)

		if DO_DEBUG {
			let comstr = KGSpatialMapper.index2string(index: spaceidx.index, depth: depth)
			print("depth=\(spaceidx.depth) comidx=\(hexString(spaceidx.index)):\(comstr)")
		}

		return spaceidx
	}

	private static func mergeIndexes(leftTopIndex ltidx:UInt32, rightBottomIndex rbidx:UInt32, partitionDepth pdepth: Int) -> KGSpaceIndex {
		let xoridx	= ltidx ^ rbidx
		var depth	= pdepth
		var newidx	= UInt32(0)
		var newdepth	= 0
		while depth > 0 {
			let shifts = UInt32((depth - 1) * 2)
			if ((xoridx >> shifts) & 0x3) != 0 {
				break
			}
			newidx   = (newidx << 2) | ((ltidx >> shifts) & 0x3)
			newdepth = newdepth + 1
			depth    = depth - 1
		}
		return KGSpaceIndex(depth: newdepth-1, index: newidx)
	}

	private static func positionToMortonIndex(x xpos:CGFloat, y ypos:CGFloat, unitSize u:CGSize) -> UInt32 {
		let xidx = UInt32(xpos / u.width)
		let yidx = UInt32(ypos / u.height)
		if DO_DEBUG {
			print("uwidth=\(u.width), uheight=\(u.height) xpos=\(xpos), ypos=\(ypos) -> xidx=\(xidx), yidx=\(yidx)")
		}

		let xbits  = KGSpatialMapper.bitSeparate(bits: xidx)
		let ybits  = KGSpatialMapper.bitSeparate(bits: yidx)
		let result = xbits | (ybits << 1)
		if DO_DEBUG {
			print("xbits=\(hexString(xbits)), ybits=\(hexString(ybits)), result=\(hexString(result))")
		}
		return result
	}

	private static func bitSeparate(bits v0: UInt32) -> UInt32 {
		let v1 = (v0 | (v0<<8)) & 0x00ff00ff
		let v2 = (v1 | (v1<<4)) & 0x0f0f0f0f
		let v3 = (v2 | (v2<<2)) & 0x33333333
		let v4 = (v3 | (v3<<1)) & 0x55555555
		return v4
	}

	private static func index2string(index i:UInt32, depth dep: Int) -> String {
		var result = "{"
		var depth:Int = dep - 1
		while depth >= 0 {
			let bits:UInt32 = UInt32(depth * 2)
			let val         = (i >> bits) & 0x3
			result = result + "\(val) "
			depth = depth - 1
		}
		return result + "}"
	}
}
