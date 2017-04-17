//
//  UIViewController+JYAnimatedTransitioning.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/27.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "UIViewController+JYAnimatedTransitioning.h"

#import "JYViewControllerPopImageTransitioning.h"
#import "JYViewControllerOpenDoorTransitioning.h"

#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation UIViewController (AnimatedTransitioning)

- (void)jm_setCustomAnimatedTransitioning:(id <JYAnimatedTransitioning>)animatedTransitioning
{
  objc_setAssociatedObject(self, @selector(jm_customAnimatedTransitioning), animatedTransitioning, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id <JYAnimatedTransitioning>)jm_customAnimatedTransitioning
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)jy_setCustomTransitionStyle:(JYCustomTransitionStyle)customTransitionStyle
{
  [self setModalPresentationStyle:UIModalPresentationCustom];

  Class transitioningClass = nil;
  switch (customTransitionStyle) {
    case JYCustomTransitionStylePopImage:
      transitioningClass = [JYViewControllerPopImageTransitioning class];
      break;

    case JYCustomTransitionStyleOpenDoor:
      transitioningClass = [JYViewControllerOpenDoorTransitioning class];
      break;

    default:
      break;
  }

  [self jm_setCustomAnimatedTransitioning:[[transitioningClass alloc] init]];
  [self setTransitioningDelegate:self];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
  id <JYAnimatedTransitioning> animatedTransition = [self jm_customAnimatedTransitioning];
  [animatedTransition setState:JYAnimatedTransitioningPresentation];

  return animatedTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
  id <JYAnimatedTransitioning> animatedTransition = [self jm_customAnimatedTransitioning];
  [animatedTransition setState:JYAnimatedTransitioningDismiss];

  return animatedTransition;
  return nil;
}

@end

NS_ASSUME_NONNULL_END
