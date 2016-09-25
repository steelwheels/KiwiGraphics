/**
 * @file	KGStroke.swift
 * @brief	Extend CGStroke class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation

public class KGStroke
{
	private var mStrokePoints: Array<CGPoint>

	public init(firstPoint pt: CGPoint){
		mStrokePoints = [pt]
	}

	public var strokes: Array<CGPoint> {
		get { return mStrokePoints }
	}

	public func addPoint(point pt: CGPoint){
		let count = mStrokePoints.count
		if count > 0 {
			let lastidx = mStrokePoints.count - 1
			let lastpt  = mStrokePoints[lastidx]
			if pt != lastpt {
				mStrokePoints.append(pt)
			}
		} else {
			mStrokePoints.append(pt)
		}
	}

	public var description: String {
		get {
			var result: String = "["
			var is1st: Bool	= true
			for point in mStrokePoints {
				if is1st {
					is1st = false
				} else {
					result = result + ", "
				}
				result = result + point.description
			}
			return result + "]"
		}
	}

}

