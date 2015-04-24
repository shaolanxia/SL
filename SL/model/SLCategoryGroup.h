//
//  SLCategoryGroup.h
//  ShuLianNet
//
//  Created by 郝威斌 on 15/4/7.
//  Copyright (c) 2015年 邵兰霞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLCategory.h"

@interface SLCategoryGroup : NSObject

@property(strong,nonatomic)NSString *titleName;
@property(strong,nonatomic)NSMutableArray *titleArray;
@property(strong,nonatomic)SLCategory *imageArray;

@end
