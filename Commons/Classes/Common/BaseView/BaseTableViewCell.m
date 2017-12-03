//
//  DemonTableViewCell.m
//  HouseCommunity
//
//  Created by 程凯 on 15/11/5.
//  Copyright © 2015年 程凯. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewExt.h"
#import "Masonry.h"

@interface BaseTableViewCell()
{
    BOOL bottomLineIsDraw;
    CGFloat bottomDrawOriginX;
    UIColor *bottomLineColor;
    UIColor *bottomtempLineColor;/**<临时存储颜色*/
    UIEdgeInsets bottomLineInsets;
    UIColor *leftColor;
    UIColor *rightColor;
    UIColor *TopLineColor;
    
    BOOL isDrawTopLine;
    CGFloat topDrawOriginX;
    UIColor *topLineColor;
    UIEdgeInsets topLineInsets;
}

@end

@implementation BaseTableViewCell
@synthesize rightIndicator = _rightIndicator;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        self.alpha = 1.0;
        self.separatorLineHeight = 1.f;
        [self.contentView addSubview:self.rightIndicator];
        [self initLineProperty];
        [self drawTopLine:[UIColor clearColor]];
        [self drawLeftLine:[UIColor clearColor]];
        [self drawRightLine:[UIColor clearColor]];
        [self makeConstraits];
    }
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = YES;
    self.alpha = 1.0;
    self.separatorLineHeight = 1.f;
    [self.contentView addSubview:self.rightIndicator];
    [self initLineProperty];
    [self makeConstraits];
    [self drawTopLine:[UIColor clearColor]];
    [self drawLeftLine:[UIColor clearColor]];
    [self drawRightLine:[UIColor clearColor]];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self drawBottomLine];
    [self drawLeftLine];
    [self drawRightLine];
    [self drawTopLine];
}

- (void)makeConstraits
{
    [super updateConstraints];
    
    [self.rightIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.height.equalTo(@13);
        make.width.equalTo(@7);
        make.centerY.equalTo(self);
    }];
}

#pragma mark -
#pragma mark Private Method

- (void)initLineProperty
{
    bottomLineColor = [UIColor grayColor];
    bottomLineIsDraw = NO;
    bottomDrawOriginX = 10;
    
    isDrawTopLine = NO;
    topLineColor = [UIColor grayColor];
    topDrawOriginX = 0;
}

- (void)setDemonSeparatorStyle:(DemonTableViewCellSeparatorStyle)separatorStyle
{
    switch (separatorStyle)
    {
        case DemonTableViewCellSeparatorFull:
        {
            bottomDrawOriginX = 0;
        }
            break;
            
        case DemonTableViewCellSeparatorSystem:
        {
            bottomLineInsets = self.separatorInset;
        }
            break;
        case DemonTableViewCellSeparatorLeft:
        {
            bottomDrawOriginX = 10;
        }
            break;
    }
    [self setNeedsDisplay];
}


- (void)setTopLineStyle:(DemonTableViewCellSeparatorStyle)separatorStyle
{
    isDrawTopLine = YES;
    switch (separatorStyle)
    {
        case DemonTableViewCellSeparatorFull:
        {
            topDrawOriginX = 0;
        }
            break;
            
        case DemonTableViewCellSeparatorSystem:
        {
            topLineInsets = self.separatorInset;
        }
            break;
        case DemonTableViewCellSeparatorLeft:
        {
            topDrawOriginX = 10;
        }
            break;
    }
     [self setNeedsDisplay];
}

- (void)showCellIndicator:(BOOL)isShow
{
    self.rightIndicator.hidden = !isShow;
    if (isShow) {
        [self.rightIndicator mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-15);
            make.height.equalTo(@13);
            make.width.equalTo(@7);
            make.centerY.equalTo(self);
        }];
    }else{
        [self.rightIndicator mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.width.equalTo(@1);
        }];
    }
    [self setNeedsDisplay];
}

- (void)setSeparatorLineColor:(UIColor *)color
{
    bottomLineColor = color;
    bottomtempLineColor = color;
    [self setNeedsDisplay];
}

- (void)setSeparatorLineHide:(BOOL)isHide
{
    if (isHide) {
        bottomLineColor = [UIColor clearColor];
    }else{
        bottomLineColor = bottomtempLineColor;
    }
    [self setNeedsDisplay];
}

- (void)setSeparatorLineLeft:(CGFloat)padding
{
    bottomDrawOriginX = padding;
    [self setNeedsDisplay];
}

- (void)setSeparatorLineInset:(UIEdgeInsets)inset
{
    bottomLineInsets = inset;
    [self setNeedsDisplay];
}

- (void)setTopSeparatorLineColor:(UIColor *)color/**<设置分割线的颜色*/
{
    topLineColor = color;
    [self setNeedsDisplay];
}

- (void)setTopSeparatorLineHide:(BOOL)isHide/**<隐藏或显示分割线*/
{
    topLineColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

- (void)setTopSeparatorLineLeft:(CGFloat)padding/**<分割线左缩进*/
{
    topDrawOriginX = padding;
    [self setNeedsDisplay];
}

- (void)seToptSeparatorLineInset:(UIEdgeInsets)inset/**<分割线布局*/
{
    topLineInsets = inset;
    [self setNeedsDisplay];
}

- (void)drawBottomLine
{
//    if (bottomLineIsDraw) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,self.separatorLineHeight);
    CGContextSetStrokeColorWithColor(context, bottomLineColor.CGColor);
    CGContextMoveToPoint(context,bottomDrawOriginX,self.height);
    CGContextAddLineToPoint(context,self.width-bottomLineInsets.right,self.height);
    
    if (isDrawTopLine)
    {
        CGContextMoveToPoint(context,0,0);
        CGContextAddLineToPoint(context,self.width-bottomLineInsets.right,0);
    }
    
    CGContextStrokePath(context);
//    bottomLineIsDraw = YES;
}

-(void)isHidenTopLine:(BOOL)topLine BottomLine:(BOOL)bottomLine LeftLine:(BOOL)leftLine RightLine:(BOOL)rightLine Color:(UIColor *)color lineWight:(CGFloat)wight{
    self.separatorLineHeight=wight;
    [self setDemonSeparatorStyle:DemonTableViewCellSeparatorFull];
    [self setTopLineStyle:DemonTableViewCellSeparatorFull];
    if (topLine) {
        [self drawTopLine:[UIColor clearColor]];
    }else{
        [self drawTopLine:color];
    }
    if (bottomLine) {
        [self setSeparatorLineColor:[UIColor clearColor]];
    }else{
        [self setSeparatorLineColor:color];
    }
    if (leftLine) {
        [self drawLeftLine:[UIColor clearColor]];
    }else{
        [self drawLeftLine:color];
    }
    if (rightLine) {
        
        [self drawRightLine:[UIColor clearColor]];
        
    }else{
        [self drawRightLine:color];
    }
}

- (void)drawLeftLine:(UIColor *)color
{
    leftColor=color;
     [self setNeedsDisplay];
}

-(void)drawLeftLine{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,self.separatorLineHeight);
    CGContextSetStrokeColorWithColor(context, leftColor.CGColor);
    CGContextMoveToPoint(context,0,0);
    CGContextAddLineToPoint(context,0,self.height);
    CGContextStrokePath(context);

}
- (void)drawRightLine:(UIColor *)color{
    rightColor=color;
    [self setNeedsDisplay];
}

- (void)drawRightLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,self.separatorLineHeight);
    CGContextSetStrokeColorWithColor(context, rightColor.CGColor);
    CGContextMoveToPoint(context,self.width,0);
    CGContextAddLineToPoint(context,self.width,self.height);
    CGContextStrokePath(context);
}

- (void)drawTopLine:(UIColor *)color{
    topLineColor=color;
    [self setNeedsDisplay];
}
- (void)drawTopLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,self.separatorLineHeight);
    CGContextSetStrokeColorWithColor(context, topLineColor.CGColor);
    CGContextMoveToPoint(context,0,0);
    CGContextAddLineToPoint(context,self.width,0);
    CGContextStrokePath(context);
}

#pragma mark -
#pragma mark getter

- (UIImageView *)rightIndicator
{
    if (!_rightIndicator)
    {
        _rightIndicator = [[UIImageView alloc]init];
        _rightIndicator.backgroundColor = [UIColor clearColor];
        _rightIndicator.image = [UIImage imageNamed:@"arrowHead"];
        _rightIndicator.hidden = YES;
    }
    return _rightIndicator;
}

+(CGFloat)heightForCell{
    return 0.f;
}

-(void)loadData:(id)model{
    
}



@end
