//
//  UIView.h
//  SEUDApp
//
//  Created by Chengkai on 16/9/1.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^SEUIViewEventBlock)();

@interface UIView (SEEvent)

@property (nonatomic, copy) SEUIViewEventBlock seEventCallback;

-(void)se_whenTapped:(SEUIViewEventBlock)callback;

@end
