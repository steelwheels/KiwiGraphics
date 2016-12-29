//
//  UTGradient.swift
//  KiwiGraphics
//
//  Created by Tomoo Hamada on 2016/10/10.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import Foundation
import KiwiGraphics

public func UTGradient() -> Bool
{
	let _ = KGGradientTable.sharedGradientTable.Gradient(forColor: CGColor.white, doDebug: true)
	let _ = KGGradientTable.sharedGradientTable.Gradient(forColor: KGColorTable.white.cgColor, doDebug: true)

	return true
}
