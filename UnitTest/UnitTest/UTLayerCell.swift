//
//  UTLayerCell.swift
//  KiwiGraphics
//
//  Created by Tomoo Hamada on 2016/09/10.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import Foundation
import Canary
import KiwiGraphics

public func UTLayerCell() -> Bool
{
	var result = true

	let table = KGLayerCellTable(size: CGSize(width:80.0, height:80.0), depth: 4)

	for depth in 0..<4 {
		print("depth: \(depth)")
		let resolution = pow(base: 2, power: UInt(depth))
		let cellnum    = resolution * resolution
		for i in 0..<cellnum {
			print("- cell no: \(i)/\(cellnum)")
			let index = KGLayerIndex(depth: depth, index: UInt32(i))
			let res   = cellTest(cellTable: table, cellIndex: index)

			result = result && res
		}
	}
	
	return result
}

private func cellTest(cellTable table: KGLayerCellTable, cellIndex index: KGLayerIndex) -> Bool
{
	print("-- index: \(index.description)")
	let cell = table.cell(atIndex: index)

	let (str, err) = CNJSONFile.serialize(dictionary: cell.serialize())
	if let e = err {
		print("--- cell [Error] \(e.description)")
	} else {
		print("--- cell: \(str)")
	}
	return (err == nil)
}
