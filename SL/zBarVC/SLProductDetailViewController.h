//
//  SLProductDetailViewController.h
//  ShuLianWang
//
//  Created by 郝威斌 on 15/4/2.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SXABaseViewController.h"

@interface SLProductDetailViewController : SXABaseViewController<UIWebViewDelegate>

@property(strong,nonatomic)UIWebView *webView;


@property(strong,nonatomic)NSString *productUrl; //二维码链接

@end
