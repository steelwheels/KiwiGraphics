//
//  ViewController.swift
//  UTImageView
//
//  Created by Tomoo Hamada on 2016/12/10.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import UIKit
import KiwiGraphics

class ViewController: UIViewController
{
	@IBOutlet weak var mImageView: UIImageView!


	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view, typically from a nib.
		// Do any additional setup after loading the view.
		let bounds    = mImageView.bounds
		let triangle0 = KGTriangle(bounds: bounds)
		let newimage0 = UIImage.generate(size: bounds.size, drawFunc: {
			(size:CGSize, context:CGContext) -> Void in
			context.draw(triangle: triangle0, withGradient: nil)
		})
		mImageView.image = newimage0
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

