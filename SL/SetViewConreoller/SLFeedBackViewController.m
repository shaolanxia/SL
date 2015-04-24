//
//  SLFeedBackViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/28.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLFeedBackViewController.h"
#import "SLLoginViewController.h"
@interface SLFeedBackViewController ()<UITextFieldDelegate>
{
    UITextField *phoneField;
    SZTextView *ideaTextView;
}
@end

@implementation SLFeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"意见反馈";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"意见反馈" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
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
    UIImage *backImg = [UIImage imageNamed:@"留言"];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:backImg];
    [imgView setFrame:CGRectMake(0, 0, backImg.size.width/2.2, backImg.size.height/2.2)];
    [_baseScrollView addSubview:imgView];
    
    ideaTextView = [[SZTextView alloc]initWithFrame:CGRectMake(10, 130, kScreenWidth-20, 130)];
    ideaTextView.backgroundColor = [UIColor whiteColor];
    ideaTextView.placeholder = @"请在这里输入...";
    ideaTextView.placeholderTextColor=[UIColor grayColor];
    [_baseScrollView addSubview:ideaTextView];
    
    UIView *lableBackView = [[UIView alloc]initWithFrame:CGRectMake(10, 265, kScreenWidth-20, 30)];
    lableBackView.backgroundColor = [UIColor whiteColor];
    [_baseScrollView addSubview:lableBackView];
    
    UILabel *lable = [UnityLHClass initUILabel:@"手机号" font:13.0 color:[UIColor blackColor] rect:CGRectMake(10, 5, 50, 20)];
    [lableBackView addSubview:lable];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-250, 5, 1, 20)];
    lineView.backgroundColor = [UIColor grayColor];
    [lableBackView addSubview:lineView];
    
    phoneField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth-230, 5, kScreenWidth-120, 20)];
    phoneField.placeholder = @"方便我们更快向您反馈";
    phoneField.font = [UIFont systemFontOfSize:13.0];
    phoneField.delegate = self;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [lableBackView addSubview:phoneField];
    
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 330, kScreenWidth-20, 30)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"按钮"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交意见" forState:UIControlStateNormal];
    [submitBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [submitBtn addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
    [_baseScrollView addSubview:submitBtn];
}

-(void)submitBtn
{
    NSLog(@"点击了提交意见");
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *strID=[userDefault objectForKey:@"userId"];
    
    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    [dicInput setObject:strID forKey:@"userId"];
    [dicInput setObject:phoneField.text forKey:@"mobile"];
    [dicInput setObject:ideaTextView.text forKey:@"content"];
    
    NSLog(@"%@",dicInput);
    [[BMRequestManager shareBMRequestManager] suggest:dicInput success:^(id responseDic) {
        NSLog(@"%@",responseDic);
        if ([[responseDic objectForKey:@"success"] boolValue] == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"意见发表成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 1;
            [alert show];
        }else{
            [self showAlertWithTitle:@"提示" :[responseDic objectForKey:@"errMsg"] :@"确定" :nil];
        }
        
        
    } failure:^(id errorString) {
        [UnityLHClass showAlertView:@"网络好像出了点问题，请重试！"];
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y -=60;
    frame.size.height +=60;
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
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
