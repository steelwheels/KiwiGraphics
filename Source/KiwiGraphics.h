/**
 * @file	KiwiGraphics.h
 * @brief	Bridge for KiwiGraphics
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

#import "TargetConditionals.h"
#if TARGET_OS_IPHONE
#	import <UIKit/UIKit.h>
#else
#	import <Cocoa/Cocoa.h>
#endif

//! Project version number for KiwiGraphics.
FOUNDATION_EXPORT double KiwiGraphicsVersionNumber;

//! Project version string for KiwiGraphics.
FOUNDATION_EXPORT const unsigned char KiwiGraphicsVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <KiwiGraphics/PublicHeader.h>

