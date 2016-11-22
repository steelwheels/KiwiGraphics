/**
 * @file	KGImage.swift
 * @brief	Extend KGImage class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 * @par Reference
 *    http://qiita.com/HaNoHito/items/2fe95aba853f9cedcd3e
 */

import Foundation

#if os(iOS)
#else
import Cocoa
#endif

#if os(iOS)
	public typealias KGImage = UIImage
#else
	public typealias KGImage = NSImage
#endif

public typealias KGImageDrawer = (_ size: CGSize, _ context: CGContext) -> Void

#if os(OSX)

extension NSImage
{
	public class func generate(size:CGSize, drawFunc: KGImageDrawer) -> NSImage {
		let newimg = NSImage(size: size)
		newimg.lockFocus()
		if let context: CGContext = NSGraphicsContext.current()?.cgContext {
			drawFunc(size, context)
		} else {
			fatalError("No context")
		}
		newimg.unlockFocus()
		return newimg
	}

	public var toCGImage: CGImage {
		var imageRect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
		#if swift(>=3.0)
			guard let image = cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else {
				abort()
			}
		#else
			guard let image = CGImageForProposedRect(&imageRect, context: nil, hints: nil) else {
				abort()
			}
		#endif
		return image
	}
}

extension CGImage {
	public var size: CGSize {
		#if swift(>=3.0)
		#else
			let width  = CGImageGetWidth(self)
			let height = CGImageGetHeight(self)
		#endif
		return CGSize(width: width, height: height)
	}

	public var toNSImage: NSImage {
		#if swift(>=3.0)
			return NSImage(cgImage: self, size: size)
		#else
			return NSImage(CGImage: self, size: size)
		#endif
	}
}

#endif

