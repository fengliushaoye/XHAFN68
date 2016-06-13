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

@property (weak, nonatomic) IBOutlet UITableView *mainTab;
/** 数据源*/
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mainTab.tableFooterView = [[UIView alloc] init];
    
    
}

#pragma mark - 发起请求

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //服务接入
//    [self post:_name.text pwd:_pwd.text];
    
//    注册
//    [self registerRquest];
    

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


#pragma mark - 服务接入

- (void)post:(NSString*)name pwd:(NSString*)pwd{



    //服务接入
    NSString *password    = pwd.length>0 ? pwd: RAP_userPwd;
    password = [XHAFNRequest md5Create:password];
    NSString *deviceid    = [XHAFNRequest uuidStr];//
    NSString *requestTime = [XHAFNRequest timeFormatter];
    NSString *username    = name.length>0 ? name: RAP_userName;
    NSString *secretKey   = RAP_userSecretKey;
    NSString *authSign    = [NSString stringWithFormat:@"%@%@%@%@",secretKey,username,password,requestTime];/** secretKey+username+password+requestTime*/

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
    NSLog(@"\n成功之后返回的数据:%@",dict);
    //服务接入
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        NSString *res = [NSString stringWithFormat:@"%@",dict];
        [XHAFNRequest alert:res];
        NSString *msg = [NSString stringWithFormat:@"%@",dict[@"statusCode"]];
        alertmsg([XHAFNRequest getbackCode:msg]);
    }else{
    
            NSData *data  = (NSData*)dict;
            NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"msg:%@",msg);
            alertmsg(msg);
    }

    
}


/** 失败返回的数据*/
- (void)failWithError:(NSError*)error{
    
    NSLog(@"failWithError:%@",[error localizedDescription]);
    
}


#pragma mark - 登录名校验

- (void)registerRquest{
    
    NSDictionary *param= @{
                           @"account":@"123456",
                           @"uscInfo":@{@"member":RAP_member,@"tenant":RAP_tenant},
                           };
    
    /** 发送HTTP数据请求*/
    WCC(weakSelf);
    [XHAFNRequest postUrl:URL_checkloginname postDict:param successWithBlock:^(NSURLSessionDataTask *task, id responseObject) {
        
        [weakself registerResponseDict:responseObject];
        
    } failWithBlock:^(NSURLSessionDataTask *task, NSError *responseObject) {
        
        [weakself registerFailWithError:responseObject];
        
    } iditify:nil];
    
    
}

/** 成功之后返回的数据*/
- (void)registerResponseDict:(id)dict{
    
    NSLog(@"responseDict:%@",dict);
    NSData *data  = (NSData*)dict;
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"msg:%@",msg);

    alertmsg(msg);
    
    
}

/** 失败返回的数据*/
- (void)registerFailWithError:(NSError*)error{
    
    NSLog(@"responseDict:%@",[error localizedDescription]);
    

}


#pragma mark - 其他

    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didSelectRowAtIndexPath");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        //服务接入
            [self post:_name.text pwd:_pwd.text];
    }else{
    
        //其他请求
        
    }
    
}

/** 本页数据源 懒加载*/
- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] initWithObjects:@"服务接入",@"注册", nil];
        
        
    }
    return _dataArr;
    
}

@end
