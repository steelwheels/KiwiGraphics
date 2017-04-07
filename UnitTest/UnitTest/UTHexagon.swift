/**
 * @file	UTHexagon.swift
 * @brief	Unit test for KGHexagon
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation
import KiwiGraphics

public func UTHexagon() -> Bool
{
	var result = true
	let h0 = KGHexagon(center: CGPoint(x:0.0, y:0.0), lineWidth: 1.0, radius: 10.0)
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
