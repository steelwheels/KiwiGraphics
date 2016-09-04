/**
 * @file	KGModel.swift
 * @brief	Define KGModel data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */


import Foundation
import CoreGraphics

open class KGModel
{
	private var mPosition:		CGPoint
	private var mRadius:		CGFloat
	private var mBounds:		CGRect
	private var mSpaceIndex:	KGSpaceIndex

	public init(position p:CGPoint, radius r: CGFloat){
		mPosition	= p
		mRadius		= r
		mBounds		= KGModel.calcBounds(position: p, radius: r)
		mSpaceIndex	= KGSpaceIndex(depth: 0, index: 0)
	}

	private static func calcBounds(position p:CGPoint, radius r:CGFloat) -> CGRect {
		let origin = CGPoint(x: p.x-r, y: p.y-r)
		let size   = CGSize(width: r*2, height: r*2)
		return CGRect(origin: origin, size: size)
	}

	public var position: CGPoint {
		get { return mPosition }
	}

	public var bounds: CGRect {
		get { return mBounds }
	}

	public var spaceIndex: KGSpaceIndex {
		get { return mSpaceIndex }
		set(v) { mSpaceIndex = v }
	}
}
