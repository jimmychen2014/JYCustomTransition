//
//  JYMemoViewController.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/6/16.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

#import "JYMemoViewController.h"

#import "UIViewController+JYAnimatedTransitioning.h"

@interface _JYMemoViewController_PresentationController : UIPresentationController <UIGestureRecognizerDelegate> {
@private
  UIView *_backgroundView;
  UITapGestureRecognizer *_tapGestureRecognizer;
}

@end

@interface _JYMemoViewControllerTransitioning : NSObject <JYAnimatedTransitioning>

@end

@interface JYMemoViewController () <UIViewControllerTransitioningDelegate> {
@private
  UILabel *_memoLabel;
  UILabel *_tintLabel;
}

@end

@implementation JYMemoViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) != nil) {
    [self setModalPresentationStyle:UIModalPresentationCustom];
    [self setTransitioningDelegate:self];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [[self view] setBackgroundColor:[UIColor whiteColor]];

  _memoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  [_memoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_memoLabel setText:@"这是一条便笺"];
  [_memoLabel setLineBreakMode:NSLineBreakByTruncatingTail];
  [_memoLabel setNumberOfLines:0];
  [[self view] addSubview:_memoLabel];

  [[[_memoLabel centerXAnchor] constraintEqualToAnchor:[[self view] centerXAnchor]] setActive:YES];
  [[[_memoLabel topAnchor] constraintEqualToAnchor:[[self topLayoutGuide] bottomAnchor] constant:10.0] setActive:YES];

  _tintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  [_tintLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_tintLabel setText:@"点击灰色半透明区域退出当前页面"];
  [_tintLabel setLineBreakMode:NSLineBreakByTruncatingTail];
  [_tintLabel setNumberOfLines:0];
  [[self view] addSubview:_tintLabel];

  [[[_tintLabel centerXAnchor] constraintEqualToAnchor:[[self view] centerXAnchor]] setActive:YES];
  [[[_tintLabel topAnchor] constraintEqualToAnchor:[_memoLabel bottomAnchor] constant:50.0] setActive:YES];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
  _JYMemoViewControllerTransitioning *transitioning = [[_JYMemoViewControllerTransitioning alloc] init];
  [transitioning setState:JYAnimatedTransitioningPresentation];

  return transitioning;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
  _JYMemoViewControllerTransitioning *transitioning = [[_JYMemoViewControllerTransitioning alloc] init];
  [transitioning setState:JYAnimatedTransitioningDismiss];

  return transitioning;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
  return [[_JYMemoViewController_PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end

@implementation _JYMemoViewControllerTransitioning

@synthesize state;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
  UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
  UIView *containerView = [transitionContext containerView];

  if ([self state] == JYAnimatedTransitioningPresentation) {
    const CGRect endFrame = [transitionContext finalFrameForViewController:toViewController];
    const CGRect startFrame = CGRectOffset(endFrame, 0.0, CGRectGetHeight(endFrame));

    [toView setFrame:startFrame];
    [toView setAlpha:0.0f];
    [containerView addSubview:toView];

    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn animations:^{
      [toView setFrame:endFrame];
      [toView setAlpha:1.0];
    } completion:^(BOOL finished) {
      if ([transitionContext transitionWasCancelled]) {
        [toView removeFromSuperview];
      }

      [transitionContext completeTransition:YES];
    }];
  }
  else {
    const CGRect startFrame = [transitionContext initialFrameForViewController:fromViewController];
    const CGRect endFrame = CGRectOffset(startFrame, 0.0, CGRectGetHeight(startFrame));

    [fromView setFrame:startFrame];
    [fromView setAlpha:0.0f];
    [containerView addSubview:toView];

    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn animations:^{
      [fromView setFrame:endFrame];
      [fromView setAlpha:1.0];
    } completion:^(BOOL finished) {
      if ([transitionContext transitionWasCancelled]) {
        [toView removeFromSuperview];
      }

      [transitionContext completeTransition:YES];
    }];
  }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
  return 0.2;
}

@end

@implementation _JYMemoViewController_PresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(nullable UIViewController *)presentingViewController
{
  if ((self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) != nil) {
    _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [_backgroundView setUserInteractionEnabled:NO];
    [_backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];

    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTapGestureRecognizer:)];
    [_tapGestureRecognizer setDelegate:self];
  }

  return self;
}

- (CGRect)frameOfPresentedViewInContainerView
{
  CGFloat height = fmin(CGRectGetHeight([[self containerView] frame]), 500.0);
  return CGRectMake(0.0, CGRectGetMaxY([[self containerView] frame]) - height, CGRectGetWidth([[self containerView] frame]), height);
}

- (void)presentationTransitionWillBegin
{
  [super presentationTransitionWillBegin];

  [_backgroundView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
  [_backgroundView setAlpha:0.0];
  [[self containerView] addSubview:_backgroundView];

  [[[_backgroundView topAnchor] constraintEqualToAnchor:[[self containerView] topAnchor]] setActive:YES];
  [[[_backgroundView bottomAnchor] constraintEqualToAnchor:[[self containerView] bottomAnchor]] setActive:YES];
  [[[_backgroundView leadingAnchor] constraintEqualToAnchor:[[self containerView] leadingAnchor]] setActive:YES];
  [[[_backgroundView trailingAnchor] constraintEqualToAnchor:[[self containerView] trailingAnchor]] setActive:YES];

  [[[self presentingViewController] transitionCoordinator] animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext>  context) {
    [_backgroundView setAlpha:1.0];
  } completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
    if ([context isCancelled]) {
      [[[self presentedView] layer] setShadowOpacity:0.0f];
      [_backgroundView setAlpha:0.0];
    }
  }];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
  if (completed) {
    [[self containerView] addGestureRecognizer:_tapGestureRecognizer];
  }

  [super presentationTransitionDidEnd:completed];
}

- (void)dismissalTransitionWillBegin
{
  [super dismissalTransitionWillBegin];

  [[self containerView] removeGestureRecognizer:_tapGestureRecognizer];

  [[[self presentingViewController] transitionCoordinator] animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
    [[[self presentedView] layer] setShadowOpacity:0.0f];
    [_backgroundView setAlpha:0.0];
  } completion:^(id <UIViewControllerTransitionCoordinatorContext> context) {
    if ([context isCancelled]) {
      [[[self presentedView] layer] setShadowOpacity:1.0f];
      [_backgroundView setAlpha:1.0];
    }
    else {
      [_backgroundView removeFromSuperview];
    }
  }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
  if (!completed) {
    [[self containerView] addGestureRecognizer:_tapGestureRecognizer];
  }

  [super dismissalTransitionDidEnd:completed];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
  [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

  [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
    [[self presentedView] setFrame:CGRectMake(CGRectGetMinX([[self containerView] frame]),  CGRectGetMinY([[self containerView] frame]) + fmax(size.height - 500.0, 0.0), CGRectGetWidth([[self containerView] frame]), CGRectGetHeight([[self containerView] frame]) - fmax(size.height - 500.0, 0.0))];
  } completion:nil];
}

- (void)_handleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
  [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  if (gestureRecognizer == _tapGestureRecognizer) {
    if ([touch view] != nil) {
      return [touch view] != [self presentedView] && ![[touch view] isDescendantOfView:[self presentedView]];
    }
  }
  
  return YES;
}

@end
