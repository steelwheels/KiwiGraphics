/**
 * @file	UTPrimitive.swift
 * @brief	Unit test for primitive functions
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

public func UTPrimitive() -> Bool
{
	let res0 = UTRectPrimitive()
	return res0
}


private func UTRectPrimitive() -> Bool
{
	let rect0 = CGRect(origin: CGPoint(x:10.0, y:10.0), size: CGSize(width: 100.0, height: 100.0))
	let rect1 = CGRect(origin: CGPoint(x:10.0, y:10.0), size: CGSize(width:  10.0, height:  10.0))
	let rect2 = rect1.centeringIn(bounds: rect0)
	Swift.print("\(rect1.description) .centeringIn(\(rect0.description)) -> \(rect2.description)")

	return true
}

