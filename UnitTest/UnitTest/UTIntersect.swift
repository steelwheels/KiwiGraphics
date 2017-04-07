/**
 * @file	UTIntersect.m
 * @brief	Unit test for KGLine
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation
import KiwiGraphics

public func UTIntersect() -> Bool
{
	let line0 = KGLine(fromPoint: CGPoint(x: 5.0, y:0.0), toPoint: CGPoint(x: 5.0, y:10.0))
	let line1 = KGLine(fromPoint: CGPoint(x: 0.0, y:5.0), toPoint: CGPoint(x:10.0, y: 5.0))
	let line2 = KGLine(fromPoint: CGPoint(x: 0.0, y:0.0), toPoint: CGPoint(x:10.0, y:10.0))
	let line3 = KGLine(fromPoint: CGPoint(x: 0.0, y:1.0), toPoint: CGPoint(x:10.0, y:11.0))

	let res0 = testLineAndLine(line0: line0, line1:line1, expect: true)
	let res1 = testLineAndLine(line0: line0, line1:line2, expect: true)
	let res2 = testLineAndLine(line0: line2, line1:line3, expect: false)

	return res0 && res1 && res2
}

private func testLineAndLine(line0 l0:KGLine, line1 l1:KGLine, expect exp: Bool) -> Bool
{
	print("TEST: l0:\(l0.description), l1:\(l1.description)")
	var result: Bool
	let (detect, crosspt) = KGIntersectDetector.detectLineAndLineIntersect(line0: l0, line1: l1)
	if detect {
		print(" -> Detect at \(crosspt.description)")
		result = (exp == true)
	} else {
		print(" -> Not detect")
		result = (exp == false)
	}
	return result
}
