/*
 * @file	KGIntersectDetector.swift
 * @brief	Define KGIntersectDetector class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation
import CoreGraphics

struct KGSegment {
	public var origin:	CGPoint
	public var vector:	CGPoint

	init(line l: KGLine){
		origin = l.fromPoint
		let dx = l.toPoint.x - l.fromPoint.x
		let dy = l.toPoint.y - l.fromPoint.y
		vector = CGPoint(x: dx, y: dy)
	}
}

public class KGIntersectDetector
{
	public class func detectLineAndLineIntersect(line0 l0: KGLine, line1 l1: KGLine) -> (Bool, CGPoint) {
		let s1 = KGSegment(line: l0)
		let s2 = KGSegment(line: l1)

		let cross = s1.vector.cross(s2.vector)
		if cross == 0.0 {
			return (false, CGPoint(x: 0.0, y: 0.0))
		}

		let v       = s2.origin - s1.origin
		let crossv1 = v.cross(s1.vector)
		let crossv2 = v.cross(s2.vector)
		let t1      = crossv1 / cross
		let t2      = crossv2 / cross
		let eps	    = CGFloat(0.00001)
		if ( t1 + eps < 0 || t1 - eps > 1 || t2 + eps < 0 || t2 - eps > 1 ) {
			return (false, CGPoint(x: 0.0, y: 0.0))
		}

		let crosspt = s1.origin + t1 * s1.vector
		return (true, crosspt)
	}
}
