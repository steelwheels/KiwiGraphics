/**
 * @file	KGCircule.swift
 * @brief	Define KGCircule data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation
import CoreGraphics

public struct KGCircle {
	var		center:		CGPoint
	var		radius:		CGFloat
	private var	mBounds:	CGRect

	public init(center c: CGPoint, radius r: CGFloat){
		center	= c
		radius	= r
		mBounds = KGCircle.updateBounds(center: c, radius: r)
	}

	public var bounds: CGRect {
		get { return mBounds }
	}

	public var description: String {
		let cstr = center.description
		let rstr = NSString(format: "%.2lf", radius)
		return "{center:\(cstr) radius:\(rstr)}"
	}

	private static func updateBounds(center c: CGPoint, radius r: CGFloat) -> CGRect {
		let origin   = CGPoint(x: c.x - r, y: c.y - r)
		let diameter = r * 2
		let size     = CGSize(width: diameter, height: diameter)
		return CGRect(origin: origin, size: size)
	}

}

