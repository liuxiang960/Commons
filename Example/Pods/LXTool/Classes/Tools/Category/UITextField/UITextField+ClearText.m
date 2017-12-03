//
//  UITextField.m
//  UITextFieldClearCategory
//
//  Created by Chengkai on 16/6/24.
//  Copyright © 2016年 com.zkingsoft. All rights reserved.
//

#import "UITextField+ClearText.h"

@implementation UITextField (ClearText)

@dynamic clearCallback;
@dynamic btnClearText;

static char clearBlockKey;
static char btnClearTextKey;

-(void)addClearTextNormalImage:(NSString *)imgStr heilightedImg:(NSString *)hImgStr function:(UITextFieldClearBlock)callback{
    if (!self.btnClearText) {
        if (imgStr == nil) {
            imgStr = @"textField_clear";
            hImgStr = @"textField_clear_h";
        }
        [self addClearTextButtonNormalImage:imgStr heilightedImg:hImgStr];
    }
    self.clearCallback = callback;
}

-(void)addClearTextButtonNormalImage:(NSString *)imgStr heilightedImg:(NSString *)hImgStr{
    self.btnClearText = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnClearText setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    [self.btnClearText setImage:[UIImage imageNamed:hImgStr] forState:UIControlStateHighlighted];
    //    [self.btnClearText setFrame:CGRectMake(0,0, 20, 20)];
    [self.btnClearText setFrame:CGRectMake(0,0, 40, 40)];
    self.btnClearText.hidden = YES;
    [self.btnClearText addTarget:self action:@selector(clearTextField:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(clearTextCEndEditAction:) forControlEvents:(UIControlEventEditingDidEnd)];
    [self addTarget:self action:@selector(clearTextCStartEditAction:) forControlEvents:(UIControlEventEditingDidBegin)];
    self.rightViewMode = UITextFieldViewModeAlways;
    [self setRightView:self.btnClearText];
}

-(void)clearTextCEndEditAction:(id)sender{
    [self hiddeClearButton];
}

-(void)clearTextCStartEditAction:(id)sender{
    [self showClearButton];
}

-(void)clearTextField:(id)sender{
    self.text = @"";
    if (self.clearCallback) {
        self.clearCallback();
    }
}

-(void)showClearButton{
    self.btnClearText.hidden = NO;
}

-(void)hiddeClearButton{
    self.btnClearText.hidden = YES;
}

-(UITextFieldClearBlock)clearCallback{
    return objc_getAssociatedObject(self, &clearBlockKey);
}

- (void)setClearCallback:(UITextFieldClearBlock)clearCallback{
    objc_setAssociatedObject(self, &clearBlockKey, clearCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIButton *)btnClearText{
    return objc_getAssociatedObject(self, &btnClearTextKey);
}

- (void)setBtnClearText:(UIButton *)btnClearText{
    objc_setAssociatedObject(self, &btnClearTextKey, btnClearText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:) || action == @selector(copy:) || action == @selector(selectAll:)) {
        return YES;
    }else {
        return NO;
    }
}

@end
