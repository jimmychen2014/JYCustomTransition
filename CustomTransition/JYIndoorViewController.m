//
//  JYIndoorViewController.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/4/17.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

#import "JYIndoorViewController.h"

#import "UIViewController+JYAnimatedTransitioning.h"

@interface JYIndoorViewController () <UIGestureRecognizerDelegate> {
@private
  UITapGestureRecognizer *_tapGestureRecognizer;
}

@end

@implementation JYIndoorViewController

- (instancetype)initWithSnapshotImage:(UIImage *)image
{
  if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
    _snapshotImage = image;
    [self jy_setCustomTransitionStyle:JYCustomTransitionStyleOpenDoor];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setTitle:@"关门效果"];

  _indoorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iceland"]];
  [_indoorImageView setContentMode:UIViewContentModeScaleAspectFit];
  [_indoorImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [[self view] addSubview:_indoorImageView];

  [[[_indoorImageView leadingAnchor] constraintEqualToAnchor:[[self view] leadingAnchor]] setActive:YES];
  [[[_indoorImageView trailingAnchor] constraintEqualToAnchor:[[self view] trailingAnchor]] setActive:YES];
  [[[_indoorImageView topAnchor] constraintEqualToAnchor:[[self topLayoutGuide] bottomAnchor]] setActive:YES];
  [[[_indoorImageView bottomAnchor] constraintEqualToAnchor:[[self view] bottomAnchor]] setActive:YES];

  _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
  [_tapGestureRecognizer setDelegate:self];
  [[self view] addGestureRecognizer:_tapGestureRecognizer];
}

#pragma mark - UIGestureRecognizerDelegate

- (void)handleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
