/**
 * @file	main.swift
 * @brief	main function for unit test
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

print("[UnitTest for KiwiGraphics]")

internal func unitTest(name n:String, result r: Bool) -> Bool {
	var resstr : String
	if r {
		resstr = "OK"
	} else {
		resstr = "NG"
	}
	print("\(n) : RESULT \(resstr)")
	return r
}

let res0 = unitTest(name: "UTPrimitive",	result: UTPrimitive())
let res1 = unitTest(name: "UTHexagon",		result: UTHexagon())
let res2 = unitTest(name: "UTIntersect",	result: UTIntersect())
let res3 = unitTest(name: "UTGradient",		result: UTGradient())

if res0 && res1 && res2 && res3  {
	print("[SUMMARY] OK")
} else {
	print("[SUMMARY] NG")
}
