/**
 * @file	KGPartitionCell.swift
 * @brief	Define KGPartitionCell data structure
 * @par Reference
 *	http://marupeke296.com/COL_2D_No8_QuadTree.html
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation
import Canary

final public class KGPartitionCell: CNSerializerProtocol
{
	private var mBounds: CGRect

	public init(bounds b: CGRect){
		mBounds	= b
	}

	public var bounds: CGRect {
		get { return mBounds }
	}

	public func serialize() -> Dictionary<String, AnyObject> {
		let dict: Dictionary<String, AnyObject> = [
			"bounds": NSDictionary(dictionary: mBounds.serialize())
		]
		return dict
	}

	static public func unserialize(dictionary dict: Dictionary<String, AnyObject>) -> KGPartitionCell? {
		if let bdict = dict["bounds"] as? Dictionary<String, AnyObject> {
			if let bval = CGRect.unserialize(dictionary: bdict) {
				return KGPartitionCell(bounds: bval)
			}
		}
		return nil
	}
}

