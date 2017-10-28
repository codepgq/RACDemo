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

#import "LoginViewModel.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *accountTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) LoginViewModel *loginVM;

@end

@implementation ViewController

- (LoginViewModel *)loginVM{
    if (!_loginVM){
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.loginVM,account) = _accountTF.rac_textSignal;
    RAC(self.loginVM,password) = _passwordTF.rac_textSignal;
    
    RAC(_loginBtn,enabled) = self.loginVM.btnEnableSignal;
    
    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面");
    }];
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了  点击了");
        [self.loginVM.loginCommand execute:@{@"account":_accountTF.text,@"password":_passwordTF.text}];
    }];
}

- (void)xxxx{
    ///监听文本框输入状态，确定按钮是否可以点击
    RAC(_loginBtn,enabled) = [RACSignal combineLatest:@[_accountTF.rac_textSignal,_passwordTF.rac_textSignal] reduce:^id _Nullable(NSString * account,NSString * password){
        return @(account.length && (password.length > 5));
    }];
    
    
    RACCommand * btnPressCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
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
    
    [btnPressCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面");
    }];
    
    [[btnPressCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行中……");
        }else{
            NSLog(@"执行结束了");
        }
    }];
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了  点击了");
        
        [btnPressCommand execute:@{@"account":_accountTF.text,@"password":_passwordTF.text}];
        
    }];
}

@end
