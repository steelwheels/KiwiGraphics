/**
 * @file	KGPartitionMapper.swift
 * @brief	Define KGPartitionMapper data structure
 * @par Reference
 *	http://marupeke296.com/COL_2D_No8_QuadTree.html
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation
import Canary
let DO_DEBUG: Bool		= false

internal func hexString(_ value: UInt32) -> String {
	return NSString(format: "0x%08x", value) as String
}

public struct KGPartitionMapper
{
	public static func mapBounds(bounds b: CGRect,in layer: KGPartitionLayer) -> KGPartitionIndex {
		/* Calculate morton index */
		let field    = layer.bounds
		let res      = CGFloat(layer.resolution) /* Deepest resolution */
		let usize    = CGSize(width: field.size.width / res, height: field.size.height / res)
		let spaceidx = boundsToIndex(bounds: b, unitSize: usize, partitionDepth: layer.depth)
		return spaceidx
	}

	private static func boundsToIndex(bounds b: CGRect, unitSize u:CGSize, partitionDepth depth: Int) -> KGPartitionIndex {
		let x0 = b.origin.x
		let y0 = b.origin.y
		let x1 = x0 + b.size.width
		let y1 = y0 + b.size.height

		let ltidx  = KGPartitionMapper.positionToMortonIndex(x: x0, y: y0, unitSize: u)
		let rbidx  = KGPartitionMapper.positionToMortonIndex(x: x1, y: y1, unitSize: u)

		if DO_DEBUG {
			let ltstr = KGPartitionMapper.index2string(index: ltidx, depth: depth)
			let rbstr = KGPartitionMapper.index2string(index: rbidx, depth: depth)
			print("ltidx=\(hexString(ltidx)):\(ltstr), rbidx=\(hexString(rbidx)):\(rbstr)")
		}
		
		/* Get depth which has the given bounts in it */
		let spaceidx = mergeIndexes(leftTopIndex: ltidx, rightBottomIndex: rbidx, partitionDepth: depth)

		if DO_DEBUG {
			let comstr = KGPartitionMapper.index2string(index: spaceidx.index, depth: depth)
			print("depth=\(spaceidx.depth) comidx=\(hexString(spaceidx.index)):\(comstr)")
		}

		return spaceidx
	}

	private static func mergeIndexes(leftTopIndex ltidx:UInt32, rightBottomIndex rbidx:UInt32, partitionDepth pdepth: Int) -> KGPartitionIndex {
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
		return KGPartitionIndex(depth: newdepth-1, index: newidx)
	}

	private static func positionToMortonIndex(x xpos:CGFloat, y ypos:CGFloat, unitSize u:CGSize) -> UInt32 {
		let xidx = UInt32(max(xpos, 0,0) / u.width)
		let yidx = UInt32(max(ypos, 0.0) / u.height)
		if DO_DEBUG {
			print("uwidth=\(u.width), uheight=\(u.height) xpos=\(xpos), ypos=\(ypos) -> xidx=\(xidx), yidx=\(yidx)")
		}

		let xbits  = KGPartitionMapper.bitSeparate(bits: xidx)
		let ybits  = KGPartitionMapper.bitSeparate(bits: yidx)
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
