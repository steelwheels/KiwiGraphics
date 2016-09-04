//
//  UTSpace.swift
//  KGModels
//
//  Created by Tomoo Hamada on 2016/09/04.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import Foundation
import KGModels
import Canary

public func UTSpace() -> Bool
{
	let field = KGField(bound: CGRect(origin: CGPoint(x:0.0, y:0.0), size: CGSize(width: 80.0, height: 80.0)))
	let space = KGSpace(field: field, partitionDepth: 4)
	let res0 = dumpSpace(space: space)

	let res1 = addObject(space: space, x:  0.0, y:  0.0, radius: 1.0, expectedIndex: KGSpaceIndex(depth: 3, index:  0))
	let res2 = addObject(space: space, x: 40.0, y: 40.0, radius: 1.0, expectedIndex: KGSpaceIndex(depth: 0, index:  0))
	let res3 = addObject(space: space, x: 22.0, y: 22.0, radius: 1.0, expectedIndex: KGSpaceIndex(depth: 3, index: 12))
	let res4 = addObject(space: space, x: 62.0, y: 62.0, radius: 1.0, expectedIndex: KGSpaceIndex(depth: 3, index: 60))
	let res5 = addObject(space: space, x: 50.0, y: 50.0, radius: 1.0, expectedIndex: KGSpaceIndex(depth: 2, index: 12))
	let res6 = addObject(space: space, x: 50.0, y: 60.0, radius: 1.0, expectedIndex: KGSpaceIndex(depth: 1, index:  3))

	return res0 && res1 && res2 && res3 && res4 && res5 && res6
}

private func dumpSpace(space s: KGSpace) -> Bool
{
	var result = true
	let (spacestr, error) = CNJSONFile.serialize(dictionary: s.serialize())
	if let err = error {
		print("[Error] Failed to serialize: \(err.description)")
		result = false
	} else {
		print("SPACE = \(spacestr)")
	}
	return result
}

private func addObject(space s:KGSpace, x xpos:CGFloat, y ypos:CGFloat, radius r: CGFloat, expectedIndex expidx: KGSpaceIndex) -> Bool
{
	let model = KGModel(position: CGPoint(x:xpos, y:ypos), radius: r)
	s.addObject(object: model)

	let realidx = model.spaceIndex

	print("addObject x:\(model.position.x) y:\(model.position.y)")
	if realidx == expidx {
		print(" -> index: \(realidx.description) -> OK")
		return true
	} else {
		print(" -> index: real:\(realidx.description) != expected:\(expidx.description) -> NG")
		return false
	}
}
