//
//  UIColor+Utilities.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/22.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "UIColor+Utilities.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIColor (Utilities)

+ (UIColor *)colorWithHex:(NSUInteger)hex
{
  return [UIColor colorWithHex:hex alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha
{
  return [UIColor colorWithRed:(CGFloat)((NSUINTEGER_C(0x00FF0000) & hex) >> NSUINTEGER_C(16)) / UINT8_MAX
                         green:(CGFloat)((NSUINTEGER_C(0x0000FF00) & hex) >> NSUINTEGER_C( 8)) / UINT8_MAX
                          blue:(CGFloat)((NSUINTEGER_C(0x000000FF) & hex) >> NSUINTEGER_C( 0)) / UINT8_MAX
                         alpha:alpha];
}

@end

NS_ASSUME_NONNULL_END
