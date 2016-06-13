//
//  fViewController.m
//  XHAFN
//
//  Created by 邢行 on 16/6/8.
//  Copyright © 2016年 XingHang. All rights reserved.
//

#import "fViewController.h"
#import "XHAFNRequest.h"

@interface fViewController ()

@end

@implementation fViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [XHAFNRequest deadrequest];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self post];
    
}
#pragma mark - 服务接入

- (void)post{
    
    
    //服务接入
    NSString *password    =  RAP_userPwd;
    password = [XHAFNRequest md5Create:password];
    NSString *deviceid    = [XHAFNRequest uuidStr];//
    NSString *requestTime = [XHAFNRequest timeFormatter];
    NSString *username    = RAP_userName;
    NSString *secretKey   = RAP_userSecretKey;
    NSString *authSign    = [NSString stringWithFormat:@"%@%@%@%@",secretKey,username,password,requestTime];/** secretKey+username+password+requestTime*/
    
    authSign = [XHAFNRequest noEmptyStr:authSign];
    
    NSDictionary *param= @{
                           @"password":password,
                           @"deviceid":deviceid,
                           @"requestTime":requestTime,
                           @"username":username,
                           @"authSign":authSign,
                           };
    
    if (ISOTHERURL) {
        /** 发送HTTP数据请求*/
        WCC(weakSelf);
        [XHAFNRequest postUrl:URL_ServiceIn postDict:param successWithBlock:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            
            [weakself responseDict:responseObject];
            
        } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
            
            [weakself failWithError:responseObject];
            
        } iditify:nil];
        
    }
}

/** 成功之后返回的数据*/
- (void)responseDict:(NSDictionary*)dict{
    NSLog(@"\n成功之后返回的数据:%@",dict);
    //服务接入
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        NSString *res = [NSString stringWithFormat:@"%@",dict];
        [XHAFNRequest alert:res];
        NSString *msg = [NSString stringWithFormat:@"%@",dict[@"statusCode"]];
        msg = [XHAFNRequest getbackCode:msg];
        
        alertmsg(msg);
        
    }else{
        
        NSData *data  = (NSData*)dict;
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"msg:%@",msg);
        alertmsg(msg);
    }
    
    
}


/** 失败返回的数据*/
- (void)failWithError:(NSError*)error{
    
    NSLog(@"failWithError:%@",[error localizedDescription]);
    
}



/** 
 用户注册
 登录名校验
 */

@end
