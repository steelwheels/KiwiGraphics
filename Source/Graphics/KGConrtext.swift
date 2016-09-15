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
		self.addEllipse(in: eclipse.bounds)
		self.clip()
		let center = eclipse.center
		self.drawRadialGradient(eclipse.gradient,
		                        startCenter: center,
		                        startRadius: eclipse.innerRadius,
		                        endCenter:   center,
		                        endRadius:   eclipse.outerRadius,
		                        options:     .drawsAfterEndLocation)
	}

	public func draw(hexagon hx: KGHexagon) {
		let vertexes   = hx.vertexes
		let vertexnum = vertexes.count
		self.move(to: vertexes[0])
		for i in 1..<vertexnum {
			self.addLine(to: vertexes[i])
		}
	}
}
