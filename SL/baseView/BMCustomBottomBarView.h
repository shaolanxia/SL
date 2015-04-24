//
//  HomeViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "fashion.h"

@protocol BMCustomBottomDelegate <NSObject>



@end

@interface BMCustomBottomBarView : UIView

@property (nonatomic, retain) NSMutableArray *btnImageArray;
@property (nonatomic, retain) NSMutableArray *btnSImageArray;
@property (nonatomic, retain) NSMutableArray *btnArray;
@property (nonatomic,retain) NSArray *btnTitleArray;
@property (nonatomic, assign) id delegate;
//@property (nonatomic,retain) UIImageView *imageView;

- (void)initButtonAlloc;
- (void)selectButtonClick:(UIButton *)sender;


@end
