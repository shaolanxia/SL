//
//  SLEditPassWordViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/29.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLEditPassWordViewController.h"
#import "AppDelegate.h"
#import "RootTAMViewController.h"
#import "SLLoginViewController.h"
@interface SLEditPassWordViewController ()<UITextFieldDelegate>
{
    
    UIView *rightView;
    NSString *strID;
}
@end

@implementation SLEditPassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改密码";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"修改密码" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
        titlelabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    strID = [user objectForKey:@"userId"];
}


- (void)addNavigationRightBtn
{
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(kScreenWidth-[UIImage imageNamed:@"点点"].size.width/2, 12,[UIImage imageNamed:@"点点"].size.width/2,[UIImage imageNamed:@"点点"].size.height/2);
    [forwardButton setBackgroundImage:[UIImage imageNamed:@"点点"] forState:UIControlStateNormal];
    forwardButton.titleLabel.text = @"1";
    [forwardButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    [self addNavigationRightBtn];
    // Do any additional setup after loading the view.
    [self initView];
    [self initRightView];
}

-(void)initView
{
    NSArray *leftArray = [[NSArray alloc]initWithObjects:@"旧密码",@"新密码",@"确认新密码", nil];
    NSArray *rightArray = [[NSArray alloc]initWithObjects:@"旧密码",@"新密码",@"确认新密码", nil];
    
    for (int i = 0; i < leftArray.count; i++) {
        UILabel *leftLable = [UnityLHClass initUILabel:[leftArray objectAtIndex:i] font:16.0 color:[UIColor blackColor] rect:CGRectMake(10, 20+60*i, 100, 30)];
        [_baseScrollView addSubview:leftLable];
    }
    
    for (int i = 0; i < rightArray.count; i++) {
        UITextField *rightFiled = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-220, 20+60*i, 200, 30)];
        rightFiled.borderStyle = UITextBorderStyleRoundedRect;
        rightFiled.placeholder = [rightArray objectAtIndex:i];
        rightFiled.tag = 10+i;
        rightFiled.secureTextEntry = YES;
        [_baseScrollView addSubview:rightFiled];
    }
    
    UIButton *okayBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 250, kScreenWidth-40, 30)];
    [okayBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [okayBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [okayBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [okayBtn addTarget:self action:@selector(okayBtn) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:okayBtn];
}

#pragma mark ==
-(void)initRightView
{
    rightView = [[UIView alloc]initWithFrame:CGRectMake(220, 64, 100, 100)];
    rightView.backgroundColor = [UIColor whiteColor];
    rightView.hidden = YES;
    [self.view addSubview:rightView];
    
    UIImageView *lineImag = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 100, 1)];
    lineImag.image = [UIImage imageNamed:@"02-01-line"];
    [rightView addSubview:lineImag];
    
    UIImage *leftImg = [UIImage imageNamed:@"搜索灰"];
    UIImage *leftImg1 = [UIImage imageNamed:@"首页"];
    
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, leftImg.size.width/2, leftImg.size.height/2)];
    leftImgView.image = leftImg;
    [rightView addSubview:leftImgView];
    
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seachBtn setFrame:CGRectMake(30, 15, 60, 20)];
    [seachBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [seachBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [seachBtn addTarget:self action:@selector(seachBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:seachBtn];
    
    UIImageView *leftImgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, leftImg1.size.width/2, leftImg1.size.height/2)];
    leftImgView1.image = leftImg1;
    [rightView addSubview:leftImgView1];
    
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setFrame:CGRectMake(30, 60, 60, 20)];
    [homeBtn setTitle:@"首页" forState:UIControlStateNormal];
    [homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(homeBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:homeBtn];
}

#pragma mark == 右上方的按钮
-(void)rightAction:(UIButton *)sender
{
    NSLog(@"点击右边的按钮");
    if ([sender.titleLabel.text isEqualToString:@"0"]) {
        
        rightView.hidden = YES;
        sender.titleLabel.text=@"1";
        
    }else{
        rightView.hidden = NO;
        sender.titleLabel.text=@"0";
        
    }
    
}

#pragma mark == 右上方的搜索按钮
-(void)seachBtn
{
    NSLog(@"点击了搜索按钮");
}

#pragma mark == 右上方的首页按钮
-(void)homeBtn
{
    NSLog(@"点击了首页按钮");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    RootTAMViewController* rootVc = [[RootTAMViewController alloc] init];
    
    
    [appDelegate.window setBackgroundColor:[UIColor whiteColor]];
    [appDelegate.window makeKeyAndVisible];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
    
    appDelegate.window.rootViewController = rootVc;
}


#pragma mark == 确认按钮
-(void)okayBtn
{
    NSLog(@"点击了确认按钮");
    UITextField *oldPWD = (UITextField *)[_baseScrollView viewWithTag:10];
    UITextField *newPWD = (UITextField *)[_baseScrollView viewWithTag:11];
    UITextField *okNewPWD = (UITextField *)[_baseScrollView viewWithTag:12];
    
    if (oldPWD.text == nil || oldPWD.text.length <= 0) {
        [self showAlertWithTitle:@"提示" :@"请输入原始密码" :@"确定" :nil];
    }else if (newPWD.text == nil || newPWD.text.length <= 0){
        [self showAlertWithTitle:@"提示" :@"请输入新密码" :@"确定" :nil];
    }else if (okNewPWD.text == nil || okNewPWD.text.length <= 0){
        [self showAlertWithTitle:@"提示" :@"请再次输入新密码" :@"确定" :nil];
    }else if (![newPWD.text isEqualToString:okNewPWD.text]){
        [self showAlertWithTitle:@"提示" :@"两次输入密码不一致" :@"确定" :nil];
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@userId=%@&oldPwd=%@&newPwd1=%@",SLEditPWD_Request,strID,oldPWD.text,newPWD.text];
        NSLog(@"%@",urlStr);
        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"----%@",responseObject);
//            if ([[responseObject objectForKey:@"success"]boolValue] == 1) {
//                
//            }else{
//                [self showAlertWithTitle:@"提示" :[responseObject objectForKey:@"errMsg"] :@"取消" :@"确定"];
//            }
//            
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            NSLog(@"error----%@",error);
//        }];
        
        NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
        [dicInput setObject:strID forKey:@"userId"];
        [dicInput setObject:oldPWD.text forKey:@"oldPwd"];
        [dicInput setObject:newPWD.text forKey:@"newPwd1"];
        [dicInput setObject:okNewPWD.text forKey:@"newPwd2"];
        
        NSLog(@"%@",dicInput);
        [[BMRequestManager shareBMRequestManager] EditPwd:dicInput success:^(id responseDic) {
            NSLog(@"%@",responseDic);
            if ([[responseDic objectForKey:@"success"] boolValue] == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 1;
                [alert show];
            }else{
                [self showAlertWithTitle:@"提示" :[responseDic objectForKey:@"errMsg"] :@"确定" :nil];
            }
            
            
        } failure:^(id errorString) {
            [UnityLHClass showAlertView:@"网络好像出了点问题，请重试！"];
        }];

    }
    
    

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
            [userdefault removeObjectForKey:@"isLogin"];
            [userdefault removeObjectForKey:@"userId"];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            SLLoginViewController* login = [[SLLoginViewController alloc] init];
            UINavigationController *loginnav=[[UINavigationController alloc]initWithRootViewController:login];
            appDelegate.window.rootViewController = loginnav;
            [appDelegate.window setBackgroundColor:[UIColor whiteColor]];
            [appDelegate.window makeKeyAndVisible];
            [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
        }
    }
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1) {
        
    }else if (textField.tag == 2){
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
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
