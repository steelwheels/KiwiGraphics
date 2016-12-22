/**
 * @file	KGFont.swift
 * @brief	Define KFont class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation

#if os(iOS)
	import UIKit
	public typealias KGFont = UIFont
#else
	import Cocoa
	public typealias KGFont = NSFont
#endif

extension KGFont
{
	public func preferredSizeList() -> Array<Int> {
		return [9, 10, 11, 12, 13, 14, 18, 24, 36, 48, 64, 72, 96, 144, 288]
	}
}
