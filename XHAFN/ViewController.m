//
//  ViewController.m
//  XHAFN
//
//  Created by 邢行 on 16/6/8.
//  Copyright © 2016年 XingHang. All rights reserved.
//

#import "ViewController.h"
#import "XHAFNRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self post];
    
}


- (void)download{
    
    [XHAFNRequest downLoadWithUrlString:@"http://photo.enterdesk.com/2011-2-16/enterdesk.com-1AA0C93EFFA51E6D7EFE1AE7B671951F.jpg"];
    
}



- (void)get{
    
    [XHAFNRequest getUrl:@"http://119.57.73.148:9000/api/com/user/query" postDict:nil successWithBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failWithBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
    } iditify:nil];
    
}

- (void)post{
    
    NSString *urlstr = @"https://usc.esgcc.com.cn/user/regedit";
    NSDictionary *param= [[NSMutableDictionary alloc] init];
    [param setValue:@"companyRegister" forKey:@"type"];
    
    /** 发送HTTP数据请求*/
    WCC(weakSelf);
    [XHAFNRequest postUrl:urlstr postDict:param successWithBlock:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        [weakself responseDict:responseObject];
        
    } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
        
        [weakself failWithError:responseObject];
        
    } iditify:nil];
    
    
}

/** 成功之后返回的数据*/
- (void)responseDict:(NSDictionary*)dict{
    
    NSLog(@"responseDict:%@",dict);
    
}

/** 失败返回的数据*/
- (void)failWithError:(NSError*)error{
    
    NSLog(@"responseDict:%@",[error localizedDescription]);
    


    
}

    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
