/**
 * @file	KGLayerIndex.swift
 * @brief	Define KGLayerIndex data structure
 * @par Reference
 *	http://marupeke296.com/COL_2D_No8_QuadTree.html
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation

public struct KGLayerIndex {
	public var depth	: Int
	public var index	: UInt32

	public init(depth d:Int, index i:UInt32){
		depth	= d
		index	= i
	}

	public var description: String {
		let dstr = NSString(format: "%u", depth)
		let istr = NSString(format: "%u", index)
		return "(depth:\(dstr), index:\(istr))"
	}
}

public func == (left: KGLayerIndex, right: KGLayerIndex) -> Bool
{
	return (left.depth == right.depth) && (left.index == right.index)
}

public func != (left: KGLayerIndex, right: KGLayerIndex) -> Bool
{
	return (left.depth != right.depth) || (left.index != right.index)
}

