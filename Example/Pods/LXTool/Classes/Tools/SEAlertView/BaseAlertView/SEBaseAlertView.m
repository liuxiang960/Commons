//
//  SEAlertBox.m
//  SEUDApp
//
//  Created by Chengkai on 16/7/27.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEBaseAlertView.h"

@implementation SEBaseAlertView

#pragma mark -
#pragma mark Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isBgViewTapEnable = NO;
        _isAnimation = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Private Method



#pragma mark -
#pragma mark Event Response

-(void)bgTapAction:(id)sender{
    if (_isBgViewTapEnable) {
        [self dismiss];
    }
}

#pragma mark -
#pragma mark Getter & Setter

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithHexString:@"#000000" withAlpha:0.6f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapAction:)];
        [_bgView addGestureRecognizer:tap];
        _bgView.hidden = YES;
        _bgView.tag = 9134;
    }
    return _bgView;
}

#pragma mark -
#pragma mark PublicMethod

-(void)show:(SEAlertBoxBlock)callback{
    
    self.bgView.hidden = NO;
    UIView *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    
    UIView *parentView = self.bgView;
    [parentView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(parentView.mas_centerX);
        make.centerY.equalTo(parentView.mas_centerY);
    }];
    
    if (_isAnimation) {
        self.bgView.alpha = 0.5f;
        self.bgView.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.1f);
        self.bgView.layer.opacity = 0.0f;
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.bgView.alpha = 1.f;
                             self.bgView.layer.transform = CATransform3DIdentity;
                             self.bgView.layer.opacity = 1.0f;
                         } completion:^(BOOL finished) {
                             
                         }];
    }
}

-(void)dismiss{
    
    if (_isAnimation) {
        self.bgView.alpha = 1.f;
        self.bgView.layer.transform = CATransform3DIdentity;
        self.bgView.layer.opacity = 1.0f;
        [UIView animateWithDuration:0.1f
                         animations:^{
                             self.bgView.alpha = 0.5f;
                             self.bgView.layer.opacity = 0.0f;
                             self.bgView.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.1f);
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                             [self.bgView removeFromSuperview];
                         }];
    } else {
        [self removeFromSuperview];
        [self.bgView removeFromSuperview];
    }
    
}

@end
