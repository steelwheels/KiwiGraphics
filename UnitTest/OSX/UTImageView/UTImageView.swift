//
//  UTImageView.swift
//  KiwiGraphics
//
//  Created by Tomoo Hamada on 2017/01/29.
//  Copyright © 2017年 Steel Wheels Project. All rights reserved.
//

import AppKit

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
