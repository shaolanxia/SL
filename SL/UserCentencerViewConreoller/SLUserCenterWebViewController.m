//
//  SLUserCenterWebViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/31.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLUserCenterWebViewController.h"

@interface SLUserCenterWebViewController ()
{
    UIActivityIndicatorView *activityIndicator;
}
@end

@implementation SLUserCenterWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    // Do any additional setup after loading the view.
    self.title = self.strTitle;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
    titleView.backgroundColor = [UIColor clearColor];
    
    UILabel* titlelabel = [UnityLHClass initUILabel:self.strTitle font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
    [titleView addSubview:titlelabel];
    self.navigationItem.titleView = titleView;
 titlelabel.textAlignment=NSTextAlignmentCenter;
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
    
    if (self.strTag == 1) {
        
        //我的消息
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 2) {
        
        //我的灵感集
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/afflatus"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 3) {
        
        //我的关注
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/attention"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 4) {
        //我的粉丝
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/fans"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 5) {
        
        //我的授权
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/authorize"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 6) {
        
        //消息通知
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 7) {
        
        //推荐给微信好友
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/pushFriend"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 8) {
        
        //关于数联中国
        NSURL *strUrl = [NSURL URLWithString:@"http://www.duc.cn/ios/aboutDuc"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 9) {
        
        //用户须知
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/userInstruction"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 10) {
        
        //用户须知
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/userInstruction"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }else if (self.strTag == 11) {
        
        //用户须知
        NSURL *strUrl = [NSURL URLWithString:@"http://i.duc.cn/ios/userInstruction"];
        NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
        [self.webView loadRequest:request];
        
    }
    
    
    
    
    //加载旋转的风火轮
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:
                         UIActivityIndicatorViewStyleGray];
    activityIndicator.center = self.view.center;
    [self.view addSubview:activityIndicator];

}

//开始加载的时候执行该方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
}
//加载完成的时候执行该方法
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    [activityIndicator stopAnimating];
    
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
