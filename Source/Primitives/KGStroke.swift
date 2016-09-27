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

	public func addPoint(point pt: CGPoint) -> Bool {
		var didadded = false
		let count = mStrokePoints.count
		if count > 0 {
			let lastidx = mStrokePoints.count - 1
			let lastpt  = mStrokePoints[lastidx]
			if !KGStroke.isNearPoints(p0: pt, p1: lastpt) {
				mStrokePoints.append(pt)
				didadded = true
			}
		} else {
			mStrokePoints.append(pt)
			didadded = true
		}
		return didadded
	}

	private static func isNearPoints(p0: CGPoint, p1: CGPoint) -> Bool {
		let dx = abs(p0.x - p1.x)
		let dy = abs(p0.y - p1.y)
		return (dx < 1.0) && (dy < 1.0)
	}

	public func lastUpdatedArea() -> CGRect {
		let count = mStrokePoints.count
		if count >= 2 {
			let pt0    = mStrokePoints[count-1]
			let pt1    = mStrokePoints[count-2]
			let origin = CGPoint(x: min(pt0.x, pt1.x), y: min(pt0.y, pt1.y))
			let width  = abs(pt0.x - pt1.x)
			let height = abs(pt0.y - pt1.y)
			return CGRect(origin: origin, size: CGSize(width: width, height: height))
		} else {
			return CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
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

