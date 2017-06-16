//
//  JYIndoorViewController.h
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/4/17.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYIndoorViewController : UIViewController

@property (nonatomic, strong, readonly) UIImage *snapshotImage;
@property (nonatomic, strong, readonly) UIImageView *indoorImageView;

- (instancetype)initWithSnapshotImage:(UIImage *)image;

@end
