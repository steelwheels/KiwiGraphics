/**
 * @file	UTImageView.swift
 * @brief	Unit test for KGImage
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import AppKit
import KiwiGraphics

public class UTImageView: NSImageView
{
	public override func draw(_ dirtyRect: NSRect) {
		let triangle0 = KGTriangle(bounds: bounds)
		let context = CGContext.currentContext
		let newimage0 = NSImage.generate(context: context!, bounds: bounds, drawFunc: {
			(context: CGContext, bounds:CGRect) -> Void in
			context.draw(triangle: triangle0, withGradient: nil)
		})
		self.image = newimage0
		super.draw(dirtyRect)
	}
}
