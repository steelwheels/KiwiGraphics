//
//  ViewController.swift
//  UTImageView
//
//  Created by Tomoo Hamada on 2016/12/10.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import Cocoa
import KiwiGraphics

class ViewController: NSViewController
{
	@IBOutlet weak var mImageView: NSImageView!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		let bounds    = mImageView.bounds
		let triangle0 = KGTriangle(bounds: bounds)
		let newimage0 = NSImage.generate(size: bounds.size, drawFunc: {
			(size:CGSize, context:CGContext) -> Void in
				context.draw(triangle: triangle0, withGradient: nil)
		})
		mImageView.image = newimage0
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
}

