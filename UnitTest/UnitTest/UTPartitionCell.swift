//
//  UTPartitionCell.swift
//  KiwiGraphics
//
//  Created by Tomoo Hamada on 2016/09/10.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

import Foundation
import Canary
import KiwiGraphics

public func UTPartitionCell() -> Bool
{
	var result = true

	let table = KGPartitionCellTable(size: CGSize(width:80.0, height:80.0), depth: 4)

	for depth in 0..<4 {
		print("depth: \(depth)")
		let resolution = pow(base: 2, power: UInt(depth))
		let cellnum    = resolution * resolution
		for i in 0..<cellnum {
			print("- cell no: \(i)/\(cellnum)")
			let index = KGPartitionIndex(depth: depth, index: UInt32(i))
			let res   = cellTest(cellTable: table, cellIndex: index)

			result = result && res
		}
	}
	
	return result
}

private func cellTest(cellTable table: KGPartitionCellTable, cellIndex index: KGPartitionIndex) -> Bool
{
	print("-- index: \(index.description)")
	let cell = table.cell(atIndex: index)
	print("--- cell \(cell.bounds.origin.description)")
	return true
}
