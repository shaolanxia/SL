//
//  SLAgreementViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/4/2.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLAgreementViewController.h"

@interface SLAgreementViewController ()

@end

@implementation SLAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
    titleView.backgroundColor = [UIColor clearColor];

    UILabel* titlelabel = [UnityLHClass initUILabel:@"数联用户服务协议" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
    [titleView addSubview:titlelabel];
    self.navigationItem.titleView = titleView;
    titlelabel.textAlignment=NSTextAlignmentCenter;

    
    // Do any additional setup after loading the view.
    [self initView];
}

-(void)initView
{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    self.webView.delegate = self;
    [self.webView setOpaque:NO];
    [self.webView setScalesPageToFit:YES];  //yes:根据webview自适应，NO：根据内容自适应
    self.webView.delegate = self;
    [_baseScrollView addSubview:self.webView];
    _baseScrollView.scrollEnabled = NO;
    
    NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/"];
    NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
