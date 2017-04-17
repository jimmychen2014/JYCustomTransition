//
//  JYExpandedPhotoViewController.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/27.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "JYExpandedPhotoViewController.h"

#import "UIViewController+JYAnimatedTransitioning.h"
#import "UIColor+Utilities.h"

@interface JYExpandedPhotoViewController () <UIGestureRecognizerDelegate> {
  UIButton *_closeButton;
  UIImageView *_imageView;

  UITapGestureRecognizer *_tapGestureRecognizer;
}

@end

@implementation JYExpandedPhotoViewController

- (instancetype)initWithImageName:(NSString *)imageName startImageRect:(CGRect)imageRect
{
  if ((self = [super initWithNibName:nil bundle:nil]) != nil) {
    _imageName = imageName;
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageName]];
    _imageRect = imageRect;

    [[self navigationController] setNavigationBarHidden:YES];
    [self jy_setCustomTransitionStyle:JYCustomTransitionStylePopImage];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [[self view] setBackgroundColor:[UIColor colorWithHex:0x000000]];

  _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTapGestureRecognizer:)];
  [_tapGestureRecognizer setDelegate:self];
  [[self view] addGestureRecognizer:_tapGestureRecognizer];

  [_imageView setContentMode:UIViewContentModeScaleAspectFit];
  [_imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [[self view] insertSubview:_imageView atIndex:0];

  [[[_imageView leadingAnchor] constraintEqualToAnchor:[[self view] leadingAnchor]] setActive:YES];
  [[[_imageView trailingAnchor] constraintEqualToAnchor:[[self view] trailingAnchor]] setActive:YES];
  [[[_imageView bottomAnchor] constraintEqualToAnchor:[[self view] bottomAnchor]] setActive:YES];
  [[[_imageView topAnchor] constraintEqualToAnchor:[[self view] topAnchor]] setActive:YES];
}

- (void)_handleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
