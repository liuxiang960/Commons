//
//  SEAlertBoxPlacingView.m
//  SEUDApp
//
//  Created by 自制力 on 17/5/17.
//  Copyright © 2017年 chuangwuxian. All rights reserved.
//

#import "SEAlertBoxPlacingView.h"
#import "SHAlertPlacingCell.h"

@interface SEAlertBoxPlacingView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIImageView *upImageView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UITableView *tableView;
//配售确认按钮
@property (nonatomic, strong) UIButton *placingSureBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, copy) SEAlertBoxBlock callbackBlock;

/**配售信息数组*/
@property (nonatomic, strong) NSArray *placingArray;

@end

@implementation SEAlertBoxPlacingView

#pragma mark -
#pragma mark Life Cycle

- (instancetype)initWithPlacingArray:(NSArray *)placingArray
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _placingArray = placingArray;
        [self addViews];
    }
    return self;
}

#pragma mark -
#pragma mark 添加视图
- (void)addViews{
    [self addSubview:self.upImageView];
    [self addSubview:self.centerView];
    [self addSubview:self.placingSureBtn];
    [self addSubview:self.closeBtn];
    [self.centerView addSubview:self.tableView];
    
    [_tableView reloadData];
    [self updateViewConstraints];
}

#pragma mark -
#pragma mark 约束适配
-(void)updateViewConstraints
{
    CGFloat centerViewAddHeight = 0.0;
    if (_placingArray.count == 4) {
        centerViewAddHeight = 46.0;
    }
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(280.f);
        make.height.mas_equalTo(400.f + centerViewAddHeight);
    }];
    
    [_upImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@163.f);
    }];
    
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upImageView.mas_bottom).offset(-1.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).offset(-36.0f);
        make.height.equalTo(@(154.f + centerViewAddHeight));
    }];
    
    [_placingSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerView.mas_bottom).offset(-16.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@143.f);
        make.height.equalTo(@32.f);
    }];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_placingSureBtn.mas_bottom).offset(35.f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@32.f);
        make.height.equalTo(@32.f);
    }];
    
    if (_placingArray.count > 2) {
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_centerView.mas_top).equalTo(@10.f);
            make.centerX.equalTo(_centerView.mas_centerX);
            make.width.equalTo(_centerView.mas_width).offset(-80.f);
            make.height.equalTo(@(41.f * _placingArray.count));
        }];
    }else{
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_centerView.mas_centerX);
            make.centerY.equalTo(_centerView.mas_centerY).offset(-8.f);
            make.width.equalTo(_centerView.mas_width).offset(-80.f);
            make.height.equalTo(@(41.f * _placingArray.count));
        }];
    }
}



#pragma mark -
#pragma mark Event Response
-(void)placingBtnAction:(id)sender{
    if (_callbackBlock) _callbackBlock(AlertBoxButtonSure);
}


-(void)closeBtnAction:(id)sender{
    if (_callbackBlock) _callbackBlock(AlertBoxButtonClose);
}


#pragma mark -
#pragma mark Getter & Setter

-(UIImageView *)upImageView{
    if (!_upImageView) {
        UIImageView *upImageView = [[UIImageView alloc] init];
        upImageView.image = [UIImage imageNamed:@"placingBg"];
        _upImageView = upImageView;
    }
    return _upImageView;
}

- (UIView *)centerView{
    if (!_centerView) {
        UIView *centerView = [[UIView alloc] init];
        centerView.backgroundColor = [UIColor colorWithHexString:@"e45149" withAlpha:1];
        CGFloat centerViewAddHeight = 0.0;
        if (_placingArray.count == 4) {
            centerViewAddHeight = 46.0;
        }
        centerView.bounds = CGRectMake(0, 0, 280.0 - 36.0, 154.0 + centerViewAddHeight);
        [SeudPublic setLayerAndBezierPathCutCircularWithView:centerView rectCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(16.0, 16.0)];
        _centerView = centerView;
    }
    return _centerView;
}

- (UIButton *)placingSureBtn{
    if (!_placingSureBtn) {
        UIButton *placingSureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [placingSureBtn setImage:[UIImage imageNamed:@"placingSure"] forState:(UIControlStateNormal)];
        [placingSureBtn addTarget:self action:@selector(placingBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _placingSureBtn = placingSureBtn;
    }
    return _placingSureBtn;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        UIButton *closeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [closeBtn setImage:[UIImage imageNamed:@"placingClose"] forState:(UIControlStateNormal)];
        [closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _closeBtn = closeBtn;
    }
    
    return _closeBtn;
}


- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.allowsSelection = NO;
        tableView.scrollEnabled = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        _tableView = tableView;
    }
    return _tableView;
}


#pragma mark ---- data数据源
- (void)setPlacingArray:(NSArray *)placingArray{
    _placingArray = placingArray;
    
    _centerView.bounds = CGRectMake(0, 0, 280.0 - 36.0, 154.0);
    [SeudPublic setLayerAndBezierPathCutCircularWithView:_centerView rectCorner:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(16.0, 16.0)];
    if (_placingArray.count >= 1) {
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_centerView.mas_top).equalTo(@10.f);
        }];
    }
    [_tableView reloadData];
}


#pragma mark ---- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _placingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"TableViewCell";
    SHAlertPlacingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SHAlertPlacingCell" owner:self options:nil] lastObject];
    }
    cell.labText.text = [NSString stringWithFormat:@"%@",_placingArray[indexPath.row]];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41.0;
}




#pragma mark -
#pragma mark PublicMethod

-(void)show:(SEAlertBoxBlock)callback{
    
    [super show:callback];
    _callbackBlock = callback;
}




@end
