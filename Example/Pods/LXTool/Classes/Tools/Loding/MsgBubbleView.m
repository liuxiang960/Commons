//
//  MsgBubbleView.m
//  SEUDApp
//
//  Created by Chengkai on 16/6/22.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "MsgBubbleView.h"
#import "Masonry.h"
#import "SEUDFont.h"
#import "NSString+Extend.h"
#import "UIViewController+CurrentViewController.h"

@interface MsgBubbleView ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *lblText;
@property (nonatomic, copy)   NSString *messageTypeCode;
@property (nonatomic,copy)    NSString *msg;
@end

@implementation MsgBubbleView

-(NSDictionary*)schema{
    return @{};
}

-(void)render{
//    if ( [self diff:@"messageTypeCode"] ){
//        _messageTypeCode=[self.state objectForKey:@"messageTypeCode"];
//    }
//
//    if ( [self diff:@"msg"] ) {
//        self.msg=[self.state objectForKey:@"msg"];
//        [self showBubble:_msg callback:^{
//
//        }];
//    }
//    [super render];
}

#pragma mark -
#pragma mark Life Cycle

+ (instancetype)sharedInstance
{
    static MsgBubbleView *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[MsgBubbleView alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isShowing = NO;
        [self setBackgroundColor:[UIColor clearColor]];
        [self addShadow];
        [self addViews];
    }
    return self;
}

#pragma mark -
#pragma mark 添加视图
-(void)addViews
{
    [self addSubview:self.bgImageView];
    [self addSubview:self.lblText];
    [self updateViewConstraints];
}

#pragma mark -
#pragma mark 约束适配
-(void)updateViewConstraints
{
    UIView *parentView = [UIApplication sharedApplication].keyWindow;
    [parentView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(parentView.mas_right).offset(-2.f);
        make.bottom.equalTo(parentView.mas_bottom).offset(-60.f);
    }];
    
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
    
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 80.f;
    _lblText.preferredMaxLayoutWidth = maxWidth;
    [_lblText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5.f);
        make.bottom.equalTo(self.mas_bottom).offset(-5.f);
        make.left.equalTo(self.mas_left).offset(15.f);
        make.right.equalTo(self.mas_right).offset(-20.f);
    }];
    
    
}


#pragma mark -
#pragma mark Private Method

-(void)addShadow{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,2);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 2;
}


#pragma mark -
#pragma mark Event Response




#pragma mark -
#pragma mark Getter & Setter

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        UIEdgeInsets insets = UIEdgeInsetsMake(15, 60, 18, 60);
        UIImage *image = [UIImage imageNamed:@"bubble_bg"];
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
        imageView.image = image;
        _bgImageView = imageView;
    }
    return _bgImageView;
}

- (UILabel *)lblText
{
    if (!_lblText) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.textColor = [UIColor blackColor];
        label.font = SEUD_Font_12;
        _lblText = label;
    }
    return _lblText;
}


#pragma mark -
#pragma mark PublicMethod

-(void)showBubble:(NSString *)msg callback:(MsgBubbleCallbackBlock)callback{
    
    _isShowing = YES;
    self.alpha = 1.f;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[msg dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSFontAttributeName:SEUD_Font_14} documentAttributes:nil error:nil];
    [self.lblText setAttributedText:attributedString];
    CGSize tmpSize = [msg sizeWithFont:SEUD_Font_12 constrainedToSize:CGSizeMake(ScreenWidth, 0) lineBreakMode:NSLineBreakByCharWrapping];
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 80.f;
    CGFloat width = tmpSize.width > maxWidth ? maxWidth:tmpSize.width;
    [self.lblText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    
    [UIView animateWithDuration:0.2f delay:4.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        _isShowing = NO;
        if (callback) {
            callback();
        }
    }];
}




@end
