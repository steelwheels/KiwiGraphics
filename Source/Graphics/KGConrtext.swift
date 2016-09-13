/**
 * @file	KGContext.swift
 * @brief	Extend CGContext class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Cocoa

extension CGContext
{
	public func draw(eclipse: KGEclipse) {
		self.saveGState()
		self.addEllipse(in: eclipse.bounds)
		self.clip()
		let center = eclipse.center
		self.drawRadialGradient(eclipse.gradient,
		                        startCenter: center,
		                        startRadius: eclipse.innerRadius,
		                        endCenter:   center,
		                        endRadius:   eclipse.outerRadius,
		                        options:     .drawsAfterEndLocation)

		self.restoreGState()
	}
}
