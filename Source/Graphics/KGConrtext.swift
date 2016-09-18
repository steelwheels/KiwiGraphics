/**
 * @file	KGContext.swift
 * @brief	Extend CGContext class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics

extension CGContext
{
	public func draw(eclipse ec: KGEclipse) {
		self.addEllipse(in: ec.bounds)
		self.clip()
		let center = ec.center
		self.drawRadialGradient(ec.gradient,
		                        startCenter: center,
		                        startRadius: ec.innerRadius,
		                        endCenter:   center,
		                        endRadius:   ec.outerRadius,
		                        options:     .drawsAfterEndLocation)
	}

	public func draw(hexagon hx: KGHexagon) {
		let vertexes  = hx.vertexes
		let vertexnum = vertexes.count
		self.move(to: vertexes[0])
		for i in 1..<vertexnum {
			self.addLine(to: vertexes[i])
		}
		self.addLine(to: vertexes[0])
		self.strokePath()
	}
}
