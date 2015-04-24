//
//  SLResigsterViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLResigsterViewController.h"
#import "SLLoginViewController.h"
#import "SLPerfectViewController.h"
#import "CustomInputView.h"
#import "SLAgreementViewController.h"
@interface SLResigsterViewController ()<UITextFieldDelegate>
{
    UITextField *phone;//手机号
    UITextField *verification;//验证码
//    NSString *code;//请求回来的验证码
}
@end

@implementation SLResigsterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"注册" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
titlelabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}
//获取验证码
-(void)getVerificationCodeRequest
{
    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    [dicInput setObject:@"1" forKey:@"regType"];
    [dicInput setObject:phone.text forKey:@"mobile"];
     NSLog(@"%@",dicInput);
    [[BMRequestManager shareBMRequestManager] VerificationCode:dicInput success:^(id responseDic) {
        NSLog(@"%@",responseDic);
         if ([[responseDic objectForKey:@"success"] boolValue] == 1) {
//            code=[responseDic objectForKey:@"code"];
            
        }else{
            [self showAlertWithTitle:@"提示" :[responseDic objectForKey:@"errMsg"] :@"确定" :nil];
        }
        
    } failure:^(id errorString) {
        [UnityLHClass showAlertView:@"网络好像出了点问题，请重试！"];
    }];

}
//注册
-(void)saveRegisterRequest
{
    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    [dicInput setObject:@"1" forKey:@"regType"];
    [dicInput setObject:verification.text forKey:@"code"];
    [dicInput setObject:phone.text forKey:@"mobile"];
    NSLog(@"%@",dicInput);
    [[BMRequestManager shareBMRequestManager] saveRegister:dicInput success:^(id responseDic) {
        NSLog(@"--》%@",responseDic);
        BOOL isSuccess=[[responseDic objectForKey:@"success"] boolValue];
        if ( isSuccess) {
            NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
            [userdefault setBool:YES forKey:@"isLogin"];
            SLPerfectViewController *perfect=[[SLPerfectViewController alloc]init];
            perfect.account=[[responseDic objectForKey:@"data"] objectForKey:@"account"];
            perfect.linkId=[[responseDic objectForKey:@"data"] objectForKey:@"linkId"];;
            perfect.account = phone.text;
            [self.navigationController pushViewController:perfect animated:YES];
            
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
    NSArray *placeArray = [[NSArray alloc]initWithObjects:@"手机号",@"验证码", nil];

    for (int i = 0; i < 2; i++) {
        CustomInputView *inputview=[[CustomInputView alloc]initWithFrame:CGRectMake(0, 20+i*50, kScreenWidth, 44) withLineY:80];
        [_baseScrollView addSubview:inputview];
        UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(25, 30+i*50, 60, 30)];
        nameLab.font = [UIFont systemFontOfSize:14.0];
        [_baseScrollView addSubview:nameLab];
        nameLab.text=[placeArray objectAtIndex:i];

    }

    phone = [[UITextField alloc]initWithFrame:CGRectMake(85, 32, kScreenWidth-105, 30)];
    phone.placeholder = @"手机号";
//    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.delegate = self;
    phone.tag = 10;
    phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    phone.font = [UIFont systemFontOfSize:14.0];
    phone.keyboardType=UIKeyboardTypeNumberPad;
    [_baseScrollView addSubview:phone];
    
    verification = [[UITextField alloc]initWithFrame:CGRectMake(85, 82, kScreenWidth-200, 30)];
    verification.placeholder = @"验证码";
//    verification.borderStyle = UITextBorderStyleRoundedRect;
    verification.delegate = self;
    verification.clearButtonMode = UITextFieldViewModeWhileEditing;
    verification.font = [UIFont systemFontOfSize:14.0];
    verification.keyboardType=UIKeyboardTypeNumberPad;
    [_baseScrollView addSubview:verification];
    

    
    UIButton *verifBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifBtn setFrame:CGRectMake(kScreenWidth-115, 82, 95, 30)];
    [verifBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifBtn setTitleColor:RGBCOLOR(0, 109, 217) forState:UIControlStateNormal];
    verifBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [verifBtn addTarget:self action:@selector(getVerificationCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:verifBtn];

    
    UIButton *reviserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reviserBtn setFrame:CGRectMake(20, 150, kScreenWidth-40, 30)];
    [reviserBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [reviserBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [reviserBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18.0]];
    reviserBtn.layer.masksToBounds = YES;
    reviserBtn.layer.cornerRadius = 5;
    [reviserBtn addTarget:self action:@selector(resiginAction) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:reviserBtn];
    
    UILabel *jsLable = [UnityLHClass initUILabel:@"点击注册标示已同意" font:12.0 color:[UIColor blackColor] rect:CGRectMake(20, 190, kScreenWidth-40, 20)];
    [_baseScrollView addSubview:jsLable];
    
//
    UIButton *clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-190, 190.5, 100, 20)];
    [clickBtn setTitle:@"数联用户服务协议" forState:UIControlStateNormal];
    [clickBtn setTitleColor:[UIColor colorWithRed:57.0/255.0 green:135.0/255.0 blue:215.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//    clickBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [clickBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0]];
    [clickBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:clickBtn];
    
    _baseScrollView.scrollEnabled = NO;
    
    
}


#pragma mark == 数联用户服务协议
-(void)clickBtn
{
    SLAgreementViewController *agreementVC = [[SLAgreementViewController alloc]init];
    [self.navigationController pushViewController:agreementVC animated:YES];
}

-(void)getVerificationCodeAction
{
    
    if (phone.text==nil||[phone.text isEqualToString:@""]||phone.text.length!=11)
    {
        [self showAlertWithTitle:@"提示" :@"请输入11位手机号码" :@"确定" :nil];

    }else
    {
        [self getVerificationCodeRequest];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    
    switch (textField.tag) {
        case 10:
        {
            if (range.location >= 11){
                return NO;
            }else{
                return YES;
            }
            
        }
            
            break;
            
        default:
            break;
    }
    return YES;
}


-(void)resiginAction
{
    
////    NSLog(@"%@,code=%@",verification.text,code);
////    NSInteger verif=(NSInteger)[verification.text integerValue];
////    NSInteger codee=(NSInteger)[code integerValue];
//    NSLog(@"点击了注册按钮");
//    SLPerfectViewController *perfect=[[SLPerfectViewController alloc]init];
////    perfect.account=[[responseDic objectForKey:@"data"] objectForKey:@"account"];
////    perfect.linkId=[[responseDic objectForKey:@"data"] objectForKey:@"linkId"];;
//    perfect.account = phone.text;
//    [self.navigationController pushViewController:perfect animated:YES];
    if (verification.text==nil||[verification.text isEqualToString:@""]) {
        [self showAlertWithTitle:@"提示" :@"验证码不能为空" :@"确定" :nil];
    }else
    {
        [self saveRegisterRequest];
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
