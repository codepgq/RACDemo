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
    
   
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"input - %@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"6666666"];
            
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"还在执行");
        }else{
            NSLog(@"执行结束了");
        }
    }];
    
    [command execute:@"9999999"];
    
}

- (void)setp6{
    RACSubject *signalofsignal = [RACSubject subject];
    RACSubject *signal1 = [RACSubject subject];
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    RACSubject *signal4 = [RACSubject subject];
    
    
    [signalofsignal.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [signalofsignal sendNext:signal1];
    [signalofsignal sendNext:signal2];
    [signalofsignal sendNext:signal3];
    [signalofsignal sendNext:signal4];
    
    [signal1 sendNext:@"1"];
    [signal2 sendNext:@"2"];
    [signal3 sendNext:@"3"];
    [signal4 sendNext:@"4"];
}

- (void)setp5{
    RACSubject *signalofsignal = [RACSubject subject];
    RACSubject *signal1 = [RACSubject subject];
    RACSubject *signal2 = [RACSubject subject];
    RACSubject *signal3 = [RACSubject subject];
    RACSubject *signal4 = [RACSubject subject];
    
    
    [signalofsignal subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
    
    [signalofsignal sendNext:signal1];
    [signal1 sendNext:@"1"];
}

- (void)setp4{
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"大佬大佬放过我"];
            
            return nil;
        }];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据 - %@",x);
    }];
    
    [command execute:@"开始飞起来"];
}

- (void)setp3{
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"大佬大佬放过我"];
            
            return nil;
        }];
    }];
    
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"这里会是什么呢？ - %@",x);
        }];
        
        NSLog(@"接收数据 - %@",x);
    }];
    
    [command execute:@"开始飞起来"];
}

- (void)setp2{
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"大佬大佬放过我"];
            
            return nil;
        }];
    }];
    
    RACSignal * signal = [command execute:@"开始飞起来"];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据 - %@",x);
    }];
}

- (void)setp1{
    RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        
        return nil;
    }];
    
    [command execute:@"开始飞起来"];
}

@end
