//
//  main.swift
//  UTModels
//
//  Created by Tomoo Hamada on 2016/09/04.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

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

let res0 = unitTest(name: "UTPartitionMapper",	result: UTPartitionMapper())
let res1 = unitTest(name: "UTPartitionCell",	result: UTPartitionCell())
let res2 = unitTest(name: "UTHexagon",		result: UTHexagon())

if res0 && res1 && res2 {
	print("[SUMMARY] OK")
} else {
	print("[SUMMARY] NG")
}
