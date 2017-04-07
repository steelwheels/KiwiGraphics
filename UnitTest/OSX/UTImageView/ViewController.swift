/**
 * @file	ViewController.swift
 * @brief	View controller for UTImageView
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

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

