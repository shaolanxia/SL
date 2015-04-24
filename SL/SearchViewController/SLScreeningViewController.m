//
//  SLScreeningViewController.m
//  ShuLianNet
//
//  Created by 郝威斌 on 15/4/7.
//  Copyright (c) 2015年 邵兰霞. All rights reserved.
//

#import "SLScreeningViewController.h"
#import "SLScreeningTableViewCell.h"

@interface SLScreeningViewController ()<UITextFieldDelegate>
{
    UITextField *searchField;
    UIView *backView;
    UIView *topView;
    UIButton *submitBtn;
    UIActivityIndicatorView *activityIndicator;
    NSMutableArray *attrbuteList;
}
@end

@implementation SLScreeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationLeftButton];
    [self initView];
    
    NSLog(@"%d",self.strTag);
    if (self.strTag == 1) {
        [self spacetData];
    }else if (self.strTag == 2){
        [self modelData];
    }else if (self.strTag == 3){
        [self shopData];
    }else if (self.strTag == 4){
        [self panoramicData];
    }
}

-(void)spacetData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:SLSpace_Request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----%@",responseObject);
        
        if ([[responseObject objectForKey:@"success"] boolValue] == 1) {
            
            
            
        }else{
            [self showAlertWithTitle:@"提示" :@"获取数据失败,请重试!" :@"OK" :nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error----%@",error);
    }];
    
}

-(void)modelData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:SLModel_Request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----%@",responseObject);
        
        if ([[responseObject objectForKey:@"success"] boolValue] == 1) {
            
            
            
        }else{
            [self showAlertWithTitle:@"提示" :@"获取数据失败,请重试!" :@"OK" :nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error----%@",error);
    }];
    
}


-(void)shopData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:SLShop_Request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----%@",responseObject);
        
        if ([[responseObject objectForKey:@"success"] boolValue] == 1) {
            
            
            
        }else{
            [self showAlertWithTitle:@"提示" :@"获取数据失败,请重试!" :@"OK" :nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error----%@",error);
    }];
    
}


-(void)panoramicData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:SLPanoramic_Request parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----%@",responseObject);
        
        if ([[responseObject objectForKey:@"success"] boolValue] == 1) {
            
            
            
        }else{
            [self showAlertWithTitle:@"提示" :@"获取数据失败,请重试!" :@"OK" :nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error----%@",error);
    }];
    
}



-(void)initView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(-20, 0, kScreenWidth, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;

    
    UIImage *searchImg = [UIImage imageNamed:@"搜索框.png"];
    UIImageView *searchImgView = [[UIImageView alloc]initWithFrame:CGRectMake(-10, 7, kScreenWidth-120, searchImg.size.height/2)];
    searchImgView.image = searchImg;
    searchImgView.userInteractionEnabled = YES;
    [titleView addSubview:searchImgView];
    
    searchField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-120, searchImg.size.height/2)];
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.backgroundColor = [UIColor clearColor];
    searchField.returnKeyType = UIReturnKeySearch;
    [searchImgView addSubview:searchField];
    
//    [searchField becomeFirstResponder];
    
    UIImage *smImg = [UIImage imageNamed:@"筛选.png"];
    UIButton *sxImg = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-105, 7, smImg.size.width/2, smImg.size.height/2)];
    [sxImg setBackgroundImage:smImg forState:UIControlStateNormal];
    [sxImg addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
    sxImg.titleLabel.text = @"1";
    [titleView addSubview:sxImg];

    
    backView = [[UIView alloc]initWithFrame:CGRectMake(80, 64, kScreenWidth-80, kScreenHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.hidden = YES;
    [self.view addSubview:backView];
    
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-80, 44)];
    topView.backgroundColor = RGBCOLOR(238, 238, 238);
    [backView addSubview:topView];
    
    submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(80, kScreenHeight-30, kScreenWidth-80, 30)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [submitBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [submitBtn addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.hidden = YES;
    [self.view addSubview:submitBtn];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth-80, kScreenHeight-44) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [backView addSubview:self.tableView];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    self.webView.delegate = self;
    [self.webView setScalesPageToFit:YES];  //yes:根据webview自适应，NO：根据内容自适应
    self.webView.delegate = self;
    [_baseScrollView addSubview:self.webView];
    _baseScrollView.scrollEnabled = NO;
    
    NSURL *strUrl = [NSURL URLWithString:self.strUrl];
    NSURLRequest *request=[NSURLRequest requestWithURL:strUrl];
    [self.webView loadRequest:request];
    
    //加载旋转的风火轮
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:
                         UIActivityIndicatorViewStyleGray];
    activityIndicator.center = self.view.center;
    [self.view addSubview:activityIndicator];
    
    [self setExtraCellLineHidden:self.tableView];//去掉UITableView底部多余的分割线
    
    
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


-(void)shaixuan:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"1"]) {
        
        sender.titleLabel.text = @"0";
        backView.hidden = NO;
        submitBtn.hidden = NO;
        
    }else{
        
        sender.titleLabel.text = @"1";
        backView.hidden = YES;
        submitBtn.hidden = YES;
    }

}


#pragma mark ==  UITableView

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    SLScreeningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SLScreeningTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)submitBtn
{
    NSLog(@"点击了确定按钮");
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
