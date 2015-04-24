//
//  SLRetrieveViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLRetrieveViewController.h"
#import "SLCodeViewController.h"
#import "CustomInputView.h"
@interface SLRetrieveViewController ()<UITextFieldDelegate>
{
    UITextField *phone;
    UITextField *verification;
    UIImageView *oderImgView;
    NSString *code; //验证码
}
@end

@implementation SLRetrieveViewController

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
-(void)viewWillAppear:(BOOL)animated
{
    [self  getCodeRequest];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDate *date = [NSDate date];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000/60000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    
    NSArray *array = [timeString componentsSeparatedByString:@"."];
    NSString *Str=[array objectAtIndex:0];
    NSLog(@"%@  %@",Str,timeString);
       [self addNavigationLeftButton];
    // Do any additional setup after loading the view.
    [self initView];
}

-(void)initView
{
    NSArray *placeArray = [[NSArray alloc]initWithObjects:@"账号",@"验证码", nil];
    
    for (int i = 0; i < 2; i++) {
        CustomInputView *inputview=[[CustomInputView alloc]initWithFrame:CGRectMake(0, 20+i*50, kScreenWidth, 44) withLineY:80];
        [_baseScrollView addSubview:inputview];
        UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(25, 30+i*50, 60, 30)];
        nameLab.font = [UIFont systemFontOfSize:14.0];
        [_baseScrollView addSubview:nameLab];
        nameLab.text=[placeArray objectAtIndex:i];
        
    }
    
    phone = [[UITextField alloc]initWithFrame:CGRectMake(85, 32, kScreenWidth-105, 30)];
    phone.placeholder = @"手机号/邮箱/用户名";
    //    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.delegate = self;
    phone.tag = 1;
    phone.font = [UIFont systemFontOfSize:14.0];
    phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    phone.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [_baseScrollView addSubview:phone];
    
    verification = [[UITextField alloc]initWithFrame:CGRectMake(85, 82, kScreenWidth-200, 30)];
    verification.placeholder = @"验证码";
    //    verification.borderStyle = UITextBorderStyleRoundedRect;
    verification.delegate = self;
    verification.clearButtonMode = UITextFieldViewModeWhileEditing;
    verification.font = [UIFont systemFontOfSize:14.0];
    verification.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [_baseScrollView addSubview:verification];
    
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    oderImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-115, 82, 95, 30)];
    oderImgView.backgroundColor = [UIColor whiteColor];
//    [oderImgView sd_setImageWithURL:[NSURL URLWithString:@"http://login.duc.cn/authImage"] placeholderImage:nil];
    oderImgView.userInteractionEnabled = YES;
    [_baseScrollView addSubview:oderImgView];
    
    UIButton *verifBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifBtn setFrame:CGRectMake(0, 0, 95, 30)];
//    [verifBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [verifBtn setTitleColor:RGBCOLOR(0, 109, 217) forState:UIControlStateNormal];
//    verifBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [verifBtn addTarget:self action:@selector(getVerificatCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [oderImgView addSubview:verifBtn];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(20, 150, kScreenWidth-40, 30)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 5;
    [nextBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:nextBtn];
    
    
    
    
}

-(void)getVerificatCodeAction
{
    [self getCodeRequest];
//    [[SDImageCache sharedImageCache] clearDisk];
//    [[SDImageCache sharedImageCache] clearMemory];
//    [oderImgView sd_setImageWithURL:[NSURL URLWithString:@"http://login.duc.cn/authImage"] placeholderImage:nil];
//    [oderImgView reloadInputViews];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)getCodeRequest
{
    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    
    [[BMRequestManager shareBMRequestManager] picCodeRequest:dicInput success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        BOOL result=[[responseDic objectForKey:@"success"] boolValue];
        if (result) {
            code=[[responseDic objectForKey:@"data"] objectForKey:@"code"];
            [oderImgView sd_setImageWithURL:[NSURL URLWithString:[[responseDic objectForKey:@"data"] objectForKey:@"codePic"]] placeholderImage:nil];
        }else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[responseDic objectForKey:@"errMsg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 2;
            [alert show];

        }
        

//        self.imgDic = responseDic;
//        NSLog(@"%@",[responseDic objectForKey:@"url"]);
//        
//        str2 =  [NSString stringWithFormat:@"http://202.102.72.31:88%@",[responseDic objectForKey:@"url"]];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str2]];
//        [self.webview loadRequest:request];
        //        str = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"url"]];
        
    } failure:^(id errorString) {
        [UnityLHClass showAlertView:@"连接失败，请重试！"];
    }];
    
}
-(void)nextBtn
{
    NSLog(@"点击了注册按钮");//|| phone.text.length!=11
    NSString *codeStr=[NSString stringWithFormat:@"%@",code];
    if (phone.text == nil || [phone.text isEqualToString:@""] )
    {
        [self showAlertWithTitle:@"提示" :@"请输入11位手机号码" :@"确定" :nil];
        
    }else
    

    if (![verification.text isEqualToString:codeStr]) {
        [self showAlertWithTitle:@"提示" :@"验证码不正确请重新输入" :@"确定" :nil];
    }else
    {
        [self sendRequest];
        
    }
}

//获取验证码
#define NUMBER_OF_CHARS = @"23456789ABCDEFGHJKLMNPQRSTUVWXYZ"



-(void)sendRequest
{
    

    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    [dicInput setObject:@"ios" forKey:@"f"];
    [dicInput setObject:phone.text forKey:@"account"];
    NSLog(@"%@",dicInput);
    [[BMRequestManager shareBMRequestManager] sendCodeRequest:dicInput success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        if (responseDic == nil) {
            [self showAlertWithTitle:@"提示" :@"服务器出错,请重试!" :@"确定" :nil];
        }else{
            if ([[responseDic objectForKey:@"success"] boolValue] == 1) {
                
//                code = [responseDic objectForKey:@"code"];
                
                SLCodeViewController *retriVC = [[SLCodeViewController alloc]init];
                retriVC.phoneStr = [[responseDic objectForKey:@"data"] objectForKey:@"account"];
                retriVC.typeNameStr=[[responseDic objectForKey:@"data"] objectForKey:@"typeName"];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            
            [[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearMemory];
            [self getCodeRequest];
//            [oderImgView sd_setImageWithURL:[NSURL URLWithString:@"http://login.duc.cn/authImage"] placeholderImage:nil];
//            [oderImgView reloadInputViews];
            
            verification.text = @"";
            [verification becomeFirstResponder];
        }
    }else{
        
    }
}

-(void)pushNext
{
    NSLog(@"点击了注册按钮");

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    
//    switch (textField.tag) {
//        case 1:
//        {
//            if (range.location >= 11){
//                return NO;
//            }else{
//               return YES;
//            }
//
//        }
//    
//            break;
//            
//        default:
//            break;
//    }
    return YES;
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
