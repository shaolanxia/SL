//
//  SLRetrieveNextViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/30.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLRetrieveNextViewController.h"
#import "CustomInputView.h"
@interface SLRetrieveNextViewController ()<UITextFieldDelegate>
{
    UITextField *newPassword;
    UITextField *okayPwd;
}
@end

@implementation SLRetrieveNextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"找回密码";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"找回密码" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
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
    NSArray *placeArray = [[NSArray alloc]initWithObjects:@"新密码",@"确认密码", nil];
    
    for (int i = 0; i < 2; i++) {
        CustomInputView *inputview=[[CustomInputView alloc]initWithFrame:CGRectMake(0, 20+i*50, kScreenWidth, 44) withLineY:80];
        [_baseScrollView addSubview:inputview];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 30+i*50, 60, 30)];
        lable.font = [UIFont systemFontOfSize:14.0];
        [_baseScrollView addSubview:lable];
        lable.text=[placeArray objectAtIndex:i];
        
    }
    
    newPassword = [[UITextField alloc]initWithFrame:CGRectMake(85, 32, kScreenWidth-105, 30)];
    newPassword.placeholder = @"新密码";
    //    phone.borderStyle = UITextBorderStyleRoundedRect;
    newPassword.delegate = self;
    newPassword.font = [UIFont systemFontOfSize:14.0];
    newPassword.keyboardType=UIKeyboardTypeNumberPad;
    newPassword.secureTextEntry=YES;
    newPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_baseScrollView addSubview:newPassword];
    
    okayPwd = [[UITextField alloc]initWithFrame:CGRectMake(85, 82, kScreenWidth-200, 30)];
    okayPwd.placeholder = @"确认密码";
    //    verification.borderStyle = UITextBorderStyleRoundedRect;
    okayPwd.delegate = self;
    okayPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    okayPwd.font = [UIFont systemFontOfSize:14.0];
    okayPwd.secureTextEntry=YES;
    okayPwd.keyboardType=UIKeyboardTypeNumberPad;
    [_baseScrollView addSubview:okayPwd];
    
    
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(20, 150, kScreenWidth-40, 30)];
    [okBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [okBtn setTitle:@"完 成" forState:UIControlStateNormal];
    [okBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
    okBtn.layer.masksToBounds = YES;
    okBtn.layer.cornerRadius = 5;
    [okBtn addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:okBtn];
    
    
    
    
}


-(void)okBtn
{
    NSLog(@"点击了");
    if ([newPassword.text isEqualToString:okayPwd.text]) {
        [self setPwdRequest];
    }else
    {
        UIAlertView *alertview=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入一致的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertview show];
    }
}

-(void)setPwdRequest
{
    NSDate *date = [NSDate date];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000/60000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    
    NSArray *array = [timeString componentsSeparatedByString:@"."];
    NSString *Str=[array objectAtIndex:0];
    NSLog(@"%@  %@",Str,timeString);

    NSString *token=[NSString stringWithFormat:@"account=%@&token=ios-duc",self.accountStr];
    
    NSString *tokenStr=[token MD5];
    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    [dicInput setObject:tokenStr forKey:@"token"];
    [dicInput setObject:@"ios" forKey:@"f"];
    [dicInput setObject:self.accountStr forKey:@"account"];
    [dicInput setObject:newPassword.text forKey:@"newPwd1"];
    [dicInput setObject:okayPwd.text forKey:@"newPwd2"];
    
    NSLog(@"%@",dicInput);
    [[BMRequestManager shareBMRequestManager] findForgetPwd:dicInput success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        if (responseDic == nil) {
            [self showAlertWithTitle:@"提示" :@"服务器在偷懒" :@"确定" :nil];
        }else if ([[responseDic objectForKey:@"success"] intValue] == 1) {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:[responseDic objectForKey:@""] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
        }else{
            [self showAlertWithTitle:@"提示" :[responseDic objectForKey:@"errMsg"] :@"确定" :nil];
        }
        
    } failure:^(id errorString) {
        [UnityLHClass showAlertView:@"网络好像出了点问题，请重试！"];
    }];
    
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
