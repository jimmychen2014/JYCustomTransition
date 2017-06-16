//
//  JYDoorViewController.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/23.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "JYDoorViewController.h"

#import "JYIndoorViewController.h"

@interface JYDoorViewController () <UIGestureRecognizerDelegate> {
@private
  UIImageView *_imageView;
  UITapGestureRecognizer *_tapGestureRecognizer;
}

@end

@implementation JYDoorViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setTitle:@"开门效果"];

  _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ice"]];
  [_imageView setContentMode:UIViewContentModeScaleAspectFit];
  [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [[self view] addSubview:_imageView];

  [[[_imageView leadingAnchor] constraintEqualToAnchor:[[self view] leadingAnchor]] setActive:YES];
  [[[_imageView trailingAnchor] constraintEqualToAnchor:[[self view] trailingAnchor]] setActive:YES];
  [[[_imageView topAnchor] constraintEqualToAnchor:[[self topLayoutGuide] bottomAnchor]] setActive:YES];
  [[[_imageView bottomAnchor] constraintEqualToAnchor:[[self view] bottomAnchor]] setActive:YES];

  _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
  [_tapGestureRecognizer setDelegate:self];
  [[self view] addGestureRecognizer:_tapGestureRecognizer];
}

#pragma mark - UIGestureRecognizerDelegate

- (void)handleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
  JYIndoorViewController *indoorViewController = [[JYIndoorViewController alloc] initWithSnapshotImage:[self _snapshotImageOfView:[[self navigationController] view] withRect:[[self view] bounds]]];
  [self presentViewController:indoorViewController animated:YES completion:nil];
}

- (UIImage *)_snapshotImageOfView:(UIView *)view withRect:(CGRect)rect
{
  UIGraphicsBeginImageContextWithOptions(rect.size, [view isOpaque], [[UIScreen mainScreen] scale]);
  [view drawViewHierarchyInRect:rect afterScreenUpdates:NO];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

@end
