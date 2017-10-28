//
//  ViewController.m
//  RAC
//
//  Created by pgq on 2017/10/24.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "ViewController.h"

#import "ReactiveObjC.h"

#import "RACReturnSignal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建信号
    RACSubject * subject = [RACSubject subject];
    
    //绑定信号
    RACSignal * signal = [subject bind:^RACSignalBindBlock _Nonnull{
        
        return ^RACSignal *(id _Nullable value, BOOL *stop){
            
            NSLog(@"x - %@",value);
            
            return [RACReturnSignal return:value];
        };
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到的数据 - %@",x);
    }];
    
    [subject sendNext:@"启动自毁程序"];
}

@end
