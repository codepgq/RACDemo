//
//  ViewController.m
//  RAC
//
//  Created by pgq on 2017/10/24.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "ViewController.h"


#import "ReactiveObjC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送网络请求");
        
        [subscriber sendNext:@"得到网络请求数据"];
        
        return nil;
    }];
    
    RACMulticastConnection *connect = [signal publish];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"1 - %@",x);
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"2 - %@",x);
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"3 - %@",x);
    }];
    
    [connect connect];
}


- (void)step1{
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送网络请求");
        
        [subscriber sendNext:@"得到网络请求数据"];
        
        return nil;
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"1 - %@",x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"2 - %@",x);
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"3 - %@",x);
    }];
}


@end
