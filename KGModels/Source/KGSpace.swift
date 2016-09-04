/**
 * @file	KGSpace.swift
 * @brief	Define KGSpace data structure
 * @par Reference
 *	http://marupeke296.com/COL_2D_No8_QuadTree.html
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import Foundation

public struct KGSpace {
	private let mPartitionResolution: Int = 4		/* Partitioned into "r" x "r" spaces		*/

	private var mField:			KGField

	private var mPartitionDepth:		Int
	private var mPartitionNum:		Array<Int>	/* Number of partitions for each depth		*/

	public init(field f:KGField,  partitionDepth d: Int){
		mField			= f
		mPartitionDepth		= d

		mPartitionNum = [1]	/* level 0 has always 1 */
		var partnum = mPartitionResolution
		for _ in 1..<mPartitionDepth {
			mPartitionNum.append(partnum)
			partnum = partnum * mPartitionResolution
		}
	}

	public func addObject(object o: KGModel){
		/* Calculate morton index */
		//let res    = CGFloat(mPartitionNum[mPartitionDepth-1])	/* Deepest resolution */
		//let (ltidx, rbidx) = boundsToMotionIndexes(bounds: o.bounds, resolution: res)
	}

	private func boundsToMotionIndexes(bounds b: CGRect, resolution r:CGFloat) -> (Int, UInt32) {
		let ltidx  = positionToMortonIndex(x: b.minX, y: b.minY, resolution: r)
		let rbidx  = positionToMortonIndex(x: b.maxX, y: b.maxY, resolution: r)

		/* Get depth which has the given bounts in it */
		let xoridx    = ltidx ^ rbidx
		var depth     = 0
		var depthmask = UInt32(0x3 << ((mPartitionDepth-1)*2))
		while true {
			if (xoridx & depthmask) == 0 {
				depth     = depth + 1
				depthmask = depthmask >> 2
			} else {
				break
			}
		}

		/* get common index */
		let comidx = ltidx >> UInt32((mPartitionDepth - depth) * 2)
		return (depth, comidx)
	}

	private func positionToMortonIndex(x xpos:CGFloat, y ypos:CGFloat, resolution r:CGFloat) -> UInt32 {
		let xpos = UInt32(xpos / r)
		let ypos = UInt32(ypos / r)
		return bitSeparate(bits: xpos) | (bitSeparate(bits: ypos)<<1)
	}

	private func bitSeparate(bits v0: UInt32) -> UInt32 {
		let v1 = (v0 | (v0<<8)) & 0x00ff00ff
		let v2 = (v1 | (v1<<4)) & 0x0f0f0f0f
		let v3 = (v2 | (v2<<2)) & 0x33333333
		let v4 = (v3 | (v3<<1)) & 0x55555555
		return v4
	}
}
