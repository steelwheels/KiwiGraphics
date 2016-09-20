/**
 * @file	KGGradiend.swift
 * @brief	Define KGGradient data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics
import Foundation

public struct KGGradient
{
	static let mGradient = allocateGradient()

	static var gradient: CGGradient {
		get { return mGradient }
	}

	static private func allocateGradient() -> CGGradient {
		let colorspace = CGColorSpaceCreateDeviceRGB()
		let components: Array<CGFloat> = [
			1.0, 1.0, 1.0, 1.0,
			0.5, 0.5, 0.5, 1.0,
			0.0, 0.0, 0.0, 1.0,
			]
		let locations: Array<CGFloat> = [0.0, 0.5, 1.0]
		let count = components.count / 4
		if let gradient = CGGradient(colorSpace: colorspace, colorComponents: components, locations: locations, count: count) {
			return gradient
		} else {
			fatalError("Can not allocate gradient")
		}
	}
}
