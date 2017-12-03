//
//  SEAlertBoxView.m
//  SEUDApp
//
//  Created by Chengkai on 16/6/22.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEAlertBoxView.h"
#import "SEUDFont.h"
#import "Masonry.h"
#import "UIButton+Extends.h"
#import "UIView+ShowBorder.h"

@interface SEAlertBoxView ()

@property (nonatomic, strong) UIView *viewTitleBg;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *containerInScrollView;
@property (nonatomic, strong) UIImageView *imageViewClose;/**< 右上角关闭按钮 */


@end

@implementation SEAlertBoxView

#pragma mark -
#pragma mark Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isLeftBtnHidde = NO;
        [self setBackgroundColor:[UIColor colorWithHexString:@"#1a1b25" withAlpha:0.97f]];
        self.layer.borderWidth = 1.5f;
        self.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" withAlpha:0.4].CGColor;
        [self addViews];
    }
    return self;
}

#pragma mark -
#pragma mark 添加视图
-(void)addViews
{
    [self.viewTitleBg addSubview:self.imageViewClose];
    [self addSubview:self.viewTitleBg];
    [self addSubview:self.lblTitle];
    [self addSubview:self.btnLeft];
    [self addSubview:self.btnRight];
    [self addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.containerInScrollView];
    [self.containerInScrollView addSubview:self.textView];
    [self updateViewConstraints];
}

#pragma mark -
#pragma mark 约束适配
-(void)updateViewConstraints
{
    
    [_viewTitleBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@43.f);
    }];
    
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(_viewTitleBg.mas_centerY);
    }];
    
    [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-5.f);
        make.bottom.equalTo(self.mas_bottom).offset(-10.f);
        make.width.equalTo(self.mas_width).multipliedBy(0.4);
        make.height.mas_equalTo(39.f);
    }];
    
    [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(5.f);
        make.bottom.equalTo(self.mas_bottom).offset(-10.f);
        make.width.equalTo(self.mas_width).multipliedBy(0.4);
        make.height.mas_equalTo(39.f);
    }];
    
    [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_viewTitleBg.mas_bottom).offset(10.f);
        make.width.equalTo(self.mas_width).offset(-42.f);
        make.bottom.equalTo(_btnRight.mas_top).offset(-10.f);
    }];
    
    [_containerInScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentScrollView);
        make.width.equalTo(_contentScrollView);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerInScrollView.mas_left);
        make.right.equalTo(_containerInScrollView.mas_right);
        make.top.equalTo(_containerInScrollView.mas_top);
//        make.bottom.equalTo(_containerInScrollView.mas_bottom);
        make.height.equalTo(_contentScrollView.mas_height);
    }];
    
    [_containerInScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_textView.mas_bottom);
    }];
    
    [_imageViewClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewTitleBg.mas_right);
        make.bottom.equalTo(self.viewTitleBg.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(39.f, 39.f));
    }];
}

-(void)updateButtonLayout{
    if (_isLeftBtnHidde) {
        [_btnRight mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-10.f);
            make.width.equalTo(self.mas_width).multipliedBy(0.6);
        }];
    } else {
        [_btnLeft mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).offset(-5.f);
            make.bottom.equalTo(self.mas_bottom).offset(-10.f);
            make.width.equalTo(self.mas_width).multipliedBy(0.4);
        }];
        
        [_btnRight mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(5.f);
            make.bottom.equalTo(self.mas_bottom).offset(-10.f);
            make.width.equalTo(self.mas_width).multipliedBy(0.4);
        }];
    }
}

#pragma mark -
#pragma mark Private Method

-(void)closeAction:(id)sender{
    self.closeBlock();
}


#pragma mark -
#pragma mark Event Response




#pragma mark -
#pragma mark Getter & Setter

- (UIView *)viewTitleBg
{
    if (!_viewTitleBg) {
        _viewTitleBg = [[UIView alloc] init];
        _viewTitleBg.backgroundColor = [UIColor colorWithHexString:@"#171D24" withAlpha:1.f];
    }
    return _viewTitleBg;
}

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithHexString:@"#CECECE" withAlpha:1.f];
        label.font = SEUD_MediumFont_16;
        _lblTitle = label;
    }
    return _lblTitle;
}

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        [_contentScrollView setBackgroundColor:[UIColor clearColor]];
    }
    return _contentScrollView;
}

- (UIButton *)btnLeft
{
    if (!_btnLeft) {
        UIButton *button = [[UIButton alloc]init];
        button.titleLabel.font = SEUD_Font_16;
        [button setTitleColor:SEUD_Color_White_10 forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.layer.borderColor = [UIColor colorWithHexString:@"#FFFFFF" withAlpha:0.4].CGColor;
        button.layer.borderWidth = 0.6f;
//        [button makeDefaultCornerRadius];
        _btnLeft = button;
    }
    return _btnLeft;
}

- (UIButton *)btnRight
{
    if (!_btnRight) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitleColor:SEUD_Color_White_10 forState:UIControlStateNormal];
        button.titleLabel.font = SEUD_Font_16;
        button.backgroundColor = SEUD_Color_Button_Red_4;
//        [button makeDefaultCornerRadius];
        _btnRight = button;
    }
    return _btnRight;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.editable = NO;
        _textView.font = SEUD_Font_13;
        _textView.textColor = [UIColor colorWithHexString:@"#CECECE" withAlpha:1.f];
    }
    return _textView;
}

- (UIView *)containerInScrollView
{
    if (!_containerInScrollView) {
        _containerInScrollView = [[UIView alloc] init];
    }
    return _containerInScrollView;
}

-(void)setIsLeftBtnHidde:(BOOL)isLeftBtnHidde{
    _isLeftBtnHidde = isLeftBtnHidde;
    self.btnLeft.hidden = isLeftBtnHidde;
    [self updateButtonLayout];
}

- (UIImageView *)imageViewClose
{
    if (!_imageViewClose) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"close_icon"];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
        [imageView addGestureRecognizer:tap];
        _imageViewClose = imageView;
    }
    return _imageViewClose;
}

#pragma mark -
#pragma mark PublicMethod

-(void)setHtmlContent:(NSString *)htmlMessage{
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlMessage dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [self.textView setAttributedText:attributedString];
    
    [self.textView setNeedsUpdateConstraints];
    [self.textView updateConstraintsIfNeeded];
    [self.textView layoutIfNeeded];
    
}


@end
