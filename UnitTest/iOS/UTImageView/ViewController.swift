/**
 * @file	ViewController.swift
 * @brief	View controller for UTImageView
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import UIKit
import KiwiGraphics

class ViewController: UIViewController
{
	@IBOutlet weak var mImageView: UTImageView!

	override func viewDidLoad() {
		Swift.print("viewDidLoad")
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

