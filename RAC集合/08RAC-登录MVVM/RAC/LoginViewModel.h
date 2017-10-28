//
//  LoginViewModel.h
//  RAC
//
//  Created by pgq on 2017/10/28.
//  Copyright © 2017年 pgq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal,RACCommand;
@interface LoginViewModel : NSObject

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) RACSignal *btnEnableSignal;

@property (nonatomic, strong) RACCommand *loginCommand;
@end
