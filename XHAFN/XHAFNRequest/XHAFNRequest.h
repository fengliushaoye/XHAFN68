//
//  XHAFNRequest.h
//  XHAFN
//
//  Created by 邢行 on 16/6/8.
//  Copyright © 2016年 XingHang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XHURLHeader.h"

/** 使用方法：
=============POST================

 WCC(weakSelf);
 [XHAFNRequest postUrl:urlstr postDict:param successWithBlock:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
     //自定义你处理数据的方法
     [weakself responseDict:responseObject];
 
 } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
 
     [weakself failWithError:responseObject];
 
 } iditify:nil];
 
 =============GET================

 WCC(weakSelf);
 [XHAFNRequest getUrl:urlstr postDict:param successWithBlock:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
      //自定义你处理数据的方法
     [weakself responseDict:responseObject];
 
 } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
 
     [weakself failWithError:responseObject];
 
 } iditify:nil];
 
 */

/*
//==================================================================
                                            MagicalStar
                                            2016年06月08日13:41:54
//==================================================================
*/



@interface XHAFNRequest : NSObject

/**
 *  @author XingHang
 *
 *  @brief post请求
 *
 *  @param url        发送数据的url
 *  @param parameters 发送的json数据
 *  @param success    成功的回调
 *  @param fail       失败的回调
 *  @param iditify    暂时不用，玩意未来可能会用到呢
 */
+ (void)postUrl:(NSString*)url postDict:(NSDictionary*)parameters successWithBlock:(requestBlock)success failWithBlock:(requestBlock)fail iditify:(id)iditify;

/**
 *  @author XingHang
 *
 *  @brief get请求
 *
 *  @param url        发送数据的url
 *  @param parameters 发送的json数据
 *  @param success    成功的回调
 *  @param fail       失败的回调
 *  @param iditify    暂时不用，玩意未来可能会用到呢
 */
+ (void)getUrl:(NSString*)url postDict:(NSDictionary*)parameters successWithBlock:(requestBlock)success failWithBlock:(requestBlock)fail iditify:(id)iditify;

/**
 *  @author XingHang
 *
 *  @brief 下载
 *
 *  @param urlString 要下载的url地址
 */
+ (void)downLoadWithUrlString:(NSString *)urlString;

/**
 *  @author XingHang
 *
 *  @brief 上传
 *
 *  @param userId    用户id
 *  @param urlString 上传的url地址
 *  @param upImg     上传的图片
 */
+ (void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg;


/**
 *  @author XingHang
 *
 *  @brief 获取当前的时间 并格式化
 *
 *  @return 当前的时间
 */
+ (NSString*)timeFormatter;

/**
 *  @author XingHang
 *
 *  @brief 时间戳转时间 1381480688189 to "2016-06-11 11:51:55"
 *
 *  @param timestamp 时间戳
 *
 *  @return 转换后的时间
 */
+ (NSString*)timestampToCustom:(NSString *)timestamp;


/**
 *  @author XingHang
 *
 *  @brief 获取UUIDString
 *
 *  @return uuid
 */
+ (NSString*)uuidStr;

/**
 *  @author XingHang
 *
 *  @brief 对字符串过滤掉空格
 *
 *  @param str 需要过过滤的字符串
 *
 *  @return 过滤后的字符串
 */
+ (NSString*)noEmptyStr:(NSString*)str;

/**
 *  @author XingHang
 *
 *  @brief MD5 加密
 *
 *  @param signString 要加密的str
 *
 *  @return 加密后的字符串
 */
+(NSString *)md5Create:(NSString *)signString;


/**
 *  @author XingHang
 *
 *  @brief 根据异常code 给予用户提示
 *
 *  @param str 异常code
 *
 *  @return 提示语句
 */
+ (NSString*)getbackCode:(NSString*)str;


/** 系统弹出框*/
+ (void)alert:(NSString*)msg;


@end
