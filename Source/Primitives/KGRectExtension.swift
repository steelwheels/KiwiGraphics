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
	public var center: CGPoint {
		let x = self.origin.x + (self.size.width  / 2)
		let y = self.origin.y + (self.size.height / 2)
		return CGPoint(x: x, y:y)
	}

	public func splitByHolizontally() -> (CGRect, CGRect) {
		let width   = self.size.width
		let height  = self.size.height / 2.0
		let origin0 = self.origin
		let origin1 = CGPoint(x: origin0.x, y: origin0.y + height)
		let size    = CGSize(width: width, height: height)
		return (CGRect(origin: origin0, size: size), CGRect(origin: origin1, size: size))
	}

	public func splitByVertically() -> (CGRect, CGRect) {
		let width   = self.size.width / 2.0
		let height  = self.size.height
		let origin0 = self.origin
		let origin1 = CGPoint(x: origin0.x + width, y: origin0.y)
		let size    = CGSize(width: width, height: height)
		return (CGRect(origin: origin0, size: size), CGRect(origin: origin1, size: size))
	}

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
