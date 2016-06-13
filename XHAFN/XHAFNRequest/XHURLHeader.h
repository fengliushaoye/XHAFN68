//
//  XHURLHeader.h
//  XHAFN
//
//  Created by 邢行 on 16/6/8.
//  Copyright © 2016年 XingHang. All rights reserved.
//

#ifndef XHURLHeader_h
#define XHURLHeader_h

/** 统一平台的url发送请求的开关*/
static BOOL const ISOTHERURL = YES;//yes 用同一平台 no 用socket


/** 防止block里循环引用*/
#define WCC(weakSelf)    __weak typeof(self) weakself = self

#define alertmsg(msg)  [XHAFNRequest alert:[XHAFNRequest getbackCode:msg]]

/** 定义一个通用的block*/
typedef void(^requestBlock)(NSURLSessionDataTask *  task,id  responseObject);


//所有请求的url
/** 基础的url
 测试环境   usc.esgmallt.com
 准生产环境 usc.esgmall.com
 生产环境   usc.esgcc.com.cn
 */
static NSString * const URL_BASE = @"https://usc.esgmallt.com/user/";

/** 用户注册*/
static NSString * const URL_regedit = @"regedit";

/** 登录名校验*/
static NSString * const URL_checkloginname = @"checkloginname";

/** 手机号校验*/
static NSString * const URL_checkmobile = @"checkmobile";

/** 邮箱校验*/
static NSString * const URL_checkemail = @"checkemail";

/** 授权登录 authlogin*/
static NSString * const URL_authlogin = @"authlogin";

/** 用户信息更新 update*/
static NSString * const URL_update = @"update";

/** 用户实名认证 realnameauth*/
static NSString * const URL_realnameauth = @"realnameauth";

/** 修改密码 updatepassword*/
static NSString * const URL_updatepassword = @"updatepassword";

/** 用电绑定 powerbind*/
static NSString * const URL_powerbind = @"powerbind";

/** 解除绑定 powerunbund*/
static NSString * const URL_powerunbund = @"powerunbund";

/** 用户认证*/
static NSString * const URL_oauth = @"oauth";

/** 用户查询*/
static NSString * const URL_query = @"query";



/** 服务接入所需url https://sip.esgmallt.com/sip/authz/gettoken */
//测试请求地址 http://119.57.73.148:9000/api/com/user/query
//https://api.weibo.com/2/comments/reply.json 微博测试接口

//static NSString * const URL_ServiceIn = @"https://api.weibo.com/2/comments/reply.json";
static NSString * const URL_ServiceIn = @"https://sip.esgmallt.com/sip/authz/gettoken";

/** 服务接入所需参数*/
static NSString * const RAP_userName = @"zsdl";
static NSString * const RAP_userPwd = @"12#$abcd";
static NSString * const RAP_userSecretKey = @"48CBAE029A73014056B1C49D64367E94";







#endif /* XHURLHeader_h */
