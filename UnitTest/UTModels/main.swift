//
//  main.swift
//  UTModels
//
//  Created by Tomoo Hamada on 2016/09/04.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import Foundation

print("Hello, World!")

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

let res0 = unitTest(name: "UTLayerMapper",	result: UTLayerMapper())
let res1 = unitTest(name: "UTLayerCell",	result: UTLayerCell())

if res0 && res1 {
	print("[SUMMARY] OK")
} else {
	print("[SUMMARY] NG")
}
