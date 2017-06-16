//
//  JYViewControllerOpenDoorTransitioning.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/27.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "JYViewControllerOpenDoorTransitioning.h"

#import "JYDoorViewController.h"
#import "JYIndoorViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation JYViewControllerOpenDoorTransitioning

@synthesize state;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
  UIView *containerView = [transitionContext containerView];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

  const CGRect initialFrame = [transitionContext initialFrameForViewController:fromViewController];
  const CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];

  if ([self state] == JYAnimatedTransitioningPresentation) {
    [containerView addSubview:toView];

    const UIImageView *indoorImageView = [(JYIndoorViewController *)toViewController indoorImageView];
    UIImage *snapshotImage = [(JYIndoorViewController *)toViewController snapshotImage];
    const CGSize size = [snapshotImage size];

    CGRect leftRect = CGRectMake(CGRectGetMinX(initialFrame), CGRectGetMinY(initialFrame), CGRectGetWidth(initialFrame) / 2, CGRectGetHeight(initialFrame));
    UIImageView *leftImageView = [self _cropImageViewOfImage:snapshotImage withRect:CGRectMake(0.0, 0.0, size.width / 2.0, size.height)];
    [[leftImageView layer] setAnchorPoint:CGPointMake(0.0, 0.5)];
    [leftImageView setFrame:leftRect];
    [leftImageView setContentMode:UIViewContentModeScaleAspectFit];
    [containerView insertSubview:leftImageView aboveSubview:toView];


    CGRect rightRect = CGRectMake(CGRectGetMinX(initialFrame) + CGRectGetWidth(initialFrame) / 2, CGRectGetMinY(initialFrame), CGRectGetWidth(initialFrame) / 2, CGRectGetHeight(initialFrame));
    UIImageView *rightImageView = [self _cropImageViewOfImage:snapshotImage withRect:CGRectMake(size.width / 2.0, 0.0, size.width / 2.0, size.height)];
    [[rightImageView layer] setAnchorPoint:CGPointMake(1.0, 0.5)];
    [rightImageView setFrame:rightRect];
    [rightImageView setContentMode:UIViewContentModeScaleAspectFit];
    [containerView insertSubview:rightImageView aboveSubview:toView];

    UIImageView *fakeImageView = [[UIImageView alloc] initWithImage:[[indoorImageView image] copy]];
    [fakeImageView setFrame:CGRectMake(0.0, 20.0, CGRectGetWidth(finalFrame), CGRectGetHeight(finalFrame) - 20.0)];
    [fakeImageView setContentMode:UIViewContentModeScaleAspectFit];
    [containerView addSubview:fakeImageView];

    CATransform3D leftRotateTransform = CATransform3DIdentity;
    leftRotateTransform.m34 = 4.5 / -2000;
    leftRotateTransform = CATransform3DRotate(leftRotateTransform, 90.0 * M_PI / 180.0f, 0, 1.0, 0);

    CATransform3D rightRotateTransform = CATransform3DIdentity;
    rightRotateTransform.m34 = 4.5 / -2000;
    rightRotateTransform = CATransform3DRotate(rightRotateTransform, -90.0 * M_PI / 180.0f, 0, 1.0, 0);

    CATransform3D diveTransform = CATransform3DTranslate(CATransform3DIdentity, 0.0, 0.0, -CGRectGetWidth(initialFrame) / 2);
    [[fakeImageView layer] setTransform:diveTransform];

    [fromView setHidden:YES];
    [toView setHidden:YES];

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      [[leftImageView layer] setTransform:leftRotateTransform];
      [[rightImageView layer] setTransform:rightRotateTransform];
    } completion:^(BOOL finished) {
      if ([transitionContext transitionWasCancelled]) {
        [toView removeFromSuperview];
      }
      else {
        [toView setHidden:NO];
        [fromView removeFromSuperview];
      }

      [fakeImageView removeFromSuperview];
      [leftImageView removeFromSuperview];
      [rightImageView removeFromSuperview];
      [transitionContext completeTransition:YES];
    }];
  }
  else {
    [containerView addSubview:toView];

    const UIImageView *indoorImageView = [(JYIndoorViewController *)fromViewController indoorImageView];
    UIImage *snapshotImage = [(JYIndoorViewController *)fromViewController snapshotImage];
    const CGSize size = [snapshotImage size];

    CGRect leftRect = CGRectMake(CGRectGetMinX(finalFrame), CGRectGetMinY(finalFrame), CGRectGetWidth(finalFrame) / 2, CGRectGetHeight(finalFrame));
    UIImageView *leftImageView = [self _cropImageViewOfImage:snapshotImage withRect:CGRectMake(0.0, 0.0, size.width / 2.0, size.height)];
    [[leftImageView layer] setAnchorPoint:CGPointMake(0.0, 0.5)];
    [leftImageView setFrame:leftRect];
    [leftImageView setContentMode:UIViewContentModeScaleAspectFit];
    [containerView addSubview:leftImageView];


    CGRect rightRect = CGRectMake(CGRectGetMinX(finalFrame) + CGRectGetWidth(finalFrame) / 2, CGRectGetMinY(finalFrame), CGRectGetWidth(finalFrame) / 2, CGRectGetHeight(finalFrame));
    UIImageView *rightImageView = [self _cropImageViewOfImage:snapshotImage withRect:CGRectMake(size.width / 2.0, 0.0, size.width / 2.0, size.height)];
    [[rightImageView layer] setAnchorPoint:CGPointMake(1.0, 0.5)];
    [rightImageView setFrame:rightRect];
    [rightImageView setContentMode:UIViewContentModeScaleAspectFit];
    [containerView addSubview:rightImageView];

    UIImageView *fakeImageView = [[UIImageView alloc] initWithImage:[[indoorImageView image] copy]];
    [fakeImageView setFrame:CGRectMake(0.0, 20.0, CGRectGetWidth(finalFrame), CGRectGetHeight(finalFrame) - 20.0)];
    [fakeImageView setContentMode:UIViewContentModeScaleAspectFit];
    [containerView addSubview:fakeImageView];

    CATransform3D leftRotateTransform = CATransform3DIdentity;
    leftRotateTransform.m34 = 4.5 / -2000;
    leftRotateTransform = CATransform3DRotate(leftRotateTransform, 90.0 * M_PI / 180.0f, 0, 1.0, 0);
    [[leftImageView layer] setTransform:leftRotateTransform];

    CATransform3D rightRotateTransform = CATransform3DIdentity;
    rightRotateTransform.m34 = 4.5 / -2000;
    rightRotateTransform = CATransform3DRotate(rightRotateTransform, -90.0 * M_PI / 180.0f, 0, 1.0, 0);
    [[rightImageView layer] setTransform:rightRotateTransform];

    CATransform3D diveTransform = CATransform3DTranslate(CATransform3DIdentity, 0.0, 0.0, -CGRectGetWidth(initialFrame) / 2);
    [[fakeImageView layer] setTransform:diveTransform];

    [fromView setHidden:YES];
    [toView setHidden:YES];

    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      [[leftImageView layer] setTransform:CATransform3DIdentity];
      [[rightImageView layer] setTransform:CATransform3DIdentity];
    } completion:^(BOOL finished) {
      if ([transitionContext transitionWasCancelled]) {
        [toView removeFromSuperview];
      }
      else {
        [toView setHidden:NO];
        [fromView removeFromSuperview];
      }

      [fakeImageView removeFromSuperview];
      [leftImageView removeFromSuperview];
      [rightImageView removeFromSuperview];
      [transitionContext completeTransition:YES];
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

- (UIImageView *)_cropImageViewOfImage:(UIImage *)image withRect:(CGRect)rect
{
  CGFloat scale = [[UIScreen mainScreen] scale];
  CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale));
  UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];

  return [[UIImageView alloc] initWithImage:croppedImage];
}

- (UIImage *)_snapshotImageOfView:(UIView *)view withRect:(CGRect)rect
{
  UIGraphicsBeginImageContextWithOptions(rect.size, [view isOpaque], [[UIScreen mainScreen] scale]);
  [view drawViewHierarchyInRect:rect afterScreenUpdates:YES];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

@end

NS_ASSUME_NONNULL_END
