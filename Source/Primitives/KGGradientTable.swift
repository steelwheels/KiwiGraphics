/**
 * @file	KGGradiend.swift
 * @brief	Define KGGradient data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics
import Foundation

public class KGGradientTable
{
	public static let sharedGradientTable = KGGradientTable()

	private var mGradientTable: Dictionary<String, CGGradient>

	private init() {
		mGradientTable = [:]
	}

	public func gradient(forColor color: CGColor, doDebug dd: Bool = false) -> CGGradient {
		let key:String = "\(color.components)"
		if let gradient = mGradientTable[key] {
			return gradient
		} else {
			let newgradient = KGAllocateGradient(baseColor: color, doDebug: dd)
			mGradientTable[key] = newgradient
			return newgradient
		}
	}
}

private func KGAllocateGradient(baseColor color:CGColor, doDebug dd: Bool = false) -> CGGradient
{
	let num    = color.numberOfComponents
	if let source = color.components {
		let count  = Int(5)
		var rate   = CGFloat(1.0)
		let rdiff  = rate / CGFloat(count-1)

		var components: Array<CGFloat> = []
		var locations:  Array<CGFloat> = []
		for _ in 0..<count {
			for j in 0..<num {
				components.append(source[j] * rate)
			}
			locations.insert(rate, at: 0)
			rate -= rdiff
		}

		if dd {
			dumpForDebug(componentNum: num, count: count, components: components, locations: locations)
		}

		let colorspace = CGColorSpaceCreateDeviceRGB()
		if let gradient = CGGradient(colorSpace: colorspace, colorComponents: components, locations: locations, count: count){
			return gradient
		}
	}
	fatalError("Can not allocate gradient")
}

private func dumpForDebug(componentNum num: Int, count cnt:Int, components comp: Array<CGFloat>, locations loc: Array<CGFloat>) {
	Swift.print("componentNum=\(num), count=\(cnt)")
	Swift.print("components:")
	for i in 0..<cnt {
		for j in 0..<num {
			let v = comp[i*num + j]
			Swift.print("\(v) ", terminator: "")
		}
		Swift.print("")
	}
	Swift.print("locations: \(loc)")
}
