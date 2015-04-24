//
//  SLLoginViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLLoginViewController.h"
#import "SLResigsterViewController.h"
#import "AppDelegate.h"
#import "RootTAMViewController.h"
#import "SLRetrieveViewController.h"
#import "NSString+MD5.h"
#import "CustomInputView.h"
@interface SLLoginViewController ()<UITextFieldDelegate>
{
    NSString *textStr1;
    NSString *textStr2;
    NSString *textStr3;
    NSString *textStr4;
}
@end

@implementation SLLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.title = @"账户登陆";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"账户登陆" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(60, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
        titlelabel.textAlignment=NSTextAlignmentCenter;
        
    }
    return self;
}

-(UIView*)inputView
{
    UIView *inputView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(100, 0, 1, 40)];
    [inputView addSubview:line];
    line.backgroundColor=[UIColor grayColor];
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(20, 41, kScreenWidth-40, 1)];
    [inputView addSubview:line1];
    line1.backgroundColor=[UIColor grayColor];
    return inputView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self addNavigationLeftButton];
    [self addNavigationRightButtonForStr:@"注册"];
    [self initView];
}

-(void)initView
{
//    for (int i = 0; i < 2; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setFrame:CGRectMake(20, 20+50*i, kScreenWidth-40, 35)];
//        [button setBackgroundColor:[UIColor blueColor]];
//        button.tag = i;
//        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
//        [_baseScrollView addSubview:button];
//    }
    
    NSArray *placeArray = [[NSArray alloc]initWithObjects:@"用户名/邮箱/手机号",@"密码", nil];
    NSArray *imgArray = [[NSArray alloc]initWithObjects:@"用户名",@"密码", nil];
    for (int i = 0; i < 2; i++) {
        CustomInputView *inputview=[[CustomInputView alloc]initWithFrame:CGRectMake(0, 20+i*50, kScreenWidth, 44) withLineY:60];
        [_baseScrollView addSubview:inputview];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(25, 30+i*50, 30, 30)];
//        imageview.backgroundColor=[UIColor yellowColor];
        [_baseScrollView addSubview:imageview];
        imageview.image=[UIImage imageNamed:[imgArray objectAtIndex:i]];
        UITextField *filed = [[UITextField alloc]initWithFrame:CGRectMake(65, 30+i*50, kScreenWidth-160, 30)];
        filed.placeholder = [NSString stringWithFormat:@"%@",[placeArray objectAtIndex:i]];
//        filed.backgroundColor=[UIColor redColor];
//        filed.backgroundColor=[UIColor clearColor];
        filed.tag = 10+i;
        filed.delegate = self;
        filed.clearButtonMode = UITextFieldViewModeWhileEditing;
//        filed.borderStyle = UITextBorderStyleRoundedRect;
        filed.font = [UIFont systemFontOfSize:15.0];
        [_baseScrollView addSubview:filed];
        
        if (i == 0) {
            [filed setFrame:CGRectMake(65, 30+i*50, kScreenWidth-100, 30)];
        }
        if (i == 1) {
            filed.secureTextEntry = YES;
        }
    }
    
    UIButton *fogotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fogotBtn setFrame:CGRectMake(kScreenWidth-80, 80, 60, 30)];
    [fogotBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [fogotBtn setTitleColor:RGBCOLOR(0, 109, 217) forState:UIControlStateNormal];
    fogotBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [fogotBtn addTarget:self action:@selector(fogotBtn) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:fogotBtn];
    
    UIButton *reviserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reviserBtn setFrame:CGRectMake(20, 140, kScreenWidth-40, 30)];
    [reviserBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [reviserBtn setTitle:@"登 陆" forState:UIControlStateNormal];
    [reviserBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
    reviserBtn.layer.masksToBounds = YES;
    reviserBtn.layer.cornerRadius = 5;
    [reviserBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:reviserBtn];
}

-(void)button:(UIButton *)sender
{
    if (sender.tag == 0) {
        NSLog(@"0");
    }else{
        NSLog(@"1");
    }
}

-(void)fogotBtn
{
    SLRetrieveViewController *retrVC = [[SLRetrieveViewController alloc]init];
    [self.navigationController pushViewController:retrVC animated:YES];
}

-(void)rightAction
{
    SLResigsterViewController *resigsVC = [[SLResigsterViewController alloc]init];
    [self.navigationController pushViewController:resigsVC animated:YES];
}

#pragma mark == 登陆
-(void)login
{
    
//    登录的话用户名451684504@qq.com密码123456
    
    if (textStr1 == nil || textStr1.length <=0) {
        [self showAlertWithTitle:@"提示" :@"请输入用户名" :@"确定" :nil];
    }else if (textStr3 == nil || textStr3.length <=0) {
        [self showAlertWithTitle:@"提示" :@"请输入用户名" :@"确定" :nil];
    }else if (textStr4 == nil || textStr4.length <=0) {
        [self showAlertWithTitle:@"提示" :@"请输入密码" :@"确定" :nil];
    }else{
        NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
        [dicInput setObject:@"4" forKey:@"from"];
        [dicInput setObject:textStr1 forKey:@"token"];
        [dicInput setObject:textStr3 forKey:@"username"];
        [dicInput setObject:textStr4 forKey:@"password"];
        [dicInput setObject:@"3" forKey:@"loginType"];
        
        NSLog(@"%@",dicInput);
        [[BMRequestManager shareBMRequestManager] Login:dicInput success:^(id responseDic) {
            NSLog(@"%@",responseDic);
            if (responseDic == nil) {
                [self showAlertWithTitle:@"提示" :@"服务器在偷懒" :@"确定" :nil];
            }else if ([[responseDic objectForKey:@"success"] intValue] == 1) {

                NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
                [userdefault setBool:YES forKey:@"isLogin"];
                [userdefault setObject:[[responseDic objectForKey:@"data"] objectForKey:@"id"] forKey:@"userId"];
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                RootTAMViewController* rootVc = [[RootTAMViewController alloc] init];
                
                
                [appDelegate.window setBackgroundColor:[UIColor whiteColor]];
                [appDelegate.window makeKeyAndVisible];
                [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
                
                appDelegate.window.rootViewController = rootVc;

            }else{
                [self showAlertWithTitle:@"提示" :[responseDic objectForKey:@"errMsg"] :@"确定" :nil];
            }
            
        } failure:^(id errorString) {
            [UnityLHClass showAlertView:@"网络好像出了点问题，请重试！"];
        }];
  
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 10) {
//        NSTimeInterval animationDuration = 0.30f;
//        CGRect frame = self.view.frame;
//        frame.origin.y -=160;
//        frame.size.height +=160;
//        self.view.frame = frame;
//        [UIView beginAnimations:@"ResizeView" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        self.view.frame = frame;
//        [UIView commitAnimations];
    }else{
//        NSTimeInterval animationDuration = 0.30f;
//        CGRect frame = self.view.frame;
//        frame.origin.y -=180;
//        frame.size.height +=180;
//        self.view.frame = frame;
//        [UIView beginAnimations:@"ResizeView" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        self.view.frame = frame;
//        [UIView commitAnimations];
    }

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    if (textField.tag == 10) {
        NSString *str = [NSString stringWithFormat:@"%@-ios",textField.text];
        textStr1 = [NSString stringWithFormat:@"%@",[str MD5]];
        textStr3 = textField.text;
        NSLog(@"str == %@",str);
        NSLog(@"textStr1 == %@",textStr1);
        NSLog(@"textStr3 == %@",textStr3);
    }else{
        
        
        textStr4 = textField.text;
    }
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
