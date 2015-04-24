//
//  SLSpaceCollectionViewCell.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/4/5.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLSpaceCollectionViewCell.h"

@implementation SLSpaceCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60,60)];
        self.imgView.backgroundColor = [UIColor clearColor];
        self.imgView.image = [UIImage imageNamed:@"引导图"];
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = 30;
        [self.contentView addSubview:self.imgView];
        
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, self.contentView.frame.size.width, 20)];
        self.titleLable.text = @"全部空间";
        self.titleLable.font = [UIFont systemFontOfSize:13.0];
        self.titleLable.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLable];
        
        
    }
    return self;
}


@end
