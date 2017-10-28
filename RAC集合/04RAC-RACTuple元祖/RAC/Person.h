//
//  Person.h
//  RAC
//
//  Created by pgq on 2017/10/27.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL isMan;

+ (instancetype)personWithDict:(NSDictionary *)dict;

@end
