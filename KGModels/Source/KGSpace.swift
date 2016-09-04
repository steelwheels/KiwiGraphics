/**
 * @file	KGSpace.swift
 * @brief	Define KGSpace data structure
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

public struct KGSpace: CNSerializerProtocol
{
	private let mPartitionResolution: Int	= 2		/* Partitioned into "r" x "r" spaces		*/

	private var mField:			KGField
	private var mPartitionDepth:		Int
	private var mPartitionNum:		Array<Int>	/* Number of partitions for each depth		*/

	public init(field f:KGField,  partitionDepth d: Int){
		mField			= f
		mPartitionDepth		= d

		mPartitionNum = [1]	/* level 0 has always 1 */
		var partnum = mPartitionResolution
		for _ in 1..<mPartitionDepth {
			mPartitionNum.append(partnum)
			partnum = partnum * mPartitionResolution
		}
		if DO_DEBUG {
			print("partitionNum=\(mPartitionNum)")
		}
	}

	public func addObject(object o: KGModel) {
		/* Calculate morton index */
		let res      = CGFloat(mPartitionNum[mPartitionDepth-1])	/* Deepest resolution */
		let usize    = CGSize(width: mField.bound.size.width / res, height: mField.bound.size.height / res)
		let spaceidx = boundsToMotionIndexe(bounds: o.bounds, unitSize: usize)
		o.spaceIndex = spaceidx
		if DO_DEBUG {
			print("addObject: depth=\(spaceidx.depth), idx=\(spaceidx.index)")
		}
	}

	private func boundsToMotionIndexe(bounds b: CGRect, unitSize u:CGSize) -> KGSpaceIndex {
		let ltidx  = KGSpace.positionToMortonIndex(x: b.minX, y: b.minY, unitSize: u)
		let rbidx  = KGSpace.positionToMortonIndex(x: b.maxX, y: b.maxY, unitSize: u)

		if DO_DEBUG {
			let ltstr = KGSpace.index2string(index: ltidx, depth: mPartitionDepth)
			let rbstr = KGSpace.index2string(index: rbidx, depth: mPartitionDepth)
			print("ltidx=\(hexString(ltidx)):\(ltstr), rbidx=\(hexString(rbidx)):\(rbstr)")
		}
		
		/* Get depth which has the given bounts in it */
		let spaceidx = mergeIndexes(leftTopIndex: ltidx, rightBottomIndex: rbidx)

		if DO_DEBUG {
			let comstr = KGSpace.index2string(index: spaceidx.index, depth: mPartitionDepth)
			print("depth=\(spaceidx.depth) comidx=\(hexString(spaceidx.index)):\(comstr)")
		}

		return spaceidx
	}

	private func mergeIndexes(leftTopIndex ltidx:UInt32, rightBottomIndex rbidx:UInt32) -> KGSpaceIndex {
		let xoridx	= ltidx ^ rbidx
		var depth	= mPartitionDepth
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

		let xbits  = KGSpace.bitSeparate(bits: xidx)
		let ybits  = KGSpace.bitSeparate(bits: yidx)
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

	public func serialize() -> Dictionary<String, AnyObject> {
		var dict: Dictionary<String, AnyObject> = [:]
		dict["field"] = NSDictionary(dictionary: mField.serialize())
		dict["depth"] = NSNumber(value: Int(mPartitionDepth))
		return dict
	}

	static public func unserialize(dictionary d: Dictionary<String, AnyObject>) -> KGSpace? {
		var field: KGField
		if let fdict = d["field"] as? Dictionary<String, AnyObject> {
			if let fval = KGField.unserialize(dictionary: fdict) {
				field = fval
			} else {
				return nil
			}
		} else {
			return nil
		}
		var depth: Int
		if let dval = d["depth"] as? NSNumber {
			depth = dval.intValue
		} else {
			return nil
		}
		return KGSpace(field: field, partitionDepth: depth)
	}
}
