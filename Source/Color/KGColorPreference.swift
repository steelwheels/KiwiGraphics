/**
 * @file	KGColorPreference.m
 * @brief	Define KGColorPreference class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

#if os(iOS)
	import UIKit
#else
	import Cocoa
#endif

public class KGColorPreference
{
	public struct TextColors {
		public var foreground:	KGColor
		public var background:	KGColor
		public init(foreground f:KGColor, background b:KGColor){
			foreground = f
			background = b
		}
	}

	public struct BackgroundColors {
		public var highlight:	KGColor
		public var normal:	KGColor
		public init(highlight hc: KGColor, normal nc: KGColor){
			highlight = hc
			normal    = nc
		}
	}

	public struct ButtonColors {
		public var title:	KGColor
		public var background:	BackgroundColors
		public init(title t:KGColor, background b:BackgroundColors){
			title      = t
			background = b
		}
	}
}
