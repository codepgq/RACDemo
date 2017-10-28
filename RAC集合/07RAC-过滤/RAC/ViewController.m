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

#import "Person.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    RACSubject * subject = [RACSubject subject];
    
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@[@1]];
    [subject sendNext:@[@1]];
    
    [subject sendNext:@{@"name":@"jack"}];
    [subject sendNext:@{@"name":@"jack"}];
    
    Person * p1 = [[Person alloc] init];
    p1.name = @"jj";
    p1.age = 20;
    
    Person * p2 = [[Person alloc] init];
    p2.name = @"jj";
    p2.age = 20;
    
    [subject sendNext:p1];
    [subject sendNext:p2];
    
}

- (void)takeUntil{
    RACSubject * subject = [RACSubject subject];
    RACSubject * subject1 = [RACSubject subject];
    
    [[subject takeUntil:subject1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject1 subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    
    [subject1 sendNext:@"Stop"];
    
    [subject sendNext:@"4"];
    [subject sendNext:@"5"];
}

- (void)takeLast{
    RACSubject * subject = [RACSubject subject];
    
    [[subject takeLast:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"4"];
    [subject sendNext:@"5"];
    
    [subject sendCompleted];
}

- (void)take{
    RACSubject * subject = [RACSubject subject];
    
    [[subject take:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"4"];
    [subject sendNext:@"5"];
}

- (void)ignores{
    RACSubject * subject = [RACSubject subject];
    
    [[[[[subject ignore:@"1"] ignore:@"2"] ignore:@"3"] ignore:@"4"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendNext:@"4"];
    [subject sendNext:@"5"];
}

- (void)ignoreValues{
    RACSubject * subject = [RACSubject subject];
    
    [[subject ignoreValues] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"a"];
    [subject sendNext:@"a1"];
    [subject sendNext:@"b"];
}

- (void)ignore{
    RACSubject * subject = [RACSubject subject];
    
    [[subject ignore:@"a"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    [subject sendNext:@"a"];
    [subject sendNext:@"a1"];
    [subject sendNext:@"b"];
}

- (void)fillter{
    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];

}

@end
