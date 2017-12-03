//
//  UIView.m
//  SEUDApp
//
//  Created by Chengkai on 16/6/30.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "UIView+Extends.h"

@implementation CALayer(XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end

@implementation UIView (Extends)

@dynamic endEditCallback;

static char endEditBlockKey;

-(void)makeDefaultCornerRadius{
    self.layer.cornerRadius = 2.f;
    self.layer.masksToBounds=YES;
}

-(void)makeCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

-(void)makeBorder:(CGFloat)width color:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

-(void)seEndEditing{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUIViewEndEditingEvent_SEUD" object:nil userInfo:nil];
}

-(void)seResponseEndEditing:(ViewResponseEditBlock)callback{
    
    self.endEditCallback = callback;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEndEditinEvent) name:@"kUIViewEndEditingEvent_SEUD" object:nil];
}

-(void)seCancelResponseEndEditing{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kUIViewEndEditingEvent_SEUD" object:nil];
}

-(void)handleEndEditinEvent{
    if (self.endEditCallback) {
        self.endEditCallback();
    }
}

-(ViewResponseEditBlock)endEditCallback{
    return objc_getAssociatedObject(self, &endEditBlockKey);
}

- (void)setEndEditCallback:(ViewResponseEditBlock)endEditCallback{
    objc_setAssociatedObject(self, &endEditBlockKey, endEditCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
