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
		self.drawRadialGradient(KGGradient.gradient,
		                        startCenter: center,
		                        startRadius: ec.innerRadius,
		                        endCenter:   center,
		                        endRadius:   ec.outerRadius,
		                        options:     .drawsAfterEndLocation)
	}

	public func draw(hexagon hx: KGHexagon, withGradient wg: Bool = false){
		var vertexes  = hx.vertexes
		vertexes.append(vertexes[0])
		self.addLines(between: vertexes)
		if wg {
			self.clip()
			self.drawLinearGradient(KGGradient.gradient,
			                        start: vertexes[5],
			                        end:   vertexes[2],
			                        options: .drawsAfterEndLocation)
		} else {
			self.strokePath()
		}
	}
}


