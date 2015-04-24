//
//  BMRequestManager.h
//  UnityLH
//
//  Created by apple on 13-5-28.
//  Copyright (c) 2013年 UnityLH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMBaseManager.h"

@interface BMRequestManager : BMBaseManager

+ (BMRequestManager*)shareBMRequestManager;

-(void)cleanRequest;


//首页  /Advertisement/GetBondTransferList
-(void)homPage:(NSDictionary *)dataDic
       success:(void (^)(id responseDic))success
       failure:(void (^)(id errorString))failure;

//获取验证码
-(void)VerificationCode:(NSDictionary *)dataDic
                success:(void (^)(id responseDic))success
                failure:(void (^)(id errorString))failure;
//注册
-(void)saveRegister:(NSDictionary *)dataDic
            success:(void (^)(id responseDic))success
            failure:(void (^)(id errorString))failure;
//完善用户信息
-(void)activateUser:(NSDictionary *)dataDic
            success:(void (^)(id responseDic))success
            failure:(void (^)(id errorString))failure;
//找回密码
-(void)findForgetPwd:(NSDictionary *)dataDic
             success:(void (^)(id responseDic))success
             failure:(void (^)(id errorString))failure;

//图片验证
-(void)sendCodeRequest:(NSDictionary *)dataDic
               success:(void (^)(id responseDic))success
               failure:(void (^)(id errorString))failure;
//通过图片验证
-(void)picCodeRequest:(NSDictionary *)dataDic
              success:(void (^)(id responseDic))success
              failure:(void (^)(id errorString))failure;
//通过手机号验证
-(void)phoneCodeRequest:(NSDictionary *)dataDic
                success:(void (^)(id responseDic))success
                failure:(void (^)(id errorString))failure;

//登录
-(void)Login:(NSDictionary *)dataDic
     success:(void (^)(id responseDic))success
     failure:(void (^)(id errorString))failure;
//修改密码
-(void)EditPwd:(NSDictionary *)dataDic
       success:(void (^)(id responseDic))success
       failure:(void (^)(id errorString))failure;
//修改昵称
-(void)EditRealName:(NSDictionary *)dataDic
            success:(void (^)(id responseDic))success
            failure:(void (^)(id errorString))failure;

//意见反馈
-(void)suggest:(NSDictionary *)dataDic
       success:(void (^)(id responseDic))success
       failure:(void (^)(id errorString))failure;
@end
