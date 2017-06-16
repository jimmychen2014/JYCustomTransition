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
    UIImage *image = [UIImage imageNamed:[(JYExpandedPhotoViewController *)toViewController imageName]];

    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect initialImageRect = [(JYExpandedPhotoViewController *)toViewController imageRect];
    CGRect finalImageFrame = [self _clipImageRect:finalFrame ofImage:image];

    animateImageView = [[UIImageView alloc] initWithImage:image];
    [animateImageView setContentMode:UIViewContentModeScaleAspectFill];
    [animateImageView setClipsToBounds:YES];
    [containerView addSubview:animateImageView];

    [[(JYExpandedPhotoViewController *)toViewController imageView] setHidden:YES];
    [toView setAlpha:0.0];
    [containerView insertSubview:toView belowSubview:animateImageView];
    [toView setFrame:finalFrame];

    [animateImageView setFrame:initialImageRect];

    [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{

      [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
        [toView setAlpha:1.0];
      }];
      [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
        [animateImageView setFrame:finalImageFrame];
      }];
    } completion:^(BOOL finished) {
      [animateImageView removeFromSuperview];

      if ([transitionContext transitionWasCancelled]) {
        [toView removeFromSuperview];
      }
      else {
        [[(JYExpandedPhotoViewController *)toViewController imageView] setHidden:NO];
        [transitionContext completeTransition:YES];
      }
    }];
  }
  else {
    UIImage *image = [UIImage imageNamed:[(JYExpandedPhotoViewController *)fromViewController imageName]];

    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromViewController];

    [containerView insertSubview:toView belowSubview:fromView];
    [toView setFrame:finalFrame];

    [[(JYExpandedPhotoViewController *)fromViewController imageView] setHidden:YES];
    CGRect finalImageRect = [(JYExpandedPhotoViewController *)fromViewController imageRect];
    CGRect initialImageRect = [self _clipImageRect:initialFrame ofImage:image];

    animateImageView = [[UIImageView alloc] initWithImage:image];
    [animateImageView setContentMode:UIViewContentModeScaleAspectFill];
    [animateImageView setClipsToBounds:YES];
    [containerView addSubview:animateImageView];

    [animateImageView setFrame:initialImageRect];

    [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{

      [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
        [fromView setAlpha:0.0];
      }];
      [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.8 animations:^{
        [animateImageView setFrame:finalImageRect];
      }];
    } completion:^(BOOL finished) {
      [animateImageView removeFromSuperview];

      if ([transitionContext transitionWasCancelled]) {
        [toView removeFromSuperview];
      }
      else {
        [transitionContext completeTransition:YES];
      }
    }];
  }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
  return 0.5;
}

- (void)animationEnded:(BOOL)transitionCompleted
{

}

#pragma mark -

- (CGRect)_clipImageRect:(CGRect)rect ofImage:(UIImage *)image
{
  CGFloat clipedRatio = rect.size.width / rect.size.height;
  CGFloat imageRatio = image.size.width / image.size.height;

  if (clipedRatio < imageRatio) {
    //mend height
    CGFloat clipHeight = ceilf((rect.size.height - rect.size.width / imageRatio) / 2);
    return CGRectInset(rect, 0.0, clipHeight);
  }
  else {
    CGFloat clipWidth = ceilf((rect.size.width - rect.size.height * imageRatio) / 2);
    return CGRectInset(rect, clipWidth, 0.0);
  }
}

@end

NS_ASSUME_NONNULL_END
