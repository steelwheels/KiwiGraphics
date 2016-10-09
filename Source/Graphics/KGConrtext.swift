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

	public typealias KGDrawEdgeCallback = (_ context: CGContext, _ from: CGPoint, _ to: CGPoint) -> Void
	
	public func draw(vertices vs: KGVertices, edgeDrawer drawer: KGDrawEdgeCallback, edges: Array<(Int, Int)>){
		let vertices = vs.vertices
		let count = vertices.count
		for (f, t) in edges {
			if f < count && t < count {
				drawer(self, vertices[f], vertices[t])
			} else {
				NSLog("Invalid vertex index")
			}
		}
		self.strokePath()
	}
}


