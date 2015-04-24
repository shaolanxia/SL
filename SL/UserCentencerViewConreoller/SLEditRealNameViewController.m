//
//  SLEditRealNameViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/4/1.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "SLEditRealNameViewController.h"

@interface SLEditRealNameViewController ()<UITextFieldDelegate>
{
    NSString *strID;
    UITextField *realNamefiled;
}
@end

@implementation SLEditRealNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改昵称";
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];//allocate titleView
        titleView.backgroundColor = [UIColor clearColor];
        
        UILabel* titlelabel = [UnityLHClass initUILabel:@"修改昵称" font:16.0 color:[UIColor whiteColor] rect:CGRectMake(0, 0, 200, 44)];
        [titleView addSubview:titlelabel];
        self.navigationItem.titleView = titleView;
        titlelabel.textAlignment=NSTextAlignmentCenter;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationLeftButton];
    [self addNavigationRightButtonForStr:@"保存"];
    // Do any additional setup after loading the view.
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    strID = [user objectForKey:@"userId"];
    
    [self initView];
}

-(void)initView
{
    realNamefiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 74, kScreenWidth-20, 30)];
    realNamefiled.placeholder = @"昵称";
    realNamefiled.delegate = self;
    realNamefiled.clearButtonMode = UITextFieldViewModeAlways;
    realNamefiled.borderStyle = UITextBorderStyleRoundedRect;
    realNamefiled.font = [UIFont systemFontOfSize:15.0];
    [realNamefiled becomeFirstResponder];
    [self.view addSubview:realNamefiled];

}

-(void)rightAction
{
    NSMutableDictionary *dicInput = [[NSMutableDictionary alloc] init];
    [dicInput setObject:strID forKey:@"userId"];
    [dicInput setObject:realNamefiled.text forKey:@"realName"];
    
    NSLog(@"%@",dicInput);
    [[BMRequestManager shareBMRequestManager] EditRealName:dicInput success:^(id responseDic) {
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

//    [realNamefiled resignFirstResponder];
    
//    NSString *requestUrl = [NSString stringWithFormat:@"%@userId=%@&realName=%@",SLEditUserName_DATA,strID,realNamefiled.text];
//    NSLog(@"requestUrl == %@",requestUrl);
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"----%@",responseObject);
//        if ([[responseObject objectForKey:@"success"]boolValue] == 1) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            alert.tag = 1;
//            [alert show];
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改失败,请重试!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            alert.tag = 2;
//            [alert show];
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"error----%@",error);
//    }];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (alertView.tag == 2) {
        if (buttonIndex == 0) {
        }
    }else if (alertView.tag == 3) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
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
