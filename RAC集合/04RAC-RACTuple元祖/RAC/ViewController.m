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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"Model.plist" ofType:nil];
    
    NSArray * array = [NSArray arrayWithContentsOfFile:filePath];
    
    //id  _Nullable value 这里的value就是NSDictionary 所以我们就改成NSDictionary
    NSArray * persons = [[array.rac_sequence map:^id _Nullable(NSDictionary* value) {
        return [Person personWithDict:value];
    }] array];
    
    NSLog(@"%@",persons);
    
}

- (void)dict4{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"Model.plist" ofType:nil];
    
    NSArray * array = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *mArray = [NSMutableArray array];
    
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        [mArray addObject:[Person personWithDict:x]];
    }];
}

- (void)dict3{
    NSDictionary * dict = @{@"大吉大利":@"今晚吃鸡",
                            @"666666":@"999999",
                            @"dddddd":@"aaaaaa"
                            };
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        RACTupleUnpack(NSString *key,id value) = x;
        NSLog(@"key - %@ value - %@",key,value);
    }];
}

- (void)dict2{
    NSDictionary * dict = @{@"大吉大利":@"今晚吃鸡",
                            @"666666":@"999999",
                            @"dddddd":@"aaaaaa"
                            };
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"key - %@ value - %@",x[0],x[1]);
    }];
}

- (void)dict1{
    NSDictionary * dict = @{@"大吉大利":@"今晚吃鸡",
                            @"666666":@"999999",
                            @"dddddd":@"aaaaaa"
                            };
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"%@",x);
    }];
}

- (void)array{
    
    
    NSArray * array = @[@"大吉大利",@"今晚吃鸡",@66666,@99999];
    
    //    RACSequence * sequence = array.rac_sequence;
    //
    //    RACSignal * signal = sequence.signal;
    //
    //    [signal subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@",x);
    //    }];
    
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
}

- (void)tuple{
    //    [RACTuple tupleWithObjects:@"大吉大利",@"今晚吃鸡",@66666,@99999, nil]
    //    [RACTuple tupleWithObjectsFromArray:@[@"大吉大利",@"今晚吃鸡",@66666,@99999]];
    //
    
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"大吉大利",@"今晚吃鸡",@66666,@99999] convertNullsToNils:YES];
    
    id value = tuple[0];
    id value2 = tuple.first;
    NSLog(@"%@ %@",value,value2);
}

@end
