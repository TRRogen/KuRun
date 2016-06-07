//
//  KRXMPPTool.h
//  RGKuRun
//
//  Created by TRRogen on 16/6/7.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "Singleton.h"
typedef enum{
    LOGINSUCESS,
    LOGINFAIL,
    LOGINNETERROR
} KRXMPPToolLogInState;
typedef enum{
    REGISTERSUCESS,
    REGISTERFAIL,
    REGISTERNETERROR
} KRXMPPToolRegisterState;
@class KRXMPPTool;
//定义协议让控制器知道登入状态
@protocol  KRXMPPToolDelegate<NSObject>

- (void)KRXMPPTool:(KRXMPPTool*)xmppTool loginState:(KRXMPPToolLogInState)state;

- (void)KRXMPPTool:(KRXMPPTool*)xmppTool registerState:(KRXMPPToolRegisterState)state;

@end



@interface KRXMPPTool : NSObject
singleton_interface(KRXMPPTool)
//代理属性
@property(nonatomic,weak)id<KRXMPPToolDelegate> delegate;

//XMPPStream的是和XMPP server交换的核心类
@property(nonatomic,strong)XMPPStream *xmppStream;

//登入的公开方法
- (void)userLogin;
//注册的公开方法
- (void)beginRegister;

@end
