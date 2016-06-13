//
//  XHAFNRequest.m
//  XHAFN
//
//  Created by 邢行 on 16/6/8.
//  Copyright © 2016年 XingHang. All rights reserved.
//

#import "XHAFNRequest.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>


/** 设置超时时间 30秒*/
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
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        /** 上传普通格式*/
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        /** 返回到的是json数据*/
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        /** 返回的普通数据*/
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        manager.requestSerializer.timeoutInterval = kTimeOutInterval;
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
        
   
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
    
    NSLog(@"入参：\n%@",parameters);
    
    AFHTTPSessionManager *manager = [self manager];
    // 加上这行代码，https ssl 验证。
//    if(openHttpsSSL)
//    {
//    }
    NSString *requestUrl = @"";

    if ([url isEqualToString:URL_ServiceIn]) {
        //服务接入
        requestUrl = url;
        [manager setSecurityPolicy:[self customSecurityPolicyName:certificate]];
        
    }else{
        
        requestUrl = [NSString stringWithFormat:@"%@%@",URL_BASE,url];
        [manager setSecurityPolicy:[self customSecurityPolicyName:certificate_User]];

    }
    NSLog(@"\n请求的url：\n%@",requestUrl);

    
    [manager POST:requestUrl parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        NSLog(@"请求进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"\n 请求返回的数据:%@",responseObject);
        if (self.successBlock) {
            self.successBlock(task,responseObject);
        }
        [task cancel];
        [self deadrequest];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        if([error code] == NSURLErrorCancelled) {
//            return;
//        }
        NSLog(@"\n error:%@",error);
//        NSURLErrorCancelled -999

        if (self.failureBlock) {
            self.failureBlock(task,error);
        }
        [task cancel];
        [self deadrequest];

    }];



}

#pragma mark - GET

+ (void)getUrl:(NSString*)url postDict:(NSDictionary*)parameters successWithBlock:(requestBlock)success failWithBlock:(requestBlock)fail iditify:(id)iditify{

    request = [self request];
    [request getUrl:url postDict:parameters];
    request.successBlock = success;
    request.failureBlock = fail;
    
    
}


- (void)getUrl:(NSString*)url postDict:(NSDictionary*)parameters{
    
    AFHTTPSessionManager *manager = [self manager];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"当前进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"\n responseObject:%@",responseObject);
        if (self.successBlock) {
            self.successBlock(task,responseObject);
        }
        [task cancel];
        [self deadrequest];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"\n error:%@",[error localizedDescription]);
        if (self.failureBlock) {
            self.failureBlock(task,error);
        }
        [task cancel];
        [self deadrequest];

    }];
    
    
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


#pragma mark - 下载

+ (void)downLoadWithUrlString:(NSString *)urlString
{    
    request = [self request];
    [request downLoadWithUrlString:urlString];
    
}

- (void)downLoadWithUrlString:(NSString *)urlString{

    // 1.创建管理者对象
        AFHTTPSessionManager *manager = [self manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlString];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"%@---%@", response, filePath);
    }];
    // 5.启动下载任务
    [task resume];

    [self deadrequest];
}


#pragma mark - 上传

+ (void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg
{
    request = [self request];
    [request uploadWithUser:userId UrlString:urlString upImg:upImg];
    
}

- (void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg{
 
    // 创建管理者对象
    AFHTTPSessionManager *manager = [self manager];
    // 参数
    NSDictionary *param = @{@"user_id":userId};
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
        // 把图片转换成data
        NSData *data = UIImagePNGRepresentation(upImg);
        NSString *fileName = @"123.png";
        NSString *mimeType = @"image/png";
        // 拼接数据到请求体中
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:mimeType];
       
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 打印上传进度
        NSLog(@"当前上传进度:%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"上传成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"上传失败：%@",error);
    }];
    
    [self deadrequest];
    
}

#pragma mark - 干掉 超神
/** 用完了 干掉*/
- (void)deadrequest{
   
//    NSLog(@"1%p",request);
//    NSLog(@"2%p",manager);
    
    manager = nil;
    request = nil;
    
//    NSLog(@"4%p",request);
//    NSLog(@"4%p",manager);

//    NSLog(@"deadrequest");

}

-(void)dealloc{
    
//    NSLog(@"dealloc");
    
}

#pragma mark - 其他常用方法

#pragma mark - 时间格式化

/** 获取当前时间并格式化为 "2016-06-11 11:51:55"*/
+ (NSString*)timeFormatter{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *nowdateStr = [formatter stringFromDate:date];
    
//    NSLog(@"当前的时间戳：%f",[date timeIntervalSince1970]);
    
    return nowdateStr;
    
}

#pragma mark - 时间戳转时间

/** 时间戳转时间 1381480688189 to "2016-06-11 11:51:55"*/
+ (NSString*)timestampToCustom:(NSString *)timestamp{

    NSString *substr = @"";

    if (timestamp.length >10) {
        
        substr = [timestamp substringToIndex:10];
        
    }else{
        
        substr = timestamp;
    }
    
    NSTimeInterval timeinterval = [substr doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *nowdateStr = [formatter stringFromDate:date];
    
    return nowdateStr;

}


#pragma mark - UUID
/** 获取UUIDString*/
+ (NSString*)uuidStr{
    
   return  [UIDevice currentDevice].identifierForVendor.UUIDString;
    
}



#pragma mark - 对字符串去空格

+ (NSString*)noEmptyStr:(NSString*)str{
    
//    NSLog(@"\n认证签名去空格前\n%@",str);
    
    NSString *endstr =  [str stringByReplacingOccurrencesOfString:@" " withString:@""];
   
//    NSLog(@"\n认证签名去空格后加密前\n%@",endstr);
    //大写
    endstr = [self md5Create:endstr];

//    NSLog(@"\n认证签名去空格后加密后\n%@",endstr);

    return endstr;

}

#pragma mark -- MD5加密
+(NSString *)md5Create:(NSString *)signString{
    
    const char*cStr =[signString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ].uppercaseString;
    
    //大写uppercaseString 小写lowercaseString
}

- (AFSecurityPolicy*)customSecurityPolicyName:(NSString*)name
{
    /*
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    securityPolicy.pinnedCertificates =  [NSSet setWithArray:@[certData]];
    */
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:name ofType:@"cer"];
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet   = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否允许,NO-- 不允许无效的证书
    [securityPolicy setAllowInvalidCertificates:YES];
    // 设置证书
    [securityPolicy setPinnedCertificates:certSet];
    
    return securityPolicy;
}



#pragma mark - 处理异常

+ (NSString*)getbackCode:(NSString*)str{
    
     /**  1. 成功。 2. 认证签名异常。 3. 账户认证失败（用户或密码不正确）。 4. 账户认证失败（账户已失效或锁定）。 5. 服务器异常。*/
    int index = [str intValue];
    NSString *msg = @"";
    switch (index) {
        case 1:
            msg = @"成功";
            break;
        case 2:
            msg = @"认证签名异常";
            break;
        case 3:
            msg = @"账户认证失败（用户或密码不正确";
            break;
        case 4:
            msg = @"账户认证失败（账户已失效或锁定";
            break;
        case 5:
            msg = @"服务器异常";
            break;
        default:
            msg = @"发生未知错误";
            break;
    }
    return msg;
   
    
}


/** 系统弹出框*/
+ (void)alert:(NSString*)msg{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

@end
