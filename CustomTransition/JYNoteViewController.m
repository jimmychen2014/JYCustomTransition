//
//  JYNoteViewController.m
//  JYCustomTransition
//
//  Created by Jingting Chen on 17/6/16.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

#import "JYNoteViewController.h"

#import "JYMemoViewController.h"

@interface JYNoteViewController () {
@private
  UILabel *_noteLabel;
  UIButton *_popButton;
}

@end

@implementation JYNoteViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [[self view] setBackgroundColor:[UIColor whiteColor]];
  [self setTitle:@"弹出便笺"];

  _noteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  [_noteLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_noteLabel setText:@"这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果这是一段毫无意义的文字放在这里只是为了展示动画中的透视效果"];
  [_noteLabel setLineBreakMode:NSLineBreakByTruncatingTail];
  [_noteLabel setNumberOfLines:0];
  [[self view] addSubview:_noteLabel];

  [[[_noteLabel leadingAnchor] constraintEqualToAnchor:[[self view] leadingAnchor] constant:20.0] setActive:YES];
  [[[_noteLabel trailingAnchor] constraintEqualToAnchor:[[self view] trailingAnchor] constant:-20.0] setActive:YES];
  [[[_noteLabel topAnchor] constraintEqualToAnchor:[[self topLayoutGuide] bottomAnchor] constant:50.0] setActive:YES];

  _popButton = [[UIButton alloc] initWithFrame:CGRectZero];
  [_popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_popButton setTitle:@"弹出便笺" forState:UIControlStateNormal];
  [_popButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [[_popButton layer] setBorderColor:[[UIColor blackColor] CGColor]];
  [[_popButton layer] setBorderWidth:1.0];
  [[self view] addSubview:_popButton];

  [_popButton addTarget:self action:@selector(_didClickPopButton:) forControlEvents:UIControlEventTouchUpInside];

  [[[_popButton centerXAnchor] constraintEqualToAnchor:[[self view] centerXAnchor]] setActive:YES];
  [[[_popButton topAnchor] constraintEqualToAnchor:[_noteLabel bottomAnchor] constant:50.0] setActive:YES];
  [[[_popButton widthAnchor] constraintEqualToConstant:100.0] setActive:YES];
  [[[_popButton heightAnchor] constraintEqualToConstant:50.0] setActive:YES];
}

- (void)_didClickPopButton:(UIButton *)button
{
  JYMemoViewController *memoViewController = [[JYMemoViewController alloc] initWithNibName:nil bundle:nil];
  [self presentViewController:memoViewController animated:YES completion:nil];
}

@end
