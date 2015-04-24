//
//  SLUserCenterViewController.h
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/28.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SXABaseViewController.h"
#import "SLInformationViewController.h"

@interface SLUserCenterViewController : SXABaseViewController<UITableViewDataSource,UITableViewDelegate,newImgDelegate>

@property(strong,nonatomic)NSDictionary *dataDic; //上个页面传过个人信息的数据

@property(strong,nonatomic)UITableView *tableView;

@end
