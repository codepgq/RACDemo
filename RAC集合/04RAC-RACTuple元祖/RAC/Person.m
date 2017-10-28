//
//  Person.m
//  RAC
//
//  Created by pgq on 2017/10/27.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithDict:(NSDictionary *)dict{
    Person * p = [[Person alloc] init];
    
    [p setValuesForKeysWithDictionary:dict];
    
    return p;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"name - %@ age - %zd sex - %@",_name,_age,_isMan?@"man":@"woman"];
}

@end
