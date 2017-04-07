/**
 * @file	ViewController.swift
 * @brief	View controller UTFontTable
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Cocoa
import KiwiGraphics

class ViewController: NSViewController {

	@IBOutlet weak var mTextField0: NSTextField!
	@IBOutlet weak var mTextField1: NSTextField!
	@IBOutlet weak var mTextField2: NSTextField!
	@IBOutlet weak var mTextField3: NSTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
		let table = KGFontTable.sharedFontTable
		mTextField0.font = table.font(withStyle: .Title)
		mTextField1.font = table.font(withStyle: .Headline)
		mTextField2.font = table.font(withStyle: .Body)
		mTextField3.font = table.font(withStyle: .Caption)
	}

	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}


}

