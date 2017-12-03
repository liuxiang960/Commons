//
//  UITextField.m
//  LimitCharTextFiled
//
//  Created by Chengkai on 16/6/29.
//  Copyright © 2016年 com.zkingsoft. All rights reserved.
//

#import "UITextField+Limit.h"

@implementation UITextField (Limit)

@dynamic limitCallback;
@dynamic charLimitNum;

static char limitCharKey;
static char charLimitNumKey;

#pragma mark -
#pragma mark Life Cycle




#pragma mark -
#pragma mark Private Method

-(NSString *)substringToCharIndex:(NSString *)string length:(NSInteger)length{
    
    NSString *tmpString = @"";
    int startIndex = (int)string.length;
    for (int i = startIndex; i > 0; i--) {
        tmpString = [string substringToIndex:i];
        if ([self getInfoWithText:tmpString] <= length) {
            break;
        }
    }
    return tmpString;
}

/**
 * UITextRange 转换成 NSRange
 */
- (NSRange)textRangeToNSRange:(UITextRange *)selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

/**
 * 判断中英混合的的字符串长度及字符个数
 */
- (NSInteger)getInfoWithText:(NSString *)text
{
    int length = 0;
    char *p = (char *)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) length++;
        p++;
    }
    return length;
}


#pragma mark -
#pragma mark Event Response

-(void)limitTextFiledEditChanged:(id)sender{
    
    NSInteger limitLength = [self.charLimitNum integerValue];
    NSString *currentText = self.text;
    NSString *langModel = self.textInputMode.primaryLanguage;
    if ([langModel isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (currentText.length > limitLength) {
                self.text = [currentText substringToIndex:limitLength];
                if (self.limitCallback) self.limitCallback();
            }
        }
    } else {
        if (currentText.length > limitLength) {
            self.text = [currentText substringToIndex:limitLength];
            if (self.limitCallback) self.limitCallback();
        }
    }
}
- (void)limitOnlyChineseAndCharTextFiledEditChange:(id)sender {
    NSString *currentText = self.text;
    NSInteger limitLength = [self.charLimitNum integerValue];
    //过滤
    if (![SeudPublic isInputRuleAndBlank:currentText]) {
        self.text = [SeudPublic disable_emoji:currentText];
        return;
    }
    NSString *lang = [[self textInputMode] primaryLanguage]; // 获取当前键盘输入模式
    //简体中文输入,第三方输入法（搜狗）所有模式下都会显示“zh-Hans”
    if([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            if (currentText.length > limitLength) {
                self.text = [currentText substringToIndex:limitLength];
                if (self.limitCallback) self.limitCallback();
            }
        }
    } else{
        if (currentText.length > limitLength) {
            self.text = [currentText substringToIndex:limitLength];
            if (self.limitCallback) self.limitCallback();
        }
    }

}
-(void)limitCharsTextFiledEditChanged:(id)sender{
    
    NSString *currentText = self.text;
    NSString *langModel = self.textInputMode.primaryLanguage;
    NSInteger limitLength = [self.charLimitNum integerValue];
    NSInteger currentLength = [self getInfoWithText:currentText];
    if ([langModel isEqualToString:@"zh-Hans"]) { //简体中文输入,包括: 简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];//获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];//没有高亮选择的字，则对文字进行字数统计
        if (!position) {
            if (currentLength > limitLength) {
                self.text = [self substringToCharIndex:currentText length:limitLength];
                if (self.limitCallback) self.limitCallback();
            }
        }
    } else {// 中文输入法以外的直接对其统计限制
        if (currentLength > limitLength) {
            self.text = [self substringToCharIndex:currentText length:limitLength];
            if (self.limitCallback) self.limitCallback();
        }
    }
}

-(void)limitInputOnlyNumberEditChanged:(id)sender{
    
    NSInteger limitLength = [self.charLimitNum integerValue];
    NSString *temp = self.text;
    temp = [self stringGetNumberString:temp];
    self.text = temp;
    NSArray *array = [self.text componentsSeparatedByString:@"."];
    if (array.count > 2) {
        self.text = [self.text substringToIndex:self.text.length - 1];
        return;
    }
    
    NSString *integerValue = array[0];
    if (integerValue.length > limitLength) {
        self.text = [self.text substringToIndex:self.text.length - 1];
        if (self.limitCallback) self.limitCallback();
        return;
    }
    
    if (array.count > 1) {
        NSString *decimalValue = array[1];
        if (decimalValue.length > 2) {
            self.text = [self.text substringToIndex:self.text.length - 1];
            if (self.limitCallback) self.limitCallback();
            return;
        }
    }
}

-(void)limitInputOnlyNumberNoDotEditChanged:(id)sender{
    
    NSInteger limitLength = [self.charLimitNum integerValue];
    NSString *temp = self.text;
    temp = [self stringGetNumberString:temp];
    self.text = temp;
    NSArray *array = [self.text componentsSeparatedByString:@"."];
    if (array.count > 1) {
        self.text = [self.text substringToIndex:self.text.length - 1];
        return;
    }
    
    NSString *integerValue = array[0];
    if (integerValue.length > limitLength)
    {
        self.text = [self.text substringToIndex:self.text.length - 1];
        if (self.limitCallback) self.limitCallback();
        return;
    }
}

/**
 *  去掉非数字字符
 */
-(NSString *)stringGetNumberString:(NSString *)string{
    if (!self) return @"0";
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    return [[string componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
}

#pragma mark -
#pragma mark Getter & Setter

-(UITextFieldLimitCharsBlock)limitCallback{
    return objc_getAssociatedObject(self, &limitCharKey);
}

-(void)setLimitCallback:(UITextFieldLimitCharsBlock)limitCallback{
    objc_setAssociatedObject(self, &limitCharKey, limitCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)charLimitNum{
    return objc_getAssociatedObject(self, &charLimitNumKey);
}

-(void)setCharLimitNum:(NSNumber *)charLimitNum{
    objc_setAssociatedObject(self, &charLimitNumKey, charLimitNum, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark -
#pragma mark PublicMethod

-(void)limitInputChars:(NSInteger)charNum callback:(UITextFieldLimitCharsBlock)callback{
    
    self.charLimitNum = [NSNumber numberWithInteger:charNum];
    self.limitCallback = callback;
    [self addTarget:self action:@selector(limitCharsTextFiledEditChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)limitInputLength:(NSInteger)maxLength callback:(UITextFieldLimitCharsBlock)callback{
    
    self.charLimitNum = [NSNumber numberWithInteger:maxLength];
    self.limitCallback = callback;
    [self addTarget:self action:@selector(limitTextFiledEditChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)limitOnlyNumber:(NSInteger)length callback:(UITextFieldLimitCharsBlock)callback{
    
    self.charLimitNum = [NSNumber numberWithInteger:length];
    self.limitCallback = callback;
    [self addTarget:self action:@selector(limitInputOnlyNumberEditChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)limitOnlyNumberWithoutDot:(NSInteger)length callback:(UITextFieldLimitCharsBlock)callback{
    
    self.charLimitNum = [NSNumber numberWithInteger:length];
    self.limitCallback = callback;
    [self addTarget:self action:@selector(limitInputOnlyNumberNoDotEditChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)limitOnlyChineseAndCharWithLength:(NSInteger)length callback:(UITextFieldLimitCharsBlock)callback {
    self.charLimitNum = [NSNumber numberWithInteger:length];
    self.limitCallback = callback;
    [self addTarget:self action:@selector(limitOnlyChineseAndCharTextFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
}
@end
