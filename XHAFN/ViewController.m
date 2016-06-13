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
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)login:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    [self post:_name.text pwd:_pwd.text];

//    [self get];
    
//    NSLog(@"%@",[XHAFNRequest timestampToCustom:@"1381480688189"]);
//    NSLog(@"%@",[XHAFNRequest timeFormatter]);
//    NSLog(@"%@",[XHAFNRequest uuidStr]);


    
    
}


- (void)cutimg{
    
    UIImage *image ;
    //1
    [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    //2
    [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
}

- (void)download{
    
    [XHAFNRequest downLoadWithUrlString:@"http://photo.enterdesk.com/2011-2-16/enterdesk.com-1AA0C93EFFA51E6D7EFE1AE7B671951F.jpg"];
    
}



- (void)get{
    
    [XHAFNRequest getUrl:URL_ServiceIn postDict:nil successWithBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failWithBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
    } iditify:nil];
    
}

- (void)post:(NSString*)name pwd:(NSString*)pwd{

    //服务接入
    NSString *password    = pwd;
    NSString *deviceid    = [XHAFNRequest uuidStr];
    NSString *requestTime = [XHAFNRequest timeFormatter];
    NSString *username    = name;
    NSString *secretKey   = RAP_userSecretKey;
    NSString *authSign    = [NSString stringWithFormat:@"%@%@%@%@",secretKey,username,[XHAFNRequest md5Create:password],requestTime];/** secretKey+username+password+requestTime*/

    authSign = [XHAFNRequest noEmptyStr:authSign];

    NSDictionary *param= @{
                           @"password":password,
                           @"deviceid":deviceid,
                           @"requestTime":requestTime,
                           @"username":username,
                           @"authSign":authSign,
                           };

    if (ISOTHERURL) {
        /** 发送HTTP数据请求*/
        WCC(weakSelf);
        [XHAFNRequest postUrl:URL_ServiceIn postDict:param successWithBlock:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            
            [weakself responseDict:responseObject];
            
        } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
            
            [weakself failWithError:responseObject];
            
        } iditify:nil];
        
    }
}

/** 成功之后返回的数据*/
- (void)responseDict:(NSDictionary*)dict{

    NSString *res = [NSString stringWithFormat:@"%@",dict];
    [XHAFNRequest alert:res];
    NSLog(@"\n成功之后返回的数据:%@",dict);
    NSString *msg = [NSString stringWithFormat:@"%@",dict[@"statusCode"]];
    alertmsg(msg);

}

/** 失败返回的数据*/
- (void)failWithError:(NSError*)error{
    
    NSLog(@"failWithError:%@",[error localizedDescription]);

}

    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
}
@end
