//
//  UIViewController+JYAnimatedTransitioning.h
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/27.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JYCustomTransitionStyle) {
  JYCustomTransitionStylePopImage = 0,
  JYCustomTransitionStyleOpenDoor,
  JYCustomTransitionStyleMemo
};

typedef NS_ENUM(NSUInteger, JYAnimatedTransitioningState) {
  JYAnimatedTransitioningPresentation = 0,
  JYAnimatedTransitioningDismiss
};

@protocol JYAnimatedTransitioning <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) JYAnimatedTransitioningState state;

@end

@interface UIViewController (JYAnimatedTransitioning)

- (void)jy_setCustomTransitionStyle:(JYCustomTransitionStyle)customTransitionStyle;

@end

NS_ASSUME_NONNULL_END
