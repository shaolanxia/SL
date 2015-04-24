//
//  HomeViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface BaseScrollView : UIScrollView{
    UIEdgeInsets    _priorInset;
    BOOL            _priorInsetSaved;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
    CGFloat         _currentPointY;
}
- (void)adjustOffsetToIdealIfNeeded;
@end
