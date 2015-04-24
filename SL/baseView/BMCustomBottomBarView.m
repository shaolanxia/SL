//
//  HomeViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//


#import "BMCustomBottomBarView.h"
#import "DataHander.h"

@implementation BMCustomBottomBarView
@synthesize btnImageArray = _btnImageArray;
@synthesize btnSImageArray = _btnSImageArray;
@synthesize btnArray = _btnArray;
@synthesize delegate = _delegate;
@synthesize btnTitleArray;
//@synthesize imageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor whiteColor] ;//[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
    }
    return self;
}

- (void)initButtonAlloc
{
    _btnArray = [[NSMutableArray alloc] init];
    
    float with = kScreenWidth / 4;
    for (int i = 0; i < _btnImageArray.count; i ++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * with+10,0,with-10,self.bounds.size.height)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_btnImageArray objectAtIndex:i]]];
        imageView.frame = CGRectMake(with/2-imageView.image.size.width/2,10, imageView.image.size.width/2, imageView.image.size.height/2);
        imageView.tag = 111;
        [btn addSubview:imageView];
        if (i==3) {
            imageView.frame = CGRectMake(with/2-imageView.image.size.width/2,15, imageView.image.size.width/2, imageView.image.size.height/2);
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,29, with-18, 15)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.tag = 333;
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor lightTextColor];
        titleLabel.text = [btnTitleArray objectAtIndex:i];
        [btn addSubview:titleLabel];
        
        btn.tag = i;
        [btn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArray addObject:btn];
        [self addSubview:btn];

        UIImage *image = [UIImage imageNamed:@"02-dibu-xuanzhongkuai"];
        UIImageView *downView = [[UIImageView alloc] initWithImage:image];
        downView.frame = CGRectMake(with/2-image.size.width/2+5, self.frame.size.height-image.size.height/2, image.size.width/2, image.size.height/2);
        downView.hidden = YES;
        downView.tag = 222;
        [btn addSubview:downView];
        
        if (i==4) {
            [DataHander sharedDataHander].myButton = btn;
        }
    

    }
}

- (void)selectButtonClick:(UIButton *)sender
{
    for (UIButton *btn in _btnArray){
        btn.selected = NO;
        UIView *btnView = [btn viewWithTag:222];
        btnView.hidden = YES;
        
        UILabel *btnLabel = (UILabel *)[btn viewWithTag:333];
        btnLabel.textColor = [UIColor lightTextColor];
        
        UIImageView *btnImageView = (UIImageView *) [btn viewWithTag:111];
        btnImageView.image =[UIImage imageNamed:[_btnImageArray objectAtIndex:btn.tag]];
    }
    
    sender.selected = !sender.selected;
    UIView *downView = [sender viewWithTag:222];
    downView.hidden = NO;
    
    UILabel *label = (UILabel *)[sender viewWithTag:333];
    label.textColor = [UIColor whiteColor];
    
    UIImageView *imageView = (UIImageView *) [sender viewWithTag:111];
    imageView.image =[UIImage imageNamed:[_btnSImageArray objectAtIndex:sender.tag]];
    
    if ([_delegate respondsToSelector:@selector(selectBottomButtonClick:)])
    {
        [_delegate performSelector:@selector(selectBottomButtonClick:) withObject:sender];
    }
}

@end
