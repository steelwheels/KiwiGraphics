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
