//
//  SLPerfectViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLPerfectViewController.h"
#import "CustomInputView.h"
#import "AppDelegate.h"
#import "RootTAMViewController.h"
@interface SLPerfectViewController ()

@end

@implementation SLPerfectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"完善账户信息";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"完善账户信息" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
titlelabel.textAlignment=NSTextAlignmentCenter;
        
    }
    return self;
}

-(void)activateUserRequest
{
    UITextField *username=(UITextField*)[_baseScrollView viewWithTag:11];
    UITextField *pwd=(UITextField*)[_baseScrollView viewWithTag:12];
    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    [dicInput setObject:@"1" forKey:@"regType"];
    [dicInput setObject:username.text forKey:@"userName"];
    [dicInput setObject:pwd.text forKey:@"newPwd1"];
    [dicInput setObject:pwd.text forKey:@"newPwd2"];
    [dicInput setObject:self.account forKey:@"mobile"];
    [dicInput setObject:self.linkId  forKey:@"userId"];
    NSLog(@"%@",dicInput);
    [[BMRequestManager shareBMRequestManager] activateUser:dicInput success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        if (responseDic == nil) {
            [self showAlertWithTitle:@"提示" :@"服务器在偷懒" :@"确定" :nil];
        }else if ([[responseDic objectForKey:@"success"] intValue] == 1) {
            
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    // Do any additional setup after loading the view.
    [self initView];
}

-(void)initView
{
    UILabel *lable = [UnityLHClass initUILabel:@"欢迎来到数联中国！请进一步完善您的信息！" font:12.0 color:[UIColor blackColor] rect:CGRectMake(20, 10, kScreenWidth, 20)];
    [_baseScrollView addSubview:lable];
    
    NSArray *titArray = [[NSArray alloc]initWithObjects:@"手机号",@"用户名",@"密码",@"确认密码", nil];
    for (int i = 0; i < 4; i++) {
        CustomInputView *input=[[CustomInputView alloc]initWithFrame:CGRectMake(0, 45+56*i, kScreenWidth, 35) withLineY:90];
        [_baseScrollView addSubview:input];
        UILabel *titLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 60+55*i, 60, 20)];
        titLable.font = [UIFont systemFontOfSize:15.0];
        titLable.textColor = [UIColor blackColor];
        titLable.text = [titArray objectAtIndex:i];
        [_baseScrollView addSubview:titLable];
        
        UITextField *titField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-218, 55+56*i, kScreenWidth-110, 35)];
        titField.textColor = [UIColor blackColor];
        titField.tag=i+10;
        titField.clearButtonMode = UITextFieldViewModeWhileEditing;
        titField.font = [UIFont systemFontOfSize:15.0];
//        titField.borderStyle = UITextBorderStyleRoundedRect;
        titField.placeholder = [titArray objectAtIndex:i];
        [_baseScrollView addSubview:titField];
        if (titField.tag==10) {
            titField.text=self.account;
            titField.enabled=NO;
        }else{
            titField.secureTextEntry = YES;
        }
        
        
    }

    UILabel *zlable = [UnityLHClass initUILabel:@"我已认真阅读并接受《免责声明》" font:12.0 color:[UIColor grayColor] rect:CGRectMake(50, 340, kScreenWidth, 20)];
    [_baseScrollView addSubview:zlable];
    
    UIButton *OKBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 300, kScreenWidth-20, 35)];
    OKBtn.layer.masksToBounds = YES;
    OKBtn.layer.cornerRadius = 5;
    [OKBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(OKAction) forControlEvents:UIControlEventTouchUpInside];
    [OKBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_baseScrollView addSubview:OKBtn];
}
-(void)OKAction
{
    [self activateUserRequest];
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
