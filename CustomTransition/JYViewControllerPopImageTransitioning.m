//
//  JYViewControllerPopImageTransitioning.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/27.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "JYViewControllerPopImageTransitioning.h"

#import "JYExpandedPhotoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation JYViewControllerPopImageTransitioning

@synthesize state;

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  UIView *containerView = [transitionContext containerView];

  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIImageView *animateImageView = nil;

  if ([self state] == JYAnimatedTransitioningPresentation) {
    [toView setAlpha:0.0];
    [[(JYExpandedPhotoViewController *)toViewController imageView] setHidden:YES];
    [containerView addSubview:toView];

    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
//    CGRect expandedFrame = CGRectInset(finalFrame, -20.0, -20.0);

    UIImage *image = [UIImage imageNamed:[(JYExpandedPhotoViewController *)toViewController imageName]];
    CGRect imageRect = [(JYExpandedPhotoViewController *)toViewController imageRect];

    CGRect fixFrame = [self _fixImageRect:imageRect ofImage:image];

    animateImageView = [[UIImageView alloc] initWithImage:image];
    [animateImageView setContentMode:UIViewContentModeScaleAspectFill];
    [animateImageView setFrame:imageRect];
    [containerView addSubview:animateImageView];

    [UIView animateKeyframesWithDuration:2.5 delay:0.0 options:(UIViewKeyframeAnimationOptions)UIViewAnimationOptionCurveEaseInOut animations:^{

      [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.4 animations:^{
        [toView setAlpha:1.0];
      }];

      [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
        [animateImageView setFrame:fixFrame];
      }];

      [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
        [animateImageView setContentMode:UIViewContentModeScaleAspectFit];
        [animateImageView setFrame:finalFrame];
      }];

//      [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
//        [animateImageView setFrame:finalFrame];
//      }];

    } completion:^(BOOL finished) {
      [animateImageView removeFromSuperview];

      if ([transitionContext transitionWasCancelled]) {
        [toView removeFromSuperview];
      }
      else {
        [[(JYExpandedPhotoViewController *)toViewController imageView] setHidden:NO];
      }

      [transitionContext completeTransition:YES];
    }];
  }
  else {
    [fromView removeFromSuperview];
    [transitionContext completeTransition:YES];
  }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
  return 0.0;
}

- (void)animationEnded:(BOOL)transitionCompleted
{

}

#pragma mark - 

- (CGRect)_fixImageRect:(CGRect)rect ofImage:(UIImage *)image
{
  CGFloat clipedRatio = rect.size.width / rect.size.height;
  CGFloat imageRatio = image.size.width / image.size.height;

  if (clipedRatio > imageRatio) {
    //mend width
    CGFloat mendWidth = floorf(rect.size.width * (imageRatio - 1) / 2);
    return CGRectInset(rect, -1 * mendWidth, 0.0);
  }
  else {
    CGFloat mendHeight = (floorf(rect.size.width / imageRatio) - rect.size.height) / 2;
    return CGRectInset(rect, 0.0, -1 * mendHeight);
  }
}

@end

NS_ASSUME_NONNULL_END
