//
//  JYRootViewController.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/22.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import "JYRootViewController.h"

#import "UIColor+Utilities.h"
#import "JYCatalogViewController.h"

#import <UIKit/UIKit.h>

@interface JYRootViewController () {
@private
  JYCatalogViewController *_catalogViewController;
}

@end

@implementation JYRootViewController

- (instancetype)init
{
  if ((_catalogViewController = [[JYCatalogViewController alloc] initWithNibName:nil bundle:nil]) != nil && (self = [self initWithRootViewController:_catalogViewController]) != nil) {
    
  }

  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

@end
