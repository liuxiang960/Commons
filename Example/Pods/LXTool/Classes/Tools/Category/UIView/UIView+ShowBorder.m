//
//  UIView.m
//  SEUDApp
//
//  Created by Chengkai on 16/6/16.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "UIView+ShowBorder.h"

@implementation UIView (ShowBorder)

-(void)showViewBorder{
    self.layer.borderColor = [self randomColor].CGColor;
    self.layer.borderWidth = 1.f;
}

-(void)showViewBorder:(UIColor *)borderColor width:(CGFloat)width{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = width;
}

-(void)showViewBorder:(UIColor *)borderColor width:(CGFloat)width roundCornerRadius:(CGFloat)radius{
    [self showViewBorder:borderColor width:width];
    self.layer.cornerRadius = radius;
}

- (UIColor*) randomColor{
    
    NSInteger r = arc4random() % 255;
    NSInteger g = arc4random() % 255;
    NSInteger b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    
}


@end
