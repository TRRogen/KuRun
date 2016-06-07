/*
 登入流程
 1: 连接服务器(指定连接的域名)
 2. 通过XMPPStreamDelegate代理方法,获得连接成功的状态
 3. 连接成功后,就发送密码授权,进行认证,
 4. 通过XMPPStreamDelegate代理方法,获得授权成功的状态
 5. 授权成功后就发送在线消息
 
 */





#import "KRXMPPTool.h"
#import "KRUserInfo.h"
@interface KRXMPPTool ()<XMPPStreamDelegate>
@property(nonatomic,strong)KRUserInfo  *userInfo;
//设置stream ,给流对象赋值,设置代理,以及后续的模块添加
- (void) setUpXMPPStream;
//连接服务器
- (void) connecteToXMPPServer;
//发送密码进行授权
- (void) sendPasswordToServer;
//发送在线消息
- (void) sendOnlineMessage;
//发送离线消息
- (void) sendOfflineMessage;

@end

@implementation KRXMPPTool
singleton_implementation(KRXMPPTool)
-(KRUserInfo *)userInfo{
    if (!_userInfo) {
        _userInfo = [KRUserInfo sharedKRUserInfo];
    }
    return _userInfo;
}
//登入的公开方法
- (void)userLogin{
    [self connecteToXMPPServer];
}

//注册的公开方法
- (void)beginRegister{
    [self connecteToXMPPServer];
}

//连接服务器
- (void) connecteToXMPPServer{
    self.xmppStream = nil;
    if (!self.xmppStream) {
        [self setUpXMPPStream];
    }
//    断开连接
//    [self.xmppStream disconnect];
    
    //设置服务器名字IP.端口, socket,套接字
    self.xmppStream.hostName = KRXMPPHOSTNAME;
    self.xmppStream.hostPort = KRXMPPPORT;
    //设置用户名和JIDString
    NSString *userName  = nil;
    userName = self.userInfo.isLogin? self.userInfo.userName : self.userInfo.userRegisterName;
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",userName,KRXMPPDOMAIN];
    self.xmppStream.myJID  = [XMPPJID jidWithString:jidStr];
    
    NSError *error = nil;
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (error)   NSLog(@"%@",error);
    
}
-(void)setUpXMPPStream{
    self.xmppStream = [XMPPStream new];
    //设置delegate
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}



//发送密码进行授权或注册
- (void) sendPasswordToServer{
    NSString *password = nil;
    NSError *error = nil;
    if (self.userInfo.isLogin) {
        //用密码进行授权
        password = self.userInfo.userPasswrod;
        [self.xmppStream authenticateWithPassword:password error:&error];
    }else{
        //用密码进行注册
        password = self.userInfo.userRegisterPassword;
        [self.xmppStream registerWithPassword:password error:&error];
    }
    if (error) NSLog(@"%@",error);
}
//发送在线消息
- (void) sendOnlineMessage{
    //发送xmpp状态xmpp presence,让服务器知道当前连接的成功,修改当前用户的状态为在线
    [self.xmppStream sendElement:[XMPPPresence new]];
}
//发送离线消息
- (void) sendOfflineMessage{
    
}


#pragma mark- XMPPStreamDelegate
//连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    //发送密码进行登入或注册
    [self sendPasswordToServer];
    
}
//连接失败(error 不为空),或者是 user主动断开(error为空)
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    if (error)  NSLog(@"%@",error);
    if (self.userInfo.isLogin) {
        [self.delegate KRXMPPTool:self loginState:LOGINNETERROR];
    }else{
        [self.delegate KRXMPPTool:self registerState:REGISTERNETERROR];
    }
    
}

//授权成功
- (void) xmppStreamDidAuthenticate:(XMPPStream *)sender{
    [self sendOnlineMessage];
    NSLog(@"登入成功");
    [self.delegate KRXMPPTool:self loginState:LOGINSUCESS];
}
//授权失败
- (void )xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    if (error) NSLog(@"%@",error);
    [self.delegate KRXMPPTool:self loginState:LOGINFAIL];
}

//注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    NSLog(@"注册成功");
    [self.delegate KRXMPPTool:self registerState:REGISTERSUCESS];
}
//注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    if (error) NSLog(@"%@",error);
    [self.delegate KRXMPPTool:self registerState:REGISTERFAIL];

}

@end
