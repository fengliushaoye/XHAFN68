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


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
