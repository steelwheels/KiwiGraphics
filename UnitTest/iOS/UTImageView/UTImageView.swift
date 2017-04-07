/**
 * @file	UTImageView.swift
 * @brief	Unit test for KGImage
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import UIKit
import KiwiGraphics

public class UTImageView: UIImageView
{
	public override func draw(_ rect: CGRect) {
		Swift.print("UTImageView.drawLayer")
		let context = CGContext.currentContext
		let newimage0 = KGImage.generate(context: context!, bounds: bounds, drawFunc: {
			(context: CGContext, contentRect:CGRect) -> Void in
			let triangle0 = KGTriangle(bounds: bounds)
			context.draw(triangle: triangle0, withGradient: nil)
		})
		self.image = newimage0
	}
}

