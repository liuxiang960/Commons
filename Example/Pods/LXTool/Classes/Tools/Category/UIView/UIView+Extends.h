//
//  UIView.h
//  SEUDApp
//
//  Created by Chengkai on 16/6/30.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALayer(XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;

@end

typedef void (^ViewResponseEditBlock)();

@interface UIView (Extends)

@property (nonatomic, copy) ViewResponseEditBlock endEditCallback;

/**
 *  @author 程凯, 16-07-27 17:07:43
 *
 *  设置view的圆角为2px
 *
 *  @since 1.0
 */
-(void)makeDefaultCornerRadius;

/**
 *  @author 程凯, 16-07-27 17:07:23
 *
 *  设置view的圆角
 *
 *  @param cornerRadius 圆角半径
 *
 *  @since 1.0
 */
-(void)makeCornerRadius:(CGFloat)cornerRadius;

/**
 *  @author 程凯, 16-07-27 17:07:06
 *
 *  设置边框
 *
 *  @param width 边框宽度
 *  @param color 边框颜色
 *
 *  @since 1.0
 */
-(void)makeBorder:(CGFloat)width color:(UIColor *)color;

/**
 *  @author 程凯, 16-08-19 16:08:18
 *
 *  响应自定义的『结束编辑状态』事件,调用这个方法后，必须调用cancelResponseEndEditing。成对调用。
 *
 *  @param callback 接收到结束编辑的通知后，并不自己处理，而是交由各个view自己处理
 *
 *  @since 1.0
 */
-(void)seResponseEndEditing:(ViewResponseEditBlock)callback;

/**
 *  @author 程凯, 16-08-19 17:08:00
 *
 *  结束响应『结束编辑状态』事件
 *
 *  @since 1.0
 */
-(void)seCancelResponseEndEditing;

/**
 *  @author 程凯, 16-08-19 17:08:18
 *
 *  结束编辑状态
 *
 *  @since 1.0
 */
-(void)seEndEditing;

@end
