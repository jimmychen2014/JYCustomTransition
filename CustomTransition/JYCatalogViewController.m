//
//  JYCatalogViewController.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/23.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "JYCatalogViewController.h"

#import "UIViewController+JYAnimatedTransitioning.h"
#import "JYPhotoViewController.h"
#import "JYDoorViewController.h"

@interface JYCatalogViewController () <UITableViewDelegate, UITableViewDataSource> {
@private
  UITableView *_tableView;
  NSArray<NSDictionary<NSNumber *, NSString *> *> *_demoArray;
  NSString *_cellIdentifier;
}

@end

@implementation JYCatalogViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setTitle:@"目录"];
  [self setAutomaticallyAdjustsScrollViewInsets:NO];

  _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
  [_tableView setDelegate:self];
  [_tableView setDataSource:self];
  [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:(_cellIdentifier = @"CustomTransitionDemoCell")];
  [_tableView setBackgroundColor:[UIColor whiteColor]];
  [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [[self view] addSubview:_tableView];

  [[[_tableView leadingAnchor] constraintEqualToAnchor:[[self view] leadingAnchor]] setActive:YES];
  [[[_tableView trailingAnchor] constraintEqualToAnchor:[[self view] trailingAnchor]] setActive:YES];
  [[[_tableView topAnchor] constraintEqualToAnchor:[[self topLayoutGuide] bottomAnchor]] setActive:YES];
  [[[_tableView bottomAnchor] constraintEqualToAnchor:[[self view] bottomAnchor]] setActive:YES];

  _demoArray = @[
                 @{@(JYCustomTransitionStylePopImage): @"相册"},
                 @{@(JYCustomTransitionStyleOpenDoor): @"开门"},
                 @{@(JYCustomTransitionStyleMemo): @"便笺"}
                 ];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_demoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier
                                                          forIndexPath:indexPath];

  NSDictionary<NSNumber *, NSString *> *item = _demoArray[indexPath.row];
  [[cell textLabel] setText:[[item allValues] firstObject]];
  [cell setTag:[[[item allKeys] firstObject] unsignedIntegerValue]];

  return cell;
}

#pragma mark - UITableViewDelegte

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 45.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  JYCustomTransitionStyle style = [[[_demoArray[[indexPath row]] allKeys] firstObject] unsignedIntegerValue];
//  UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
  UIViewController *toViewController = nil;
  switch (style) {
  case JYCustomTransitionStylePopImage:
    toViewController = [[JYPhotoViewController alloc] initWithNibName:nil bundle:nil];
    break;

  case JYCustomTransitionStyleOpenDoor:
    toViewController = [[JYDoorViewController alloc] initWithNibName:nil bundle:nil];
    break;

  default:
    break;
  }

  if (toViewController != nil) {
    [[self navigationController] pushViewController:toViewController animated:YES];
  }
}

@end
