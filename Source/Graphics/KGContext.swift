/**
 * @file	KGContext.swift
 * @brief	Extend CGContext class
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics

extension CGContext
{
	public func draw(eclipse ec: KGEclipse, withGradient Gradient: CGGradient) {
		self.addEllipse(in: ec.bounds)
		self.clip()
		let center = ec.center
		self.drawRadialGradient(Gradient,
		                        startCenter: center,
		                        startRadius: ec.innerRadius,
		                        endCenter:   center,
		                        endRadius:   ec.outerRadius,
		                        options:     .drawsAfterEndLocation)
	}

	public func draw(triangle tr: KGTriangle, withGradient Gradient: CGGradient?){
		let top   = tr.top
		let left  = tr.left
		let right = tr.right
		self.move(to: top)
		self.addLine(to: left)
		self.addLine(to: right)
		self.closePath()
		if let grad = Gradient {
			let bx = (left.x + right.x) / 2.0
			let by = (left.y + right.y) / 2.0
			let bottom = CGPoint(x: bx, y: by)
			self.clip()
			self.drawLinearGradient(grad,
			                        start: top,
			                        end:   bottom,
			                        options: .drawsAfterEndLocation)
		} else {
			self.strokePath()
		}
	}

	public func draw(hexagon hx: KGHexagon, withGradient Gradient: CGGradient?){
		var vertexes  = hx.vertexes
		vertexes.append(vertexes[0])
		self.addLines(between: vertexes)
		if let grad = Gradient {
			self.clip()
			self.drawLinearGradient(grad,
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


