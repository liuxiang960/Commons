//
//  UIView.m
//  SEUDApp
//
//  Created by Chengkai on 16/9/1.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "UIView+SEEvent.h"

@implementation UIView (SEEvent)

@dynamic seEventCallback;
static char seEventBlockKey;

-(void)se_whenTapped:(SEUIViewEventBlock)callback{
    self.seEventCallback = callback;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
    [self addGestureRecognizer:tap];
}

-(void)viewTapAction:(id)sender{
    if (self.seEventCallback) {
        self.seEventCallback();
    }
}

-(SEUIViewEventBlock)seEventCallback{
    return objc_getAssociatedObject(self, &seEventBlockKey);
}

- (void)setSeEventCallback:(SEUIViewEventBlock)seEventCallback{
    objc_setAssociatedObject(self, &seEventBlockKey, seEventCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
