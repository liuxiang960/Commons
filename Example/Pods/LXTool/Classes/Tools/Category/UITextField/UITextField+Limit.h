//
//  UITextField.h
//  LimitCharTextFiled
//
//  Created by Chengkai on 16/6/29.
//  Copyright © 2016年 com.zkingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^UITextFieldLimitCharsBlock)();


/**
 *  @author 程凯
 *
 *  该分类中的方法为互斥关系，不可同时使用
 *
 */
@interface UITextField (Limit)

@property (nonatomic, copy) UITextFieldLimitCharsBlock limitCallback;
@property (nonatomic, strong) NSNumber *charLimitNum;

/**
 *  @author 程凯, 16-06-29 23:06:41
 *
 *  限制最大输入字符数量，英文、字母、数字占一个字符，汉字占两个字符。
 *
 *  @param charNum  最大字符数量
 *  @param callback 当输入达到最大字符将字符串切割到限制范围内，然后回调
 *
 *  @since 1.0
 */
-(void)limitInputChars:(NSInteger)charNum callback:(UITextFieldLimitCharsBlock)callback;

/**
 *  @author 程凯, 16-06-29 23:06:52
 *
 *  限制输入字符串长度，单个中英文、字母、数字均按照长度为1计算
 *
 *  @param maxLength 最大长度
 *  @param callback  当输入达到最大字符将字符串切割到限制范围内，然后回调
 *
 *  @since 1.0
 */
-(void)limitInputLength:(NSInteger)maxLength callback:(UITextFieldLimitCharsBlock)callback;

/**
 *  @author 程凯, 16-06-29 23:06:05
 *
 *  只能输入数字,且整数最大长度为length，小数点后只能两位
 *
 *  @param length 最大长度
 *  @param callback  整数部分长度达到限制 或者 小数部分达到2位，然后回调
 *
 *  @since 1.0
 */
-(void)limitOnlyNumber:(NSInteger)length callback:(UITextFieldLimitCharsBlock)callback;

/**
 *  @author 程凯, 16-06-29 23:06:59
 *
 *  只能输入数字，整数部分长度为length，不不能带小数位
 *
 *  @param length 最大长度
 *  @param callback  输入达到最大长度时，回调
 *
 *  @since 1.0
 */
-(void)limitOnlyNumberWithoutDot:(NSInteger)length callback:(UITextFieldLimitCharsBlock)callback;

- (void)limitOnlyChineseAndCharWithLength:(NSInteger)length callback:(UITextFieldLimitCharsBlock)callback;
@end
