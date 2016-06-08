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

    [self download];
    
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
    
    NSString *urlstr = @"http://119.57.73.148:9000/api/com/user/query";
    
    NSDictionary *_registArr= [[NSMutableDictionary alloc] init];
    [_registArr setValue:@"companyRegister" forKey:@"type"];
    [_registArr setValue:@"sfsd" forKey:@"company_name"];
    [_registArr setValue:@"rer" forKey:@"company_province"];
    [_registArr setValue:@"ewe" forKey:@"company_city"];
    [_registArr setValue:@"sdfd" forKey:@"linkman_name"];
    [_registArr setValue:@"sdfs" forKey:@"link_phone"];
    [_registArr setValue:@"sdfd" forKey:@"mobile"];
    [_registArr setValue:@"sdf" forKey:@"linkman_sex"];
    [_registArr setValue:@"sdfsd" forKey:@"password"];
    
    [XHAFNRequest postUrl:urlstr postDict:_registArr successWithBlock:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"successWithBlock");
    } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
        NSLog(@"failWithBlock");
        
    } iditify:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
