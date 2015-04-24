//
//  SLCodeViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/30.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLCodeViewController.h"
#import "SLRetrieveNextViewController.h"
#import "CustomInputView.h"
@interface SLCodeViewController ()<UITextFieldDelegate>
{
    UITextField *codeFiled;
    UILabel *timeLable;
    UIButton *timeBtn;
}
@end

@implementation SLCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    // Do any additional setup after loading the view.
    [self tryAction];
    [self initView];
}

-(void)initView
{
    UILabel *lable = [UnityLHClass initUILabel:@"" font:13.0 color:[UIColor grayColor] rect:CGRectMake(10, 20, kScreenWidth-20, 20)];
    lable.text = [NSString stringWithFormat:@"已向您的%@%@发送了验证码",self.typeNameStr,self.phoneStr];
    [_baseScrollView addSubview:lable];
    
    CustomInputView *inputview=[[CustomInputView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 44) withLineY:75];
    [_baseScrollView addSubview:inputview];
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(25, 70, 60, 30)];
    nameLab.font = [UIFont systemFontOfSize:14.0];
    [_baseScrollView addSubview:nameLab];
    nameLab.text = @"验证码";
    
    codeFiled = [[UITextField alloc]initWithFrame:CGRectMake(80, 72, kScreenWidth-200, 30)];
    codeFiled.placeholder = @"确认密码";
//    codeFiled.borderStyle = UITextBorderStyleRoundedRect;
    codeFiled.delegate = self;
    codeFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeFiled.font = [UIFont systemFontOfSize:14.0];
    codeFiled.keyboardType=UIKeyboardTypeNumberPad;
    [_baseScrollView addSubview:codeFiled];
    
    timeLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110, 72, 140, 30)];
    timeLable.text = @"获取验证码";
    timeLable.textColor = RGBCOLOR(0, 109, 217);
    timeLable.font = [UIFont systemFontOfSize:13.0];
    timeLable.userInteractionEnabled = YES;
    [_baseScrollView addSubview:timeLable];
    
    timeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    [timeBtn addTarget:self action:@selector(tryAction) forControlEvents:UIControlEventTouchUpInside];
    timeBtn.backgroundColor = [UIColor clearColor];
    [timeLable addSubview:timeBtn];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(20, 150, kScreenWidth-40, 30)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"16"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 5;
    [nextBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:nextBtn];
    
}


-(void)tryAction
{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                
//                [changeButton setFrame:CGRectMake(218, 205,70, 20)];
//                [timeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                timeLable.text = @"获取验证码";
                timeBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                            NSLog(@"____%@",strTime);
//                [changeButton setFrame:CGRectMake(160, 205,130, 20)];//(160, 253,130, 20
//                
//                [timeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                timeLable.text = [NSString stringWithFormat:@"%@秒后重新发送",strTime];
                timeBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}


-(void)nextBtn
{
    [self sendphonecodeRequest];
}
-(void)sendphonecodeRequest
{
    
    
    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    [dicInput setObject:@"ios" forKey:@"f"];
    [dicInput setObject:codeFiled.text forKey:@"code"];
    [dicInput setObject:self.phoneStr forKey:@"account"];
    NSLog(@"%@",dicInput);
    [[BMRequestManager shareBMRequestManager] phoneCodeRequest:dicInput success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        if (responseDic == nil) {
            [self showAlertWithTitle:@"提示" :@"服务器出错,请重试!" :@"确定" :nil];
        }else{
            if ([[responseDic objectForKey:@"success"] boolValue] == 1) {
                
                SLRetrieveNextViewController *retriVC = [[SLRetrieveNextViewController alloc]init];
                retriVC.accountStr=self.phoneStr;
                [self.navigationController pushViewController:retriVC animated:YES];

                
            }else{
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[responseDic objectForKey:@"errMsg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //                alert.tag = 2;
                [alert show];
            }
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
