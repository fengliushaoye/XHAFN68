//
//  XHAFNRequest.m
//  XHAFN
//
//  Created by 邢行 on 16/6/8.
//  Copyright © 2016年 XingHang. All rights reserved.
//

#import "XHAFNRequest.h"
#import "AFNetworking.h"


/** 设置超时时间*/
#define kTimeOutInterval 30

@interface XHAFNRequest ()

/** 成功block*/
@property (nonatomic,copy) requestBlock successBlock;

/** 失败block*/
@property (nonatomic,copy) requestBlock failureBlock;

@end


@implementation XHAFNRequest

/** 请求的对像*/
static XHAFNRequest *request = nil;
/** 请求体*/
static AFHTTPSessionManager *manager = nil;


#pragma mark - 初始化
/** 初始化request*/
+(XHAFNRequest*)request{

    if (!request) {
        
        request = [[XHAFNRequest alloc] init];
    }

    return request;
}

/** 初始化请求者*/
-(AFHTTPSessionManager*)manager{
    
    if (!manager) {
        
        manager = [AFHTTPSessionManager manager];
        //    上传json格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        /** 上传普通格式*/
        //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        /** 获取到的是json数据*/
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        /** 获取的的普通数据*/
        //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        manager.requestSerializer.timeoutInterval = kTimeOutInterval;
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    }
    
    return manager;
    
}


#pragma mark - POST

+ (void)postUrl:(NSString*)url postDict:(NSDictionary*)parameters successWithBlock:(requestBlock)success failWithBlock:(requestBlock)fail iditify:(id)iditify{
    
    request = [self request];
    [request postUrl:url postDict:parameters];
    request.successBlock = success;
    request.failureBlock = fail;


    
}

- (void)postUrl:(NSString*)url postDict:(NSDictionary*)parameters{
    
    AFHTTPSessionManager *manager = self.manager;
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        NSLog(@"\n downloadProgress:%@",downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\n responseObject:%@",responseObject);
        if (self.successBlock) {
            self.successBlock(task,responseObject);
        }
        [task cancel];
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"\n error:%@",[error localizedDescription]);
        if (self.failureBlock) {
            self.failureBlock(task,error);
        }
        [task cancel];
        
    }];

    [self deadrequest];


}

#pragma mark - GET

+ (void)getUrl:(NSString*)url postDict:(NSDictionary*)parameters successWithBlock:(requestBlock)success failWithBlock:(requestBlock)fail iditify:(id)iditify{

    request = [self request];
    [request getUrl:url postDict:parameters];
    request.successBlock = success;
    request.failureBlock = fail;
    
    
}


- (void)getUrl:(NSString*)url postDict:(NSDictionary*)parameters{
    
    AFHTTPSessionManager *manager = self.manager;
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"\n downloadProgress:%@",downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\n responseObject:%@",responseObject);
        if (self.successBlock) {
            self.successBlock(task,responseObject);
        }
        [task cancel];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"\n error:%@",[error localizedDescription]);
        if (self.failureBlock) {
            self.failureBlock(task,error);
        }
        [task cancel];
        
    }];
    
    [self deadrequest];
    
}


#pragma mark - 网络监听 爱用不用
- (void)AFNetworkStatus{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
}



#pragma mark - 干掉 超神
/** 用完了 干掉*/
- (void)deadrequest{
    NSLog(@"1%p",request);
    NSLog(@"2%p",manager);
    request = nil;
    manager = nil;
    NSLog(@"4%p",request);
    NSLog(@"4%p",manager);

}

-(void)dealloc{
    
    NSLog(@"dealloc");
    
}


@end
