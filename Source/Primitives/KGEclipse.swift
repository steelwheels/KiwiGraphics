/**
 * @file	KGEclipse.swift
 * @brief	Define KGEclipse data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics
import Foundation

public struct KGEclipse
{
	static let mGradient = allocateGradient()

	public var mCenter:		CGPoint
	public var mInnerRadius:	CGFloat
	public var mOuterRadius:	CGFloat

	private var mBounds:		CGRect

	public init(center c:CGPoint, innerRadius ir: CGFloat, outerRadius or: CGFloat) {
		mCenter		= c
		mInnerRadius	= ir
		mOuterRadius	= or
		mBounds		= KGEclipse.calcBounds(center: mCenter, outerRadius: or)
	}

	public var center: CGPoint {
		get { return mCenter }
	}

	public var innerRadius: CGFloat {
		get { return mInnerRadius }
	}

	public var outerRadius: CGFloat {
		get { return mOuterRadius }
	}

	public var bounds: CGRect {
		get { return mBounds }
	}

	public var gradient: CGGradient {
		get { return KGEclipse.mGradient }

	}
	
	static private func calcBounds(center c: CGPoint, outerRadius or: CGFloat) -> CGRect {
		let outdiameter = or * 2
		let origin      = CGPoint(x: c.x - or, y: c.y - or)
		let size        = CGSize(width: outdiameter, height: outdiameter)
		return CGRect(origin: origin, size: size)
	}

	static private func allocateGradient() -> CGGradient {
		let colorspace = CGColorSpaceCreateDeviceRGB()
		let components: Array<CGFloat> = [
			1.0, 1.0, 1.0, 1.0,
			0.5, 0.5, 0.5, 1.0,
			0.0, 0.0, 0.0, 1.0,
			]
		let locations: Array<CGFloat> = [0.0, 0.5, 1.0]
		let count = components.count / 4
		if let gradient = CGGradient(colorSpace: colorspace, colorComponents: components, locations: locations, count: count) {
			return gradient
		} else {
			fatalError("Can not allocate gradient")
		}
	}
}

