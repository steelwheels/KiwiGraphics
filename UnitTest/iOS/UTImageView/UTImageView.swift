//
//  UTImageView.swift
//  KiwiGraphics
//
//  Created by Tomoo Hamada on 2017/01/29.
//  Copyright © 2017年 Steel Wheels Project. All rights reserved.
//

import UIKit
import KiwiGraphics

public class UTImageView: UIImageView
{
	public override func draw(_ rect: CGRect) {
		Swift.print("UTImageView.drawLayer")
		let triangle0 = KGTriangle(bounds: bounds)
		let context = CGContext.currentContext
		let newimage0 = KGImage.generate(context: context!, size: bounds.size, drawFunc: {
			(context: CGContext, size:CGSize) -> Void in
			context.draw(triangle: triangle0, withGradient: nil)
		})
		self.image = newimage0
	}
}

