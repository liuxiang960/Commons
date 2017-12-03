//
//  UITextField+RightButton.m
//  MutilTaskDemo
//
//  Created by Meonardo on 16/2/26.
//  Copyright © 2016年 Meonardo. All rights reserved.
//

#import "UITextField+RightButton.h"
#import <objc/runtime.h>

static char rightButtonKey;

@implementation UITextField (RightButton)

- (UIButton *)createRightButton
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(showEyeOnTextField:) forControlEvents:UIControlEventTouchUpInside];
    /*
    rightButton.frame = CGRectMake(0, 0, 22, 22);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"login_pwd_hidden"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"login_pwd_show"] forState:UIControlStateSelected];
     */
    rightButton.frame = CGRectMake(0, 0,40, 40);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(16.5, 30, 16.5, 30);
    [rightButton setImage:[UIImage imageNamed:@"hiddePwd"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"showPwd"] forState:UIControlStateSelected];
    return rightButton;
}

- (void)showEyeOnTextField:(UIButton *)sender
{
    self.secureTextEntry = sender.isSelected;
    if(!self.font)
    self.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
    sender.selected = !sender.selected;
}

- (BOOL)showRightButton
{
    return [objc_getAssociatedObject(self, &rightButtonKey) boolValue];
}

- (void)setShowRightButton:(BOOL)showRightButton
{
    objc_setAssociatedObject(self, &rightButtonKey, @(showRightButton), OBJC_ASSOCIATION_ASSIGN);
    self.keyboardType = UIKeyboardTypeASCIICapable;
    self.keyboardAppearance = UIKeyboardAppearanceDark;
//    self.adjustsFontSizeToFitWidth = NO;
    if (self.showRightButton)
    {
        self.rightView = [self createRightButton];
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}

@end
