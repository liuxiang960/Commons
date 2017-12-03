//
//  ViewController.m
//  SEUDApp
//
//  Created by Chengkai on 16/6/13.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "BaseViewController+UserGuide.h"
typedef void(^didClick)(BOOL success,int code,NSString* desc,NSObject* data);
@implementation BaseViewController(UserGuide)


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"当前ViewController >> [ %@ ]",className);
    BOOL isNeedTestBtn = YES;
    if (isNeedTestBtn) {
        UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        testBtn.frame = CGRectMake(30, 200, 100, 40);
        [testBtn setTitle:@"测试按钮" forState:UIControlStateNormal];
        [testBtn addTarget:self action:@selector(globalBtnForTestAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView *parentView = [UIApplication sharedApplication].keyWindow;
        [parentView addSubview:testBtn];
    }
}

-(void)globalBtnForTestAction:(UIButton *)sender{
    [@"ss" isEqualToString:@"ss"];
//    ViewController *vc = [[ViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}




@end
