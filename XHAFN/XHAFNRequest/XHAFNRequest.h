//
//  XHAFNRequest.h
//  XHAFN
//
//  Created by 邢行 on 16/6/8.
//  Copyright © 2016年 XingHang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 定义一个通用的block*/
typedef void(^requestBlock)(NSURLSessionDataTask *  task,id  responseObject);

@interface XHAFNRequest : NSObject

/** post请求*/
+ (void)postUrl:(NSString*)url postDict:(NSDictionary*)parameters successWithBlock:(requestBlock)success failWithBlock:(requestBlock)fail iditify:(id)iditify;

/** get请求*/
+ (void)getUrl:(NSString*)url postDict:(NSDictionary*)parameters successWithBlock:(requestBlock)success failWithBlock:(requestBlock)fail iditify:(id)iditify;

/** 下载*/
+ (void)downLoadWithUrlString:(NSString *)urlString;

/** 上传*/
+ (void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg;


@end
