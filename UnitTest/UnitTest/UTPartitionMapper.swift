//
//  UTPartitionMapper.swift
//  KiwiGraphics
//
//  Created by Tomoo Hamada on 2016/09/04.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import Foundation
import KiwiGraphics
import Canary

public func UTPartitionMapper() -> Bool
{
	let bounds = CGRect(origin: CGPoint(x:0.0, y:0.0), size: CGSize(width: 80.0, height: 80.0))
	let layer  = KGPartitionLayer(bounds: bounds, partitionDepth: 4)
	let res0   = dumpLayer(layer: layer)

	let res1 = addObject(layer: layer, x:  0.0, y:  0.0, radius: 1.0, expectedIndex: KGPartitionIndex(depth: 3, index:  0))
	let res2 = addObject(layer: layer, x: 40.0, y: 40.0, radius: 1.0, expectedIndex: KGPartitionIndex(depth: 0, index:  0))
	let res3 = addObject(layer: layer, x: 22.0, y: 22.0, radius: 1.0, expectedIndex: KGPartitionIndex(depth: 3, index: 12))
	let res4 = addObject(layer: layer, x: 62.0, y: 62.0, radius: 1.0, expectedIndex: KGPartitionIndex(depth: 3, index: 60))
	let res5 = addObject(layer: layer, x: 50.0, y: 50.0, radius: 1.0, expectedIndex: KGPartitionIndex(depth: 2, index: 12))
	let res6 = addObject(layer: layer, x: 50.0, y: 60.0, radius: 1.0, expectedIndex: KGPartitionIndex(depth: 1, index:  3))

	return res0 && res1 && res2 && res3 && res4 && res5 && res6
}

private func dumpLayer(layer l: KGPartitionLayer) -> Bool
{
	var result = true
	let (spacestr, error) = CNJSONFile.serialize(dictionary: l.serialize())
	if let err = error {
		print("[Error] Failed to serialize: \(err.description)")
		result = false
	} else {
		print("SPACE = \(spacestr)")
	}
	return result
}

private func addObject(layer l:KGPartitionLayer, x xpos:CGFloat, y ypos:CGFloat, radius r: CGFloat, expectedIndex expidx: KGPartitionIndex) -> Bool
{
	let model   = KGCircle(center: CGPoint(x:xpos, y:ypos), radius: r)
	let realidx = KGPartitionMapper.mapBounds(bounds: model.bounds, in: l)

	print("addObject \(model.description)")
	if realidx == expidx {
		print(" -> index: \(realidx.description) -> OK")
		return true
	} else {
		print(" -> index: real:\(realidx.description) != expected:\(expidx.description) -> NG")
		return false
	}
}
