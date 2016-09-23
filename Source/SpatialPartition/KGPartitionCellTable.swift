/**
 * @file	KGPartitionCellTable.swift
 * @brief	Define KGPartitionCellTable data structure
 * @par Reference
 *	http://marupeke296.com/COL_2D_No8_QuadTree.html
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation
import Canary

public struct KGPartitionCellTable: CNSerializerProtocol
{
	private var mSize	: CGSize
	private var mDepth	: Int
	private var mSpaceTable	: Array<KGPartitionCell>

	public init(size s:CGSize, depth d:Int){
		mSize	= s
		mDepth  = d

		/* Layer 0 */
		mSpaceTable = [KGPartitionCellTable.allocateCell(origin: CGPoint(x:0.0, y:0.0), size:s)]
		/* Layer 1, 2, ... */
		let origin = CGPoint(x: 0.0, y: 0.0)
		for curd in 1..<d {
			mSpaceTable.append(contentsOf: KGPartitionCellTable.allocateSpaces(origin: origin, size: s, depth:  curd))
		}
	}

	private static func allocateSpaces(origin o:CGPoint, size s:CGSize, depth d: Int) -> Array<KGPartitionCell> {
		var result: Array<KGPartitionCell> = []
		let w0 = s.width  / 2.0
		let h0 = s.height / 2.0
		let s0 = CGSize(width: w0, height: h0)

		let o0 = CGPoint(x: o.x,    y: o.y)
		let o1 = CGPoint(x: o.x+w0, y: o.y)
		let o2 = CGPoint(x: o.x,    y: o.y+h0)
		let o3 = CGPoint(x: o.x+w0, y: o.y+h0)

		if d > 1 {
			let nd = d - 1
			result.append(contentsOf: allocateSpaces(origin: o0, size: s0, depth: nd))
			result.append(contentsOf: allocateSpaces(origin: o1, size: s0, depth: nd))
			result.append(contentsOf: allocateSpaces(origin: o2, size: s0, depth: nd))
			result.append(contentsOf: allocateSpaces(origin: o3, size: s0, depth: nd))
		} else {
			result.append(allocateCell(origin: o0, size: s0))
			result.append(allocateCell(origin: o1, size: s0))
			result.append(allocateCell(origin: o2, size: s0))
			result.append(allocateCell(origin: o3, size: s0))
		}
		return result
	}

	private static func allocateCell(origin o:CGPoint, size s:CGSize) -> KGPartitionCell {
		let bounds = CGRect(origin: o, size: s)
		return KGPartitionCell(bounds: bounds)
	}

	public func cell(atIndex idx: KGPartitionIndex) -> KGPartitionCell {
		let addr = cellAddress(atIndex: idx)
		return mSpaceTable[addr]
	}

	public mutating func setCell(atIndex idx:KGPartitionIndex, cell c:KGPartitionCell){
		let addr = cellAddress(atIndex: idx)
		mSpaceTable[addr] = c
	}

	private func cellAddress(atIndex idx: KGPartitionIndex) -> Int {
		let base = (pow(base: 4, power: UInt(idx.depth)) - 1) / 3
		let addr = base + Int(idx.index)
		assert(addr<mSpaceTable.count, "Invalid index")
		return addr
	}
	
	public func serialize() -> Dictionary<String, AnyObject> {
		let dict: Dictionary<String, AnyObject> = [
			"size"  : NSDictionary(dictionary: mSize.serialize()),
			"depth" : NSNumber(value: mDepth)
		]
		return dict
	}

	static public func unserialize(dictionary dict: Dictionary<String, AnyObject>) -> KGPartitionCellTable? {
		var size: CGSize
		if let sdict = dict["size"] as? Dictionary<String, AnyObject> {
			if let sval = CGSize.unserialize(dictionary: sdict) {
				size = sval
			} else {
				return nil
			}
		} else {
			return nil
		}
		var depth: Int
		if let dnum = dict["depth"] as? NSNumber {
			depth = dnum.intValue
		} else {
			return nil
		}
		return KGPartitionCellTable(size: size, depth: depth)
	}
}
