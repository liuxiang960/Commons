//
//  UITextField.h
//  UITextFieldClearCategory
//
//  Created by Chengkai on 16/6/24.
//  Copyright © 2016年 com.zkingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^UITextFieldClearBlock)();

@interface UITextField (ClearText)

@property (nonatomic, copy) UITextFieldClearBlock clearCallback;
@property (nonatomic, strong) UIButton *btnClearText;/**< 删除当前textField的文本 */

/**
 *  @author 程凯, 16-06-24 17:06:17
 *
 *  给UITextField右侧添加清空按钮， PS: 清空按钮只在输入状态下才会显示,结束输入时会自动隐藏
 *
 *  @param imgStr 按钮正常状态图片
 *
 *  @param hImgStr 按钮高亮状态图片
 *
 *  @param callback 输入框文本清空之后回调
 *
 *  @since 1.0
 */
-(void)addClearTextNormalImage:(NSString *)imgStr heilightedImg:(NSString *)hImgStr function:(UITextFieldClearBlock)callback;
@end
