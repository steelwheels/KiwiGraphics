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
	var result = true

	let field = KGField(bound: CGRect(origin: CGPoint(x:0.0, y:0.0), size: CGSize(width: 100.0, height: 100.0)))
	let space = KGSpace(field: field, partitionDepth: 3)

	let (spacestr, error) = CNJSONFile.serialize(dictionary: space.serialize())
	if let err = error {
		print("[Error] Failed to serialize: \(err.description)")
		result = false
	} else {
		print("SPACE = \(spacestr)")
	}

	return result
}
