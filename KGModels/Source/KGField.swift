/**
 * @file	KGField.swift
 * @brief	Define KGField data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics
import Canary

public struct KGField: CNSerializerProtocol
{
	private var mBound : CGRect

	public init(bound b: CGRect){
		mBound = b
	}

	public var bound: CGRect {
		get { return mBound }
	}

	public func serialize() -> Dictionary<String, AnyObject> {
		var dict: Dictionary<String, AnyObject> = [:]
		dict["bound"] = NSDictionary(dictionary: mBound.serialize())
		return dict
	}

	static public func unserialize(dictionary d: Dictionary<String, AnyObject>) -> KGField? {
		if let bdict = d["bound"] as? Dictionary<String, AnyObject> {
			if let bound = CGRect.unserialize(dictionary: bdict) {
				return KGField(bound: bound)
			}
		}
		return nil
	}
}
