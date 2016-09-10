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

	private var mBounds:		CGRect
	private var mDepth:		Int

	public init(bounds b:CGRect,  partitionDepth d: Int){
		//assert(d > 0)
		mBounds		= b
		mDepth		= d
	}

	public var bounds: CGRect {
		get { return mBounds }
	}

	public var depth: Int {
		get { return mDepth }
	}

	public var resolution: Int {
		get {
			/* mDepth always bigger than 0 */
			return pow(base: partitionResolution, power: UInt(mDepth)-1)
		}
	}

	public func serialize() -> Dictionary<String, AnyObject> {
		var dict: Dictionary<String, AnyObject> = [:]
		dict["bounds"] = NSDictionary(dictionary: mBounds.serialize())
		dict["depth"]  = NSNumber(value: Int(mDepth))
		return dict
	}

	static public func unserialize(dictionary d: Dictionary<String, AnyObject>) -> KGLayer? {
		var bounds: CGRect
		if let bdict = d["bounds"] as? Dictionary<String, AnyObject> {
			if let bval = CGRect.unserialize(dictionary: bdict) {
				bounds = bval
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
		return KGLayer(bounds: bounds, partitionDepth: depth)
	}
}
