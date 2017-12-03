//
//  SEAlertBoxTypeCView.m
//  SEUDApp
//
//  Created by Chengkai on 16/8/3.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "SEAlertBoxTypeCView.h"
#import "UIView+Extends.h"
#import "UILabel+Extends.h"
#import "BlocksKit+UIKit.h"
#import "NSString+LabelWidthAndHeight.h"
@interface SEAlertBoxTypeCView ()

@property (nonatomic, strong) UIImageView *imageViewClose;/**< 右上角关闭按钮 */
@property (nonatomic, strong) UIView *separateLine;/**< 顶部分割线 */
@property (nonatomic, strong) UIButton *btnCancel;/**< 取消按钮 */
@property (nonatomic, strong) UIButton *btnSure;/**< 确认按钮 */
@property (nonatomic, copy) SEAlertBoxBlock callbackBlock;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat textHeight;/**< 文本高度 */

@end

@implementation SEAlertBoxTypeCView

#pragma mark -
#pragma mark Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _isHiddenCancelBtn = NO;
        self.clipsToBounds = YES;
        [self setBackgroundColor:SEUD_Separate_Line_Gray];
        [self makeCornerRadius:2.f];
        [self addViews];
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
    [self addSubview:self.lblTitlePlus];
    [self addSubview:self.lblContentTitle];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.lblContentSubTitle];
    [self updateViewConstraints];
}

#pragma mark -
#pragma mark 约束适配
-(void)updateViewConstraints
{
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(280.f);
        //        make.height.mas_equalTo(236.f);
    }];
    
    [_separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(39.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@1.f);
    }];
    
    [_lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20.f);
        make.right.equalTo(_imageViewClose.mas_left).offset(-5.f);
        make.bottom.equalTo(_separateLine.mas_top).offset(-5.f);
    }];
    
    [_lblTitlePlus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lblTitle.mas_right);
        make.bottom.equalTo(_separateLine.mas_top).offset(-7.f);
    }];
    
    [_imageViewClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(_separateLine.mas_top);
        make.size.mas_equalTo(CGSizeMake(39.f, 39.f));
    }];
    
    [_lblContentTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_separateLine.mas_bottom).offset(20.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).offset(-40.f);
    }];
    
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).offset(-40.f);
        make.top.equalTo(_lblContentTitle.mas_bottom).offset(8.f);
        make.centerX.equalTo(self.mas_centerX);
        if (self.textHeight > 400) {
            make.height.equalTo(@400.f);
        } else {
            make.height.mas_equalTo(self.textHeight);
        }
    }];
    
    _scrollView.contentSize = CGSizeMake(240.f, self.textHeight);
    
    [_lblContentSubTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_top);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).offset(-40.f);
    }];
    
    if (_isHiddenCancelBtn) {
        [_btnSure mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(160.f, 39.f));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(_scrollView.mas_bottom).offset(30.f);
        }];
    } else {
        [_btnCancel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110.f, 39.f));
            make.right.equalTo(self.mas_centerX).offset(-5.f);
            make.top.equalTo(_scrollView.mas_bottom).offset(30.f);
        }];
        
        [_btnSure mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110.f, 39.f));
            make.left.equalTo(self.mas_centerX).offset(5.f);
            make.top.equalTo(_scrollView.mas_bottom).offset(30.f);
        }];
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_btnSure.mas_bottom).offset(15.f);
        make.height.mas_lessThanOrEqualTo(400.f);
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

- (UILabel *)lblTitlePlus
{
    if (!_lblTitlePlus) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = SEUD_Color_Light_Gray_12;
        label.font = SEUD_Font_12;
        _lblTitlePlus = label;
    }
    return _lblTitlePlus;
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

- (UILabel *)lblContentSubTitle
{
    if (!_lblContentSubTitle) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = SEUD_Color_Standard_Gray_11;
        label.font = SEUD_Font_14;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentLeft;
        [label bk_addObserverForKeyPath:@"text" options:NSKeyValueObservingOptionNew task:^(id  _Nonnull obj, NSDictionary * _Nonnull change) {
            
            NSString *text = change[@"new"];
            NSDictionary *fontInfo = @{NSFontAttributeName:SEUD_Font_14};
            self.textHeight = [text heightWithStringAttribute:fontInfo fixedWidth:240.f];
            [self updateViewConstraints];
        }];
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
        [button makeDefaultCornerRadius];
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
        [button makeDefaultCornerRadius];
        [button makeBorder:0.6f color:SEUD_Color_Standard_Gray_11];
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

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
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

-(void)setIsHiddenCloseBtn:(BOOL)isHiddenCloseBtn{
    _isHiddenCloseBtn = isHiddenCloseBtn;
    self.imageViewClose.hidden = isHiddenCloseBtn;
}

-(void)setTitleList:(NSMutableArray *)titleList{
    _titleList = [[NSMutableArray alloc] initWithArray:titleList];
}

-(void)setTextList:(NSArray *)textList{
    _textList = [[NSMutableArray alloc] initWithArray:textList];
    if ( _textList && _textList.count > 0 ){
        self.isHiddenCloseBtn = NO;
        self.lblContentSubTitle.text = _textList[0];
        self.lblTitle.text = _titleList[0];
        if ( _textList.count > 1 ){
            self.titleForBtnSure = @"下一条";
            self.isHiddenCancelBtn = NO;
            self.titleForBtnCancel = @"取消";
        }
        else{
            self.isHiddenCancelBtn = YES;
            self.titleForBtnSure = @"关闭";
        }
        [self show:^(SEAlertBoxButtonFlag flag) {
            if (flag == AlertBoxButtonSure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ( _textList.count == 1 ){
                        [self dismiss];
                    }
                    else{
                        [_textList removeObjectAtIndex:0];
                        [_titleList removeObjectAtIndex:0];
                        if ( _textList.count == 1 ){
                            self.titleForBtnSure = @"关闭";
                        }
                        self.lblContentSubTitle.text = _textList[0];
                        self.lblTitle.text = _titleList[0];
                    }
                });
            }
            else if ( flag == AlertBoxButtonCancel ){
                [self dismiss];
            }
        }];
    }
}

-(NSArray*)getTextList{
    return _textList;
}

#pragma mark -
#pragma mark PublicMethod

-(void)show:(SEAlertBoxBlock)callback{
    
    [super show:callback];
    _callbackBlock = callback;
}

@end
