//
//  JYViewControllerOpenDoorTransitioning.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/27.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "JYViewControllerOpenDoorTransitioning.h"

NS_ASSUME_NONNULL_BEGIN

@implementation JYViewControllerOpenDoorTransitioning

@synthesize state;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
  return 0.0;
}

- (void)animationEnded:(BOOL)transitionCompleted
{
  
}

@end

NS_ASSUME_NONNULL_END
