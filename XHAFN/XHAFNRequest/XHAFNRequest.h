//
//  XHAFNRequest.h
//  XHAFN
//
//  Created by 邢行 on 16/6/8.
//  Copyright © 2016年 XingHang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/** post使用方法：
=============POST================
 WCC(weakSelf);
 [XHAFNRequest postUrl:urlstr postDict:_registArr successWithBlock:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
 //自定义你处理数据的方法
 [weakself responseDict:responseObject];
 
 } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
 
 [weakself failWithError:responseObject];
 
 } iditify:nil];
 
 =============GET================
 WCC(weakSelf);
 [XHAFNRequest getUrl:urlstr postDict:_registArr successWithBlock:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
  //自定义你处理数据的方法
 [weakself responseDict:responseObject];
 
 } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
 
 [weakself failWithError:responseObject];
 
 } iditify:nil];
 
 */

//=======下面是=======正文=======非礼勿听=======非礼勿看=======😄=======
/** 防止block里循环引用*/
#define WCC(weakSelf)    __weak typeof(self) weakself = self

/** 定义一个通用的block*/
typedef void(^requestBlock)(NSURLSessionDataTask *  task,id  responseObject);

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


@end
