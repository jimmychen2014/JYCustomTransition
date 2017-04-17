//
//  JYPhotoViewController.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/23.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "JYPhotoViewController.h"

#import "UIColor+Utilities.h"
#import "JYExpandedPhotoViewController.h"

@interface PhotoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end

@interface JYPhotoViewController () <UICollectionViewDelegateFlowLayout> {
  UIImageView *_imageView;
  UIImage *_image;
  UITapGestureRecognizer *_tapGestureRecognizer;

  NSArray<NSString *> *_images;
}

@end

@implementation JYPhotoViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) != nil) {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout: [[UICollectionViewFlowLayout alloc] init]];
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [self setCollectionView:collectionView];

    _images = @[@"leaf", @"pumpkin", @"dolphin"];
    [[self collectionView] registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [[self view] setBackgroundColor:[UIColor colorWithHex:0xF8F8F8]];
  [self setTitle:@"照片效果"];

  [[self collectionView] reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];

  [[self collectionView] reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [_images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  [[cell imageView] setImage:[UIImage imageNamed:_images[indexPath.item]]];

  return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  PhotoCell *cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
  CGRect imageFrame = [[cell imageView] frame];

  imageFrame = [cell convertRect:imageFrame toView:nil];
  JYExpandedPhotoViewController *viewController = [[JYExpandedPhotoViewController alloc] initWithImageName:_images[indexPath.item] startImageRect:imageFrame];

  [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(85, 85);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  return UIEdgeInsetsMake(20, 30, 20, 30);
}

@end

@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame]) != nil) {
    _imageView = [[UIImageView alloc] initWithImage:nil];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setClipsToBounds:YES];
    [[self contentView] addSubview:_imageView];
  }

  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  CGRect bounds = [[self contentView] bounds];
  CGRect frame = _imageView.frame;

  frame.origin.x = CGRectGetMinX(bounds);
  frame.origin.y = CGRectGetMinY(bounds);
  frame.size.width = CGRectGetWidth(bounds);
  frame.size.height = CGRectGetHeight(bounds);

  [_imageView setFrame:frame];

}

@end
