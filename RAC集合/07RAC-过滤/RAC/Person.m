//
//  Person.m
//  RAC
//
//  Created by pgq on 2017/10/28.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description{
    return [NSString stringWithFormat:@"name - %@ age - %zd",_name,_age];
}

@end
