//
//  SEAlertBoxTypeDView.m
//  SEUDApp
//
//  Created by Chengkai on 16/8/19.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEAlertBoxTypeDView.h"

@interface SEAlertBoxTypeDView ()

@property (nonatomic, strong) UIImageView *imageViewClose;/**< 右上角关闭按钮 */
@property (nonatomic, strong) UIView *separateLine;/**< 顶部分割线 */
@property (nonatomic, strong) UIButton *btnCancel;/**< 取消按钮 */
@property (nonatomic, strong) UIButton *btnSure;/**< 确认按钮 */
@property (nonatomic, copy) SEAlertBoxBlock callbackBlock;

@end

@implementation SEAlertBoxTypeDView

#pragma mark -
#pragma mark Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.clipsToBounds = YES;
        _isHiddenCancelBtn = NO;
        [self setBackgroundColor:SEUD_Separate_Line_Gray];
//        [self makeCornerRadius:2.f];
        [self addViews];
        //        [self setModel];
    }
    return self;
}

#pragma mark -
#pragma mark 添加视图
-(void)addViews
{
    [self addSubview:self.imageViewClose];
    [self addSubview:self.separateLine];
    [self addSubview:self.btnCancel];
    [self addSubview:self.btnSure];
    [self addSubview:self.lblTitle];
    [self addSubview:self.lblContentTitle];
    [self addSubview:self.lblContentTitle2];
    [self addSubview:self.lblContentSubTitle];
    [self updateViewConstraints];
}

#pragma mark -
#pragma mark 约束适配
-(void)updateViewConstraints
{
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(280.f);
    }];
    
    [_separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(39.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@1.f);
    }];
    
    [_lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20.f);
        make.bottom.equalTo(_separateLine.mas_top).offset(-5.f);
    }];
    
    [_imageViewClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(_separateLine.mas_top);
        make.size.mas_equalTo(CGSizeMake(39.f, 39.f));
    }];
    
    [_lblContentTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_separateLine.mas_bottom).offset(51.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).offset(-20.f);
    }];
    
    [_lblContentTitle2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblContentTitle.mas_bottom).offset(8.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).offset(-60.f);
    }];
    
    [_lblContentSubTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblContentTitle2.mas_bottom).offset(8.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).offset(-20.f);
    }];
    
    if (_isHiddenCancelBtn) {
        [_btnSure mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(160.f, 39.f));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(_lblContentSubTitle.mas_bottom).offset(30.f);
        }];
    } else {
        [_btnCancel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110.f, 39.f));
            make.right.equalTo(self.mas_centerX).offset(-5.f);
            make.top.equalTo(_lblContentSubTitle.mas_bottom).offset(30.f);
        }];
        
        [_btnSure mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110.f, 39.f));
            make.left.equalTo(self.mas_centerX).offset(5.f);
            make.top.equalTo(_lblContentSubTitle.mas_bottom).offset(30.f);
        }];
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_btnSure.mas_bottom).offset(15.f);
    }];
    
}

#pragma mark -
#pragma mark Private Method

-(void)setModel{
    self.lblTitle.text = @"清理缓存";
    self.lblContentTitle.text = @"确定清除中证数登本地的缓存数据?";
    self.lblContentSubTitle.text = @"(包括最新浏览、搜索记录，账户登录信息)";
}


#pragma mark -
#pragma mark Event Response

-(void)btnSureAction:(id)sender{
    if (_callbackBlock) _callbackBlock(AlertBoxButtonSure);
}

-(void)btnCancelAction:(id)sender{
    if (_callbackBlock) _callbackBlock(AlertBoxButtonCancel);
}

-(void)closeAction:(id)sender{
    if (_callbackBlock) _callbackBlock(AlertBoxButtonClose);
}

#pragma mark -
#pragma mark Getter & Setter

- (UILabel *)lblTitle
{
    if (!_lblTitle) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = SEUD_Color_White_10;
        label.font = SEUD_Font_16;
        _lblTitle = label;
    }
    return _lblTitle;
}

- (UILabel *)lblContentTitle
{
    if (!_lblContentTitle) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = SEUD_Color_White_10;
        label.font = SEUD_Font_15;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentCenter;
        _lblContentTitle = label;
    }
    return _lblContentTitle;
}

- (UILabel *)lblContentTitle2
{
    if (!_lblContentTitle2) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = SEUD_Color_White_10;
        label.font = SEUD_Font_13;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentLeft;
        _lblContentTitle2 = label;
    }
    return _lblContentTitle2;
}


- (UILabel *)lblContentSubTitle
{
    if (!_lblContentSubTitle) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = SEUD_Color_Light_Gray_12;
        label.font = SEUD_Font_12;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentCenter;
        _lblContentSubTitle = label;
    }
    return _lblContentSubTitle;
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

- (UIButton *)btnSure
{
    if (!_btnSure) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"确认" forState:UIControlStateNormal];
        [button setTitleColor:SEUD_Color_White_10 forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnSureAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = SEUD_Font_16;
        [button setBackgroundColor:SEUD_Color_Button_Red_4];
//        [button makeDefaultCornerRadius];
        _btnSure = button;
    }
    return _btnSure;
}

- (UIButton *)btnCancel
{
    if (!_btnCancel) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitleColor:SEUD_Color_White_10 forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnCancelAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = SEUD_Font_16;
//        [button makeDefaultCornerRadius];
//        [button makeBorder:0.6f color:SEUD_Color_Standard_Gray_11];
        _btnCancel = button;
    }
    return _btnCancel;
}

- (UIView *)separateLine
{
    if (!_separateLine) {
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColor = SEUD_Color_Tab_gray_8;
    }
    return _separateLine;
}

-(void)setTitleForBtnSure:(NSString *)titleForBtnSure{
    _titleForBtnSure = titleForBtnSure;
    [self.btnSure setTitle:titleForBtnSure forState:UIControlStateNormal];
}

-(void)setTitleForBtnCancel:(NSString *)titleForBtnCancel{
    _titleForBtnCancel = titleForBtnCancel;
    [self.btnCancel setTitle:titleForBtnCancel forState:UIControlStateNormal];
}

-(void)setIsHiddenCancelBtn:(BOOL)isHiddenCancelBtn{
    _isHiddenCancelBtn = isHiddenCancelBtn;
    self.btnCancel.hidden = isHiddenCancelBtn;
    [self updateViewConstraints];
}

#pragma mark -
#pragma mark PublicMethod

-(void)show:(SEAlertBoxBlock)callback{
    
    [super show:callback];
    _callbackBlock = callback;
}

@end
