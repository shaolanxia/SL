//
//  SLProductDetailViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/4/2.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLProductDetailViewController.h"

@interface SLProductDetailViewController ()
{
    UIActivityIndicatorView *activityIndicator;
    UILabel *titlelabel;
}
@end

@implementation SLProductDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = @"详情";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        //    [UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0];
//        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        titlelabel = [UnityLHClass initUILabel:@"" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
        titlelabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    // Do any additional setup after loading the view.
    [self initView];
}

-(void)initView
{
    NSString *url=self.productUrl;
    NSString *str=[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
    NSString *title=[[[[str componentsSeparatedByString:@"<title>"] lastObject] componentsSeparatedByString:@"</title>"] firstObject];
    NSLog(@"---%@===%@",str,title);
    titlelabel.text=title;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    self.webView.delegate = self;
    [self.webView setOpaque:NO];
    [self.webView setScalesPageToFit:YES];  //yes:根据webview自适应，NO：根据内容自适应
    self.webView.delegate = self;
    [_baseScrollView addSubview:self.webView];
    _baseScrollView.scrollEnabled = NO;

    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.productUrl]];
    [self.webView loadRequest:request];
    
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
