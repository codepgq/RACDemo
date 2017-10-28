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
    
    RACSubject * subjectOfSignal = [RACSubject subject];
    
    RACSubject * subject1 = [RACSubject subject];
    
    [[subjectOfSignal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subjectOfSignal sendNext:subject1];
    
    [subject1 sendNext:@"弄啥嘞"];

    
}

- (void)doubleSubscribe{
    RACSubject * subjectOfSignal = [RACSubject subject];
    
    RACSubject * subject1 = [RACSubject subject];
    
    [subjectOfSignal subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
        }];
    }];
    
    
    [subjectOfSignal sendNext:subject1];
    
    [subject1 sendNext:@"弄啥嘞"];
}


- (void)map{
    RACSubject * subject = [RACSubject subject];
    
    [[subject map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%@ 你别问我，我也不知道！",value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"what happend？"];
    [subject sendNext:@"what happend？"];
    [subject sendNext:@"what happend？"];
    [subject sendNext:@"what happend？"];
}

- (void)flattenMap{
    RACSubject * subject = [RACSubject subject];
    
    [[subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        value = [NSString stringWithFormat:@"%@ 你别问我，我也不知道！",value];
        return [RACReturnSignal return:value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"what happend？"];
}

- (void)basic{
    RACSubject * subject = [RACSubject subject];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"what happend？"];
}

@end
