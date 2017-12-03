//
//  UITextField.h
//  SEUDApp
//
//  Created by Chengkai on 16/7/5.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SEUITextFieldBlock)(NSString *text);

@interface UITextField (Extends)

-(void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font;

-(void)setPlaceholderWithDefaultColor:(NSString *)placeholder;

/**
 *  @author 程凯, 16-07-22 15:07:53
 *
 *  删除光标前的一个字符
 *
 *  @since 1.0
 */
-(void)deleteCharBeforeCursor;

/**
 *  @author 程凯, 16-09-08 10:09:52
 *
 *  在光标的位置追加输入的字符串
 *
 *  @param append 待追加的字符串
 *
 *  @since 1.0
 */
-(void)appendCharAtCursor:(NSString *)append;

/**
 *  @author 程凯, 16-09-08 10:09:21
 *
 *  在光标的位置追加输入的字符串，超出最大长度时追加会被忽略
 *
 *  @param append 待追加字符串
 *  @param length 允许的最大长度
 *
 *  @since 1.0
 */
-(void)appendCharAtCursor:(NSString *)append maxLength:(NSInteger)length;

/**
 *  @author 程凯, 16-09-08 10:09:10
 *
 *  在光标的位置追加输入的字符串
 *
 *  @param append   待追加字符串
 *  @param length   允许的最大长度
 *  @param callback 当输入框文本大于/等于最大长度时回调，超出最大长度时追加被忽略
 *
 *  @since 1.0
 */
-(void)appendCharAtCursor:(NSString *)append maxLength:(NSInteger)length callback:(SEUITextFieldBlock)callback;

@end
