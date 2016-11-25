/**
 * @file	KGGlyph.swift
 * @brief	Define KGGlyph data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics
import Foundation

public struct KGGlyph
{
	private var mBounds		: CGRect
	private var mElementRadius	: CGFloat
	private var mRadius		: CGFloat
	private var mVertices		: Array<CGPoint>

	public init(bounds b: CGRect){
		mBounds		= KGGlyph.calcBounds(bounds: b)
		mElementRadius	= mBounds.size.width * 0.04
		mRadius		= (mBounds.size.width / 2.0) - mElementRadius
		mVertices	= KGGlyph.allocateVertices(bounds: mBounds, glyphRadius: mRadius, elementRadius: mElementRadius)
	}

	public var bounds: CGRect {
		get { return mBounds }
	}

	public var radius: CGFloat {
		get { return mRadius }
	}
	
	public var elementRadius: CGFloat {
		get { return mElementRadius }
	}

	public var vertices: Array<CGPoint> {
		get { return mVertices }
	}

	private static func calcBounds(bounds b: CGRect) -> CGRect {
		let width = min(b.size.width, b.size.height)
		let diffx = b.size.width  - width
		let diffy = b.size.height - width
		let orgx  = b.origin.x + diffx / 2.0
		let orgy  = b.origin.y + diffy / 2.0
		return CGRect(x: orgx, y: orgy, width: width, height: width)
	}

	private static func allocateVertices(bounds b: CGRect, glyphRadius radius: CGFloat, elementRadius elmradius: CGFloat) -> Array<CGPoint> {
		/* Get center and radius of bounds */
		let center = b.center

		/* Point of hexagon */
		var points: Array<CGPoint> = []
		let pi2  = 2.0 * CGFloat.pi
		let diff = pi2 / 6.0
		for i in 0..<6 {
			let angle = CGFloat(i) * diff
			let y = radius * cos(angle)
			let x = radius * sin(angle)
			let pt = CGPoint(x: center.x + x, y: center.y + y)
			points.append(pt)
		}

		let diff5_2 = points[5] - points[2]
		let point6  = points[2] + (diff5_2 * (3.0 / 4.0))
		points.append(point6)
		let point7  = points[2] + (diff5_2 * (2.0 / 4.0))
		points.append(point7)
		let point8  = points[2] + (diff5_2 * (1.0 / 4.0))
		points.append(point8)

		let diff4_1 = points[4] - points[1]
		let point9  = points[1] + (diff4_1 * (3.0 / 4.0))
		points.append(point9)
		let point10 = points[1] + (diff4_1 * (1.0 / 4.0))
		points.append(point10)

		return points
	}
}
