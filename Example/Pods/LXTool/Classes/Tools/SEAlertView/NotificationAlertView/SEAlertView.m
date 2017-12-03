//
//  SEAlertView.m
//  SEUDApp
//
//  Created by Chengkai on 16/6/22.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEAlertView.h"
#import "SEAlertBoxView.h"
#import "Masonry.h"

@interface SEAlertView ()

@property (nonatomic, strong) SEAlertBoxView *boxView;
@property (nonatomic, copy) SEAlertViewBlock cancelBlock;
@property (nonatomic, copy) SEAlertViewBlock sureBlock;

@end

@implementation SEAlertView

#pragma mark -
#pragma mark Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithHexString:@"#000000" withAlpha:0.3]];
        [self addViews];
        UIView *parentView = [UIApplication sharedApplication].keyWindow;
        [parentView addSubview:self];
    }
    return self;
}

#pragma mark -
#pragma mark 添加视图
-(void)addViews
{
    [self addSubview:self.boxView];
    [self updateViewConstraints];
}

#pragma mark -
#pragma mark 约束适配
-(void)updateViewConstraints
{
    
    [_boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(self.mas_width).offset(-60.f);
        make.height.equalTo(@300.f);
    }];
    
}


#pragma mark -
#pragma mark Private Method

-(void)showViewInKeyWindow{
    UIView *parentView = [UIApplication sharedApplication].keyWindow;
//    [parentView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(parentView);
    }];
    
    self.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.1f);
    self.layer.opacity = 0.0f;
    
    [UIView animateWithDuration:0.1f
                     animations:^{
                         self.layer.transform = CATransform3DIdentity;
                         self.layer.opacity = 1.0f;
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)dismissAlertView{
    
    self.layer.transform = CATransform3DIdentity;
    self.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.1f
                     animations:^{
                         self.layer.opacity = 0.0f;
                         self.layer.transform = CATransform3DMakeScale(1.1f, 1.1f, 1.1f);
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         
                     }];
}

#pragma mark -
#pragma mark Event Response

-(void)btnLeftAction:(id)sender{
    if (_cancelBlock) {
        _cancelBlock();
    } else {
        [self dismissAlertView];
    }
}

-(void)btnRightAction:(id)sender{
    if (_sureBlock) {
        _sureBlock();
    }
}


#pragma mark -
#pragma mark Getter & Setter

- (SEAlertBoxView *)boxView
{
    if (!_boxView) {
        _boxView = [[SEAlertBoxView alloc] init];
        _boxView.closeBlock = ^(){
            [self dismissAlertView];
        };
        [_boxView.btnLeft addTarget:self action:@selector(btnLeftAction:) forControlEvents:UIControlEventTouchUpInside];
        [_boxView.btnRight addTarget:self action:@selector(btnRightAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boxView;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _boxView.lblTitle.text = title;
}

-(void)setMessage:(NSString *)message{
    _message = message;
    _boxView.textView.text = message;
}

-(void)setLeftButtonTitle:(NSString *)leftButtonTitle{
    _leftButtonTitle = leftButtonTitle;
    [_boxView.btnLeft setTitle:leftButtonTitle forState:UIControlStateNormal];
}

-(void)setRightButtonTitle:(NSString *)rightButtonTitle{
    _rightButtonTitle = rightButtonTitle;
    [_boxView.btnRight setTitle:rightButtonTitle forState:UIControlStateNormal];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    _boxView.lblTitle.font = titleFont;
}

-(void)setMessageFont:(UIFont *)messageFont{
    _messageFont = messageFont;
    _boxView.textView.font = messageFont;
}

-(void)setIsLeftBtnHidden:(BOOL)isLeftBtnHidden{
    _isLeftBtnHidden = isLeftBtnHidden;
    self.boxView.isLeftBtnHidde = isLeftBtnHidden;
}

-(void)setHtmlMessage:(NSString *)htmlMessage{
    _htmlMessage = htmlMessage;
    [self.boxView setHtmlContent:htmlMessage];
}

-(void)setTextList:(NSArray *)textList{
    _textList = [[NSMutableArray alloc] initWithArray:textList];
    if ( _textList && _textList.count > 0 ){
        self.message = _textList[0];
        if ( _textList.count > 1 ){
            self.boxView.btnLeft.hidden = NO;
            self.boxView.btnRight.hidden = NO;
            [self setLeftButtonTitle:@"取消"];
            [self setRightButtonTitle:@"下一条"];
        }
        else{
            self.boxView.btnLeft.hidden = YES;
            self.boxView.btnRight.hidden = YES;
        }
        [self showAlertView:^{
            [self dismissAlertView];
        } sureAction:^{
            if ( _textList.count == 1 ){
                [self dismissAlertView];
            }
            else{
                [_textList removeObjectAtIndex:0];
                if ( _textList.count == 1 ){
                    [self setRightButtonTitle:@"关闭"];
                }
                self.message = _textList[0];
            }
        }];
    }
}


#pragma mark -
#pragma mark PublicMethod

-(void)showAlertView:(SEAlertViewBlock)sureAction{
    [self showViewInKeyWindow];
    _sureBlock = sureAction;
}

-(void)showAlertView:(SEAlertViewBlock)cancleAction sureAction:(SEAlertViewBlock)sureAction{
    [self showViewInKeyWindow];
    _cancelBlock = cancleAction;
    _sureBlock = sureAction;
}

@end
