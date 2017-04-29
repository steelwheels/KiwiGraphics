/**
 * @file	KGSozeExtension.swift
 * @brief	Extend CGSize class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics

#if os(iOS)
	public typealias KGSize = CGSize
#else
	public typealias KGSize = NSSize
#endif

extension CGSize
{	
	public var description: String {
		get {
			let wstr = NSString(format: "%.2lf", self.width)
			let hstr = NSString(format: "%.2lf", self.height)
			return "{width:\(wstr), height:\(hstr)}"
		}
	}
}
