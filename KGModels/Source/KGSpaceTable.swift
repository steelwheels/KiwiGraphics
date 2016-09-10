/**
 * @file	KGSpaceTable.swift
 * @brief	Define KGSpaceTable data structure
 * @par Reference
 *	http://marupeke296.com/COL_2D_No8_QuadTree.html
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation
import Canary

public struct KGLayerCell {
	public var mBounds: CGRect

	public init(bounds b: CGRect){
		mBounds	= b
	}

	public var bounds: CGRect {
		get { return mBounds }
	}
}

public struct KGSpaceTable: CNSerializerProtocol
{
	private var mBounds	: CGRect
	private var mDepth	: Int
	private var mSpaceTable	: Array<KGLayerCell>

	public init(bounds b:CGRect, depth d:Int){
		mBounds = b
		mDepth  = d

		let origin = b.origin
		let size   = b.size

		/* Layer 0 */
		mSpaceTable = [KGSpaceTable.allocateCell(origin: origin, size:size)]
		/* Layer 1, 2, ... */
		for curd in 1..<d-1 {
			mSpaceTable.append(contentsOf: KGSpaceTable.allocateSpaces(origin: origin,
			                                                           size:   size,
			                                                           depth:  curd))
		}
	}

	private static func allocateSpaces(origin o:CGPoint, size s:CGSize, depth d: Int) -> Array<KGLayerCell> {
		var result: Array<KGLayerCell> = []
		let w0 = s.width  / 4.0
		let h0 = s.height / 4.0
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

	private static func allocateCell(origin o:CGPoint, size s:CGSize) -> KGLayerCell {
		let bounds = CGRect(origin: o, size: s)
		return KGLayerCell(bounds: bounds)
	}

	public func serialize() -> Dictionary<String, AnyObject> {
		let dict: Dictionary<String, AnyObject> = [
			"bounds" : NSDictionary(dictionary: mBounds.serialize()),
			"depth"  : NSNumber(value: mDepth)
		]
		return dict
	}

	static public func unserialize(dictionary dict: Dictionary<String, AnyObject>) -> KGSpaceTable? {
		var bounds: CGRect
		if let bdict = dict["bounds"] as? Dictionary<String, AnyObject> {
			if let bval = CGRect.unserialize(dictionary: bdict) {
				bounds = bval
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
		return KGSpaceTable(bounds: bounds, depth: depth)
	}
}
