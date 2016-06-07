//
//  KRUserInfo.h
//  RGKuRun
//
//  Created by TRRogen on 16/6/7.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"


@interface KRUserInfo : NSObject

singleton_interface(KRUserInfo)
//登入的用户名和密码
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userPasswrod;
//注册的名字,注册的密码
@property(nonatomic,strong)NSString *userRegisterName;
@property(nonatomic,strong)NSString *userRegisterPassword;
//判断是登入还是注册
@property(nonatomic,assign,getter=isLogin)BOOL login;

@end
