/**
 * @file	KGField.swift
 * @brief	Define KGField data structure
 * @par Copyright
 *   Copyright (C) 2016 Steel Wheels Project
 */

import CoreGraphics

public struct KGField {
	private var mBound : CGRect

	public init(bound b: CGRect){
		mBound = b
	}

	public var bound: CGRect {
		get { return mBound }
	}
}
