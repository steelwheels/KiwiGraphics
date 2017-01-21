//
//  ViewController.swift
//  UTFontTable
//
//  Created by Tomoo Hamada on 2017/01/20.
//  Copyright © 2017年 Steel Wheels Project. All rights reserved.
//

import UIKit
import KiwiGraphics

class ViewController: UIViewController
{
	@IBOutlet weak var mTextField0: UILabel!
	@IBOutlet weak var mTextField1: UILabel!
	@IBOutlet weak var mTextField2: UILabel!
	@IBOutlet weak var mTextField3: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let table = KGFontTable.sharedFontTable
		mTextField0.font = table.font(withStyle: .Title)
		mTextField0.text = "Title"

		mTextField1.font = table.font(withStyle: .Headline)
		mTextField1.text = "Headline"

		mTextField2.font = table.font(withStyle: .Caption)
		mTextField2.text = "Caption"

		mTextField3.font = table.font(withStyle: .Body)
		mTextField3.text = "Body"
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

