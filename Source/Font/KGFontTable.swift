/**
 * @file	KCFontTable.swift
 * @brief	Define KCFontTable class
 * @par Copyright
 *   Copyright (C) 2015 Steel Wheels Project
 */

#if os(iOS)
	import UIKit
	public typealias KGFont = UIFont
#else
	import Cocoa
	public typealias KGFont = NSFont
#endif

public class KGFontTable
{
	public enum FontStyle {
		case Title
		case Headline
		case Body
		case Caption
	}

	public static let sharedFontTable = KGFontTable()

	private let titleSize:		CGFloat		= 22
	private let headlineSize:	CGFloat		= 16
	private let bodySize:		CGFloat		= 14
	private let captionSize:	CGFloat		= 12

	private init() {

	}

	public func font(withStyle style: FontStyle) -> KGFont {
		#if os(OSX)
			var result: KGFont
			switch style {
			case .Title:	result = NSFont.messageFont(ofSize:	titleSize)
			case .Headline:	result = NSFont.boldSystemFont(ofSize:	headlineSize)
			case .Body:	result = NSFont.messageFont(ofSize:	bodySize)
			case .Caption:	result = NSFont.messageFont(ofSize:	captionSize)
			}
			return result
		#else
			var result: KGFont
			switch style {
			case .Title:	result = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
			case .Headline:	result = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
			case .Caption:	result = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
			case .Body:	result = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
			}
			return result
		#endif
	}
}
