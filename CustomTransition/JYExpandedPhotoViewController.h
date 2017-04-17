//
//  JYExpandedPhotoViewController.h
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/3/27.
//  Copyright © 2017 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYExpandedPhotoViewController : UIViewController

@property (nonatomic, strong, readonly) NSString *imageName;
@property (nonatomic, assign, readonly) CGRect imageRect;

@property (nonatomic, strong, readonly) UIImageView *imageView;

- (instancetype)initWithImageName:(NSString *)imageName startImageRect:(CGRect)imageRect;

@end
