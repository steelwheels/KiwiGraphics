/**
 * @file	KGCoodinate.swift
 * @brief	Define KGCoodinate class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import Foundation

public func KGOrigin(origin elmorg: CGPoint, size elmsz: CGSize, frame frm: CGRect) -> CGPoint {
	let origin: CGPoint
	#if os(iOS)
		origin = CGPoint(x: elmorg.x, y: frm.size.height - elmsz.height - elmorg.y)
	#else
		origin = elmorg
	#endif
	return origin
}

