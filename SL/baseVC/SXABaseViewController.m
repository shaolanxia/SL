//
//  SLLoginViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//


#import "SXABaseViewController.h"
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>

#import <ifaddrs.h>
#import <arpa/inet.h>

@interface SXABaseViewController ()<UIAlertViewDelegate>
{
    UIImageView *naviBar;
    UILabel *titleLabel;
}
@end

@implementation SXABaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//         self.navigationController.navigationItem.hidesBackButton = YES;
    }
    return self;
}

#pragma mark - 用户自定义方法
- (void)addNavigationLeftButton
{
    UIImageView *imageView = [UnityLHClass initUIImageView:@"左箭头大" rect:CGRectMake(-5, 10,[UIImage imageNamed:@"左箭头大"].size.width/2.5,[UIImage imageNamed:@"左箭头大"].size.height/2.5)];
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0,0,44,44);
//    [leftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addSubview:imageView];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

}
- (void)addNavigationLeftButton:(NSString *)str
{
    UIImageView *imageView = [UnityLHClass initUIImageView:str rect:CGRectMake(0, 10,[UIImage imageNamed:str].size.width/2,[UIImage imageNamed:str].size.height/2)];
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0,0,44,44);
    //    [leftButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addSubview:imageView];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

}
- (void)addNavigationRightButton:(NSString *)str
{
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardButton.frame = CGRectMake(kScreenWidth-[UIImage imageNamed:str].size.width/2, 12,[UIImage imageNamed:str].size.width/2,[UIImage imageNamed:str].size.height/2);
    [forwardButton setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;

}
- (void)addNavigationRightButtonForStr:(NSString *)str{
    UIButton *forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    forwardButton.frame = CGRectMake(kScreenWidth-[UIImage imageNamed:str].size.width/2, 12,[UIImage imageNamed:str].size.width/2,[UIImage imageNamed:str].size.height/2);
    forwardButton.frame =CGRectMake(kScreenWidth-50, 12, 50, 30);
    [forwardButton setTitle:str forState:UIControlStateNormal];
//    [forwardButton setBackgroundImage:[UIImage imageNamed:@"02-shuxian.png"] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:forwardButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
-(void)rightAction
{
    
}
-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    
}
#pragma mark - 系统方法
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    _baseScrollView=[[BaseScrollView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kContentHeight+70)];
//    if (VersionNumber_iOS_7) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
////    _baseScrollView=[[BaseScrollView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kContentHeight+64)];
////    }
//        _baseScrollView=[[BaseScrollView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kContentHeight+70)];
//    }else{
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    }

    _baseScrollView.showsHorizontalScrollIndicator = NO;
    _baseScrollView.showsVerticalScrollIndicator = NO;
//    _baseScrollView.backgroundColor = [UIColor whiteColor];
    [_baseScrollView setBackgroundColor:RGBCOLOR(235, 238, 243)];
    _baseScrollView.contentSize = _baseScrollView.bounds.size;
    _baseScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_baseScrollView];
    
//    if (VersionNumber_iOS_6) {
//        _baseScrollView.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight-34);
//    }
    if (VersionNumber_iOS_6) {
        _baseScrollView.frame =  CGRectMake(0, 0, kScreenWidth, kScreenHeight-44);
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    
//    [self initNavigationBar];
//    [self addNavigationLeftButton];
    
    
}




//-(void)initNavigationBar{
//    naviBar = [[UIImageView alloc] initWithFrame:CGRectMake(-4,-4, kScreenWidth+8, 50)];
//    if (VersionNumber_iOS_7) {
//        naviBar.frame = CGRectMake(-4,18, kScreenWidth+8, 50);
//    }
//    naviBar.image = [UIImage imageNamed:@"顶部"];
//    titleLabel = [[UILabel alloc] initWithFrame:naviBar.bounds];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.textColor = [UIColor whiteColor];
//    //    titleLabel.text = @"搜多000";
//    naviBar.userInteractionEnabled = YES;
//    [naviBar addSubview:titleLabel];
//    [self.view addSubview:naviBar];
//}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nohiddenBottomBar:(BOOL)hide
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    CGRect rect = delegate.bottomBarView.frame;
    rect.origin.y = hide ? kScreenHeight : kScreenHeight - 62;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        rect.origin.y = rect.origin.y - 20;
    }
    
    [UIView animateWithDuration:0.1f animations:^(void) {
        delegate.bottomBarView.frame = rect;
    } completion:^(BOOL finished) {
    }];
}


- (void)hiddenBottomBar:(BOOL)hide
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    CGRect rect = delegate.bottomBarView.frame;
    rect.origin.y = hide ? kScreenHeight : kScreenHeight - 62;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
    {
        rect.origin.y = rect.origin.y - 20;
    }
    
    [UIView animateWithDuration:0.1f animations:^(void) {
        delegate.bottomBarView.frame = rect;
    } completion:^(BOOL finished) {
    }];
}
//自适应(UILabel)高度
-(float)heightForCellWithWid:(NSString *)str width:(float)wid
{
    CGSize constraint = CGSizeMake(12.0f, 20000.0f);
    CGSize size = [@"测" sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    CGSize titleSize = [str sizeWithFont:[UIFont fontWithName:@"Arial" size:12] constrainedToSize:CGSizeMake(MAXFLOAT, size.height)];
    
    
    float width = titleSize.width;
    float h = width/wid;
    return size.height*h+20;
}

//ios 7 适配自适应高度
- (float)AutomaticIOS7UILabel:(NSString*)strTitle font:(float)font color:(UIColor*)textColor  rectWidth:(float)labelWid rectHeight:(float)labelHgh lines:(int)lines
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = strTitle;
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:font];
    label.numberOfLines = lines;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    //labelHgh 高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize size =CGSizeMake(labelWid,labelHgh);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName,nil];
    CGSize actualsize =[strTitle boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return actualsize.height;
}

- (void)backViewcolour
{
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}


- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
//利用正则表达式验证手机号
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSString *gu =@"^((010|021|022|023|024|025|026|027|028|029|852)|(\(010)|\(021)|\(022)|\(023)|\(024)|\(025)|\(026)|\(027)|\(028)|\(029)|\(852)))\\D\\d{8}|(0[3-9][1-9]{2})|(\(0[3-9][1-9]{2})\\d{7,8}))\\d\\d{1,4}$";//@"^(\\d{3,4}-)?\\d{7,8})$|(13[0-9]{9}";
    /**
     20         * 中国电信：China ;Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestgu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestgu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//利用正则表达式验证邮箱
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 自适应UILabel的高
- (CGSize)labelHight:(NSString*)str withSize:(CGFloat)newFloat withWide:(CGFloat)newWide
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:newFloat];
    CGSize constraint = CGSizeMake(newWide, 20000.0f);
    CGSize size = [str sizeWithFont:font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}



- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

//提示框
-(void)showAlertWithTitle:(NSString *)title :(NSString *)messageStr :(NSString *)cancelBtn :(NSString *)otherBtn {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:messageStr delegate:self cancelButtonTitle:cancelBtn otherButtonTitles:otherBtn, nil];
    [alert show];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

@end
