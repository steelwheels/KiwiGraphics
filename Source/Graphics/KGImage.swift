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
import UIKit
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

#endif

#if os(iOS)

extension UIImage
{
	public class func generate(size:CGSize, drawFunc: KGImageDrawer) -> UIImage {
		var newimage: UIImage? = nil

		UIGraphicsBeginImageContext(size)

		if let context = UIGraphicsGetCurrentContext() {
			context.saveGState()
			#if os(iOS)
				context.translateBy(x: 0.0, y: size.height)
				context.scaleBy(x: 1.0, y: -1.0)
			#endif
			drawFunc(size, context)
			newimage = UIGraphicsGetImageFromCurrentImageContext()
			context.restoreGState()
		}

		UIGraphicsEndImageContext()

		if let result = newimage {
			return result
		} else {
			fatalError("Can not get current context")
		}
	}

	public var toCGImage: CGImage {
		if let cgimg = self.cgImage {
			return cgimg
		} else {
			fatalError("Can not convert to CGImage")
		}
	}
}

#endif

extension CGImage {
	public var size: CGSize {
		#if swift(>=3.0)
		#else
			let width  = CGImageGetWidth(self)
			let height = CGImageGetHeight(self)
		#endif
		return CGSize(width: width, height: height)
	}

	#if os(OSX)
	public var toNSImage: NSImage {
		#if swift(>=3.0)
			return NSImage(cgImage: self, size: size)
		#else
			return NSImage(CGImage: self, size: size)
		#endif
	}
	#endif
}


