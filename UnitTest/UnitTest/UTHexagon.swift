//
//  UTHexagon.swift
//  KiwiGraphics
//
//  Created by Tomoo Hamada on 2016/09/15.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import Foundation
import KiwiGraphics

public func UTHexagon() -> Bool
{
	var result = true
	let h0 = KGHexagon(center: CGPoint(x:0.0, y:0.0), radius: 10.0)
	if !dump(hexagon: h0) {
		result = false
	}
	return result
}

internal func dump(hexagon h: KGHexagon) -> Bool
{
	print("vertexes: ", terminator:"")
	for v in h.vertexes {
		print("\(v.description) ", terminator:"")
	}
	print("")
	return true
}
