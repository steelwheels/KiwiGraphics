/**
 * @file	CNRectExtension.swift
 * @brief	Extend CGRect class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation
import Canary

extension CGRect : CNSerializerProtocol
{
	public var description: String {
		let ostr = origin.description
		let sstr = size.description
		return "{origin:\(ostr) size:\(sstr)}"
	}

	public func serialize() -> Dictionary<String, AnyObject> {
		let origin = NSDictionary(dictionary: self.origin.serialize())
		let size   = NSDictionary(dictionary: self.size.serialize())
		let dict : Dictionary<String, AnyObject> = ["origin":origin, "size":size]
		return dict
	}

	public static func unserialize(dictionary dict : Dictionary<String, AnyObject>) -> CGRect? {
		var origin: CGPoint
		if let odict = dict["origin"] as? Dictionary<String, AnyObject> {
			if let oval = CGPoint.unserialize(dictionary: odict) {
				origin = oval
			} else {
				return nil
			}
		} else {
			return nil
		}

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
		return CGRect(origin: origin, size: size)
	}
}
