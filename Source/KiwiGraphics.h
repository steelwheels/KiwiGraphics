//
//  KiwiGraphics.h
//  KiwiGraphics
//
//  Created by Tomoo Hamada on 2016/09/11.
//  Copyright © 2016年 Steel Wheels Project. All rights reserved.
//

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
#import <Canary/Canary.h>


