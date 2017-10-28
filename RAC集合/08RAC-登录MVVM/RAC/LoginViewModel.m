//
//  LoginViewModel.m
//  RAC
//
//  Created by pgq on 2017/10/28.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "LoginViewModel.h"
#import "ReactiveObjC.h"


@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    //RACObserve可以把KVO转化为信号
    _btnEnableSignal =  [RACSignal combineLatest:@[RACObserve(self,account),RACObserve(self, password)] reduce:^id _Nullable(NSString * account,NSString * password){
        return @(account.length && (password.length > 5));
    }];
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"组合参数，准备发送登录请求 - %@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            NSLog(@"开始请求");
            
            NSLog(@"请求成功");
            
            NSLog(@"处理数据");
            
            [subscriber sendNext:@"请求完成，数据给你"];
            
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"结束了");
            }];
        }];
    }];
    

    
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行中……");
        }else{
            NSLog(@"执行结束了");
        }
    }];
}

@end
