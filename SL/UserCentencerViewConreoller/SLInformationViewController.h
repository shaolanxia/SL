//
//  SLInformationViewController.h
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/29.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SXABaseViewController.h"

@protocol newImgDelegate <NSObject>

-(void)screenImg : (UIImage *)sizeImg :(NSInteger )tag;

@end

@interface SLInformationViewController : SXABaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)NSDictionary *userData; //个人信息的数据

@property(assign,nonatomic)id<newImgDelegate>delegate;

@end
