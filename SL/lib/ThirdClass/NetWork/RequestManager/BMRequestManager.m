//
//  BMRequestManager.m
//  UnityLH
//
//  Created by apple on 13-5-28.
//  Copyright (c) 2013年 UnityLH. All rights reserved.
//

#import "BMRequestManager.h"

@implementation BMRequestManager

static BMRequestManager *requesteManager;

+ (BMRequestManager*)shareBMRequestManager
{
    @synchronized(self)
    {
        if (requesteManager == nil) {
            requesteManager = [[BMRequestManager alloc] init];
        }
    }
    return requesteManager;
}

-(void)cleanRequest
{
    [request clearDelegatesAndCancel];
}
//获取验证码
-(void)VerificationCode:(NSDictionary *)dataDic
        success:(void (^)(id responseDic))success
        failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"register/sendVerificationCode";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}
//注册
-(void)saveRegister:(NSDictionary *)dataDic
       success:(void (^)(id responseDic))success
       failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"saveRegister";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}
//完善用户信息
-(void)activateUser:(NSDictionary *)dataDic
            success:(void (^)(id responseDic))success
            failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"activateUser";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}
//找回密码
-(void)findForgetPwd:(NSDictionary *)dataDic
            success:(void (^)(id responseDic))success
            failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"setting/setForgetPwd";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}

//发送手机号
-(void)sendCodeRequest:(NSDictionary *)dataDic
             success:(void (^)(id responseDic))success
             failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"setting/sendCode";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}
//图片验证
-(void)picCodeRequest:(NSDictionary *)dataDic
               success:(void (^)(id responseDic))success
               failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"setting/getPicCode";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}
//手机验证
-(void)phoneCodeRequest:(NSDictionary *)dataDic
              success:(void (^)(id responseDic))success
              failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"setting/checkCode";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}

//登陆
-(void)Login:(NSDictionary *)dataDic
            success:(void (^)(id responseDic))success
            failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}



//posttRequestWithAction
//修改密码
-(void)EditPwd:(NSDictionary *)dataDic
     success:(void (^)(id responseDic))success
     failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"setting/updatePassword";
    [self posttRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}
//修改昵称
-(void)EditRealName:(NSDictionary *)dataDic
       success:(void (^)(id responseDic))success
       failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"setting/setUserInfo";
    [self posttRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}
//意见反馈
-(void)suggest:(NSDictionary *)dataDic
       success:(void (^)(id responseDic))success
       failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"suggest/addSuggest";
    [self postDucRequestWithActionLottery:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}
//postDucRequestWithActionLottery

//首页 /Advertisement/GetBondTransferList /Advertisement/GetBondTransferList
-(void)homePage:(NSDictionary *)dataDic
            success:(void (^)(id responseDic))success
            failure:(void (^)(id errorString))failure
{
    NSString *interfaceName = @"Advertisement/Index";
    [self postRequestWithAction:interfaceName params:dataDic hasSession:NO success:success failure:failure];
}




@end
