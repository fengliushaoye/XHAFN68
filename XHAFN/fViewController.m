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
    
    [XHAFNRequest downLoadWithUrlString:@"http://www.baidu.com"];
    
}



/** 
 用户注册
 登录名校验
 */

@end
