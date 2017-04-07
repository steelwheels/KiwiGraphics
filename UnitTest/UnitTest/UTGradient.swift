/**
 * @file	UTGradient.swift
 * @brief	Unit test for KGGradientTable
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation
import KiwiGraphics

public func UTGradient() -> Bool
{
	let _ = KGGradientTable.sharedGradientTable.gradient(forColor: CGColor.white, doDebug: true)
	let _ = KGGradientTable.sharedGradientTable.gradient(forColor: KGColorTable.white.cgColor, doDebug: true)

	return true
}

