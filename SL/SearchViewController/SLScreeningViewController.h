//
//  SLScreeningViewController.h
//  ShuLianNet
//
//  Created by 郝威斌 on 15/4/7.
//  Copyright (c) 2015年 邵兰霞. All rights reserved.
//

#import "SXABaseViewController.h"

@interface SLScreeningViewController : SXABaseViewController<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UIWebView *webView;
@property(strong,nonatomic)NSString *strUrl;
@property(strong,nonatomic)UITableView *tableView;

@property(assign,nonatomic)NSInteger strTag;

@end
