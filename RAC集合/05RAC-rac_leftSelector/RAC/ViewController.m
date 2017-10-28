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
    
    RACSignal * signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"正在下载图片1");
        [NSThread sleepForTimeInterval:4];
        
        [subscriber sendNext:@"我是图片1"];
        
        return nil;
        
    }];
    
    RACSignal * signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"正在下载图片2");
        
        [subscriber sendNext:@"我是图片2"];
        
        return nil;
        
    }];
    
    RACSignal * signal3 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"正在下载图片3");
        
        [subscriber sendNext:@"我是图片3"];
        
        return nil;
        
    }];
    
    [self rac_liftSelector:@selector(updateUIPic:pic2:pic3:) withSignalsFromArray:@[signal1,signal2,signal3]];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)updateUIPic:(id)pic1 pic2:(id)pic2 pic3:(id)pic3{
    
    NSLog(@"我要加载了 : pic1 - %@ pic2 - %@ pic3 - %@",pic1,pic2,pic3);
    
}

@end
