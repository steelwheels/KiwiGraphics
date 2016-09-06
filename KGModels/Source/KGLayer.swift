/**
 * @file	KGLayer.swift
 * @brief	Define KGLayer data structure
 * @par Reference
 *	http://marupeke296.com/COL_2D_No8_QuadTree.html
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation
import Canary

public struct KGLayer: CNSerializerProtocol
{
	public let partitionResolution: Int	= 2		/* Partitioned into "r" x "r" spaces		*/

	private var mField:			CGRect
	private var mPartitionDepth:		Int
	private var mPartitionNum:		Array<Int>	/* Number of partitions for each depth		*/

	public init(field f:CGRect,  partitionDepth d: Int){
		mField			= f
		mPartitionDepth		= d

		mPartitionNum = [1]	/* level 0 has always 1, level 1 has 2, [1, 2, 4, 8] */
		var partnum = partitionResolution
		for _ in 1..<mPartitionDepth {
			mPartitionNum.append(partnum)
			partnum = partnum * partitionResolution
		}
		if DO_DEBUG {
			print("partitionNum=\(mPartitionNum)")
		}
	}

	public var field: CGRect {
		get { return mField }
	}

	public var partitionDepth: Int {
		get { return mPartitionDepth }
	}

	public var partitionNum: Int {
		get { return mPartitionNum[mPartitionDepth-1] }
	}

	public func serialize() -> Dictionary<String, AnyObject> {
		var dict: Dictionary<String, AnyObject> = [:]
		dict["field"] = NSDictionary(dictionary: mField.serialize())
		dict["depth"] = NSNumber(value: Int(mPartitionDepth))
		return dict
	}

	static public func unserialize(dictionary d: Dictionary<String, AnyObject>) -> KGLayer? {
		var field: CGRect
		if let fdict = d["field"] as? Dictionary<String, AnyObject> {
			if let fval = CGRect.unserialize(dictionary: fdict) {
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
		return KGLayer(field: field, partitionDepth: depth)
	}
}
