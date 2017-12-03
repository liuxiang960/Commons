//
//  UIView.h
//  SEUDApp
//
//  Created by Chengkai on 16/6/16.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShowBorder)

/**
 *  @author 程凯, 16-06-16 09:06:02
 *
 *  显示边框，边框颜色随机,用来做测试
 *
 *  @since
 */
-(void)showViewBorder;

/**
 *  @author 程凯, 16-06-16 09:06:54
 *
 *  显示边框
 *
 *  @param borderColor 边框颜色
 *  @param width       边框宽度
 *
 *  @since 1.0
 */
-(void)showViewBorder:(UIColor *)borderColor width:(CGFloat)width;

/**
 *  @author 程凯, 16-06-16 09:06:48
 *
 *  显示边框,同时设置圆角
 *
 *  @param borderColor 边框颜色
 *  @param width       边框宽度
 *  @param radius      圆角半径
 *
 *  @since 1.0
 */
-(void)showViewBorder:(UIColor *)borderColor width:(CGFloat)width roundCornerRadius:(CGFloat)radius;

@end
