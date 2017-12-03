//
//  UITextField.m
//  SEUDApp
//
//  Created by Chengkai on 16/7/5.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "UITextField+Extends.h"

@implementation UITextField (Extends)

-(void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = color;
    dict[NSFontAttributeName] = font;
    NSAttributedString *attribute = [[NSAttributedString alloc]
                                     initWithString:placeholder
                                     attributes:dict];
    [self setAttributedPlaceholder:attribute];
}

-(void)setPlaceholderWithDefaultColor:(NSString *)placeholder{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = SEUD_Color_Deep_Gray_13;
    dict[NSFontAttributeName] = SEUD_Font_13;
    NSAttributedString *attribute = [[NSAttributedString alloc]
                                     initWithString:placeholder
                                     attributes:dict];
    [self setAttributedPlaceholder:attribute];
}

-(void)deleteCharBeforeCursor{
    if (!self.text || [@"" isEqualToString:self.text]) return;
    
    UITextPosition* beginning = self.beginningOfDocument;/**< 输入框文本内容的起始位置 */
    UITextPosition *positionStart = self.selectedTextRange.start;/**< 光标选中内容的开始位置 */
    UITextPosition *positionEnd = self.selectedTextRange.end;/**< 光标选中内容的结束位置 */
    NSInteger startOffset = [self offsetFromPosition:beginning toPosition:positionStart];/**< 转换成整数，代表光标在字符串中的序号 */
    NSInteger endOffset = [self offsetFromPosition:beginning toPosition:positionEnd];
    NSRange selectTextRange = NSMakeRange(startOffset, endOffset - startOffset);/**< 选中的内容 */
    if (startOffset == 0 && selectTextRange.length == 0) {/**< 如果当前光标在起始位置，且没有选中内容，那么无需做删除字符的操作 */
        return;
    }
    
    NSInteger location = [self offsetFromPosition:beginning toPosition:positionStart];/**< 光标的位置 */
    NSString *currentText = self.text;
    if (selectTextRange.length > 0) {/**< 如果有选中的内容，那么删除选中的内容 */
        self.text = [currentText stringByReplacingCharactersInRange:selectTextRange withString:@""];
    } else {
        NSRange range = NSMakeRange(location - 1, 1);
        self.text = [currentText stringByReplacingCharactersInRange:range withString:@""];/**< 删除光标前一位 */
    }
    /**< 第二步,把光标往前移动一位 */
    UITextPosition *newPos = [self positionFromPosition:self.beginningOfDocument offset:(location - 1)];
    self.selectedTextRange = [self textRangeFromPosition:newPos toPosition:newPos];
}

-(void)appendCharAtCursor:(NSString *)append{
    [self appendCharAtCursor:append maxLength:100000 callback:nil];
}

-(void)appendCharAtCursor:(NSString *)append maxLength:(NSInteger)length{
    [self appendCharAtCursor:append maxLength:length callback:nil];
}

-(void)appendCharAtCursor:(NSString *)append maxLength:(NSInteger)length callback:(SEUITextFieldBlock)callback{
    if (!self.text || !self.editing) return;
    
    UITextPosition* beginning = self.beginningOfDocument;/**< 输入框文本内容的起始位置 */
    UITextPosition *positionStart = self.selectedTextRange.start;/**< 光标选中内容的开始位置 */
    NSInteger location = [self offsetFromPosition:beginning toPosition:positionStart];/**< 光标的位置 */
    NSString *currentText = self.text;
    NSRange rangeLeft = NSMakeRange(0, location);
    NSRange rangeRight = NSMakeRange(location, currentText.length - location);
    NSString *leftString = [currentText substringWithRange:rangeLeft];
    NSString *rightString = [currentText substringWithRange:rangeRight];
    
    NSString *result = [NSString stringWithFormat:@"%@%@%@",leftString,append,rightString];
    if (result.length > length) {
        if (callback) callback(currentText);
    } else {
        self.text = result;
        /**< 第二步,把光标往后移动一位 */
        UITextPosition *newPos = [self positionFromPosition:self.beginningOfDocument offset:(location + 1)];
        self.selectedTextRange = [self textRangeFromPosition:newPos toPosition:newPos];
        if (result.length == length) {
            if (callback) callback(result);
        }
    }
}

@end
