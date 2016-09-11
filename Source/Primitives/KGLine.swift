/**
 * @file	KGLine.swift
 * @brief	Define KGLine data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics

public struct KGLine {
	public var fromPoint:	CGPoint
	public var toPoint:	CGPoint

	public init(fromPoint fp: CGPoint, toPoint tp: CGPoint){
		fromPoint = fp
		toPoint	  = tp
	}
}

