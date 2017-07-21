//
//  JYViewControllerMemoTransitioning.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/6/19.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

#import "JYViewControllerMemoTransitioning.h"

@implementation JYViewControllerMemoTransitioning

@synthesize state;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{

}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
  return 0.5;
}

- (void)animationEnded:(BOOL)transitionCompleted
{
  
}

@end
