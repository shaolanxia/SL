//
//  CustomInputView.m
//  ShuLianWang
//
//  Created by SD0025A on 15/3/29.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "CustomInputView.h"

@implementation CustomInputView

- (id)initWithFrame:(CGRect)frame withLineY:(NSInteger)y
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(y, 14, .5, 30)];
        [self addSubview:line];
        line.backgroundColor=[UIColor grayColor];
        
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(20, 43.5, kScreenWidth-40, .5)];
        [self addSubview:line1];
        line1.backgroundColor=[UIColor grayColor];
       
    }
    return self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
