//
//  SLScreeningTableViewCell.m
//  ShuLianNet
//
//  Created by 郝威斌 on 15/4/7.
//  Copyright (c) 2015年 邵兰霞. All rights reserved.
//

#import "SLScreeningTableViewCell.h"

@implementation SLScreeningTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization co
        
        self.leftLable = [UnityLHClass initUILabel:@"房间尺寸" font:13.0 color:[UIColor blackColor] rect:CGRectMake(10, 10, 120, 20)];
        [self.contentView addSubview:self.leftLable];
        
        self.rightLable = [UnityLHClass initUILabel:@"不限" font:13.0 color:[UIColor blackColor] rect:CGRectMake(185, 10, 120, 20)];
        [self.contentView addSubview:self.rightLable];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
