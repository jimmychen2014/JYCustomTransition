//
//  UIColor+Utilities.h
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/22.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CONCAT(X,Y) X ## Y

# ifndef NSUINTEGER_C
#  if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
#   define NSUINTEGER_C(V) CONCAT(V, UL)
#  else
#   define NSUINTEGER_C(V) CONCAT(V, U)
#  endif
# endif

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Utilities)

+ (UIColor *)colorWithHex:(NSUInteger)hex;
+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
