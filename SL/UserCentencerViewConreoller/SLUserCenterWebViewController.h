//
//  SLUserCenterWebViewController.h
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/31.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SXABaseViewController.h"

@interface SLUserCenterWebViewController : SXABaseViewController<UIWebViewDelegate>

@property(strong,nonatomic)UIWebView *webView;
@property(strong,nonatomic)NSString *strTitle;
@property(assign,nonatomic)NSInteger strTag;//上个页面传过来的tag值

@end
