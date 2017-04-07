/**
 * @file	KGRectExtension.swift
 * @brief	Extend CGRect class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation

#if os(iOS)
	public typealias KGRect = CGRect
#else
	public typealias KGRect = NSRect
#endif

public enum KGHolizontalAlignment {
	case left
	case center
	case right
}

public enum KGVerticalAlignment {
	case top
	case middle
	case bottom
}

extension CGRect
{
	public var center: CGPoint {
		let x = self.origin.x + (self.size.width  / 2)
		let y = self.origin.y + (self.size.height / 2)
		return CGPoint(x: x, y:y)
	}

	public func centeringIn(bounds bnds: CGRect) -> CGRect {
		let dx = (bnds.size.width  - self.size.width ) / 2.0
		let dy = (bnds.size.height - self.size.height) / 2.0
		let neworigin = CGPoint(x: bnds.origin.x + dx, y: bnds.origin.y + dy)
		return CGRect(origin: neworigin, size: self.size)
	}

	public func resize(size s:CGSize) -> CGRect {
		return CGRect(origin: self.origin, size: s)
	}

	public func move(dx x: CGFloat, dy y: CGFloat) -> CGRect {
		let neworigin = self.origin.move(dx: x, dy: y)
		return CGRect(origin: neworigin, size: self.size)
	}

	public func splitByHolizontally() -> (CGRect, CGRect) {
		let width   = self.size.width
		let height  = self.size.height / 2.0
		let origin0 = self.origin
		let origin1 = CGPoint(x: origin0.x, y: origin0.y + height)
		let size    = CGSize(width: width, height: height)
		return (CGRect(origin: origin0, size: size), CGRect(origin: origin1, size: size))
	}

	public func splitByVertically() -> (CGRect, CGRect) {
		let width   = self.size.width / 2.0
		let height  = self.size.height
		let origin0 = self.origin
		let origin1 = CGPoint(x: origin0.x + width, y: origin0.y)
		let size    = CGSize(width: width, height: height)
		return (CGRect(origin: origin0, size: size), CGRect(origin: origin1, size: size))
	}

	public static func pointsToRect(fromPoint fp:CGPoint, toPoint tp:CGPoint) -> CGRect {
		var x, y, width, height: CGFloat
		if fp.x >= tp.x {
			x     = tp.x
			width = fp.x - tp.x
		} else {
			x     = fp.x
			width = tp.x - fp.x
		}
		if fp.y >= tp.y {
			y      = tp.y
			height = fp.y - tp.y
		} else {
			y      = fp.y
			height = tp.y - fp.y
		}
		return CGRect(x: x, y: y, width: width, height: height)
	}

	public var description: String {
		let ostr = origin.description
		let sstr = size.description
		return "{origin:\(ostr) size:\(sstr)}"
	}
}

public func KGAlignRect(holizontalAlignment halign: KGHolizontalAlignment,
                        verticalAlignment   valign: KGVerticalAlignment,
                        targetSize	    target: CGSize,
                        in		    bounds: CGRect) -> CGRect
{
	let offx: CGFloat
	switch halign {
	case .left:	offx = bounds.origin.x
	case .center:	offx = bounds.origin.x + (bounds.size.width - target.width) / 2.0
	case .right:	offx = bounds.origin.x +  bounds.size.width - target.width
	}
	let offy: CGFloat
	switch valign {
	case .top:	offy = bounds.origin.y +  bounds.size.height - target.height
	case .middle:	offy = bounds.origin.y + (bounds.size.height - target.height) / 2.0
	case .bottom:	offy = bounds.origin.y
	}
	return CGRect(x: offx, y: offy, width: target.width, height: target.height)
}


