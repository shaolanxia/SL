//
//  HomeViewController.m
//  ShuLianWang
//
//  Created by 郝威斌 on 15/3/27.
//  Copyright (c) 2015年 XXX. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BaseScrollView.h"
#import "fashion.h"
#import "AppDelegate.h"
#import "UnityLHClass.h"
#import "BMRequestManager.h"

@interface SXABaseViewController : UIViewController
{
    BaseScrollView *_baseScrollView;
}
@property (nonatomic , assign) BOOL    isStoreImg;
//添加左边按钮
- (void)addNavigationLeftButton;
- (void)addNavigationLeftButton:(NSString *)str;
- (void)addNavigationRightButton:(NSString *)str;
- (void)addNavigationRightButtonForStr:(NSString *)str;
//左边按钮点击事件
- (void)leftAction;
- (void)rightAction;
- (void)hiddenBottomBar:(BOOL)hide;
//自适应(UILabel)高度
- (float)heightForCellWithWid:(NSString *)str width:(float)wid;

- (float)AutomaticIOS7UILabel:(NSString*)strTitle font:(float)font color:(UIColor*)textColor  rectWidth:(float)labelWid rectHeight:(float)labelHgh lines:(int)lines;

 // 背景图
- (void)backViewcolour;

- (BOOL)validateMobile:(NSString *)mobileNum;
-(BOOL)isValidateEmail:(NSString *)email;

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;


// 自适应UILabel的高
- (CGSize)labelHight:(NSString*)str withSize:(CGFloat)newFloat withWide:(CGFloat)newWide;


// 获取手机IP
- (NSString *)getIPAddress;


-(void)showAlertWithTitle:(NSString *)title :(NSString *)messageStr :(NSString *)cancelBtn :(NSString *)otherBtn ;
@end
