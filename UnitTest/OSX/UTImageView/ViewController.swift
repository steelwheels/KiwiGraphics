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
	@IBOutlet weak var mImageView: UTImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
        
		// Do any additional setup after loading the view.
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
}

