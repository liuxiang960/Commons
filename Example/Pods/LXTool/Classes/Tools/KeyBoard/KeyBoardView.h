//
//  KeyBoardView.h
//  keyboardDemo
//
//  Created by Souyun on 16/3/17.
//  Copyright © 2016年 Souyun. All rights reserved.
//

//选择键盘样式
/*
 1:600键盘
 2:不带特殊字符大写键盘
 3:纯数字键盘
 4:特殊字符键盘
 5:大写键盘
 7:全仓半仓键盘
 6:小写键盘
 8:数字键盘
 9:phone键盘
 
 注意：
 1、如果想用4、5、6、8 键盘模式，调用[_keyBoardView choseKeyType:5];即可，此套键盘上有多种状态切换
 2、使用其他键盘，调用[_keyBoardView choseKeyType:对应键盘序号];
 
 
 */

#import <UIKit/UIKit.h>

@protocol keyBoardDelegate <NSObject>

@optional
/**回退*/
-(void) numberKeyBoardBackSpace;
/**搜索*/
-(void) keybooarSearch;
/**获得键盘输入字符*/
-(void) keyboardInputlongString:(NSString *)numString;
/**收回键盘*/
-(void) keyboardSure;
/**登录*/
-(void) keyboardLogin;
/**持仓状态：“全仓”、“半仓”、“1/3仓”、“1／4仓”*/
-(void) keyboardNumLoadString:(NSString *)title;

@end


@interface KeyBoardView : UIView

@property(nonatomic,strong)NSMutableArray *numkeyNameArray;
@property(nonatomic,strong)NSMutableArray *abcKeyNameArray;
@property(nonatomic,strong)NSMutableArray *keyType3NameArray;
@property(nonatomic,strong)NSMutableArray *keyType4NameArray;
@property(nonatomic,strong)NSMutableArray *keyType5NameArray;
@property(nonatomic,strong)NSMutableArray *keyType6NameArray;
@property(nonatomic,strong)NSMutableArray *keyType7NameArray;
@property(nonatomic,strong)NSMutableArray *keyType8NameArray;
@property(nonatomic,strong)UIView *numberKeyView;
@property(nonatomic,strong)UIView *abcKeyView;
@property(nonatomic,strong)UIView *keyType3View;
@property(nonatomic,strong)UIView *keyType4View;
@property(nonatomic,strong)UIView *keyType5View;
@property(nonatomic,strong)UIView *keyType6View;
@property(nonatomic,strong)UIView *keyType7View;
@property(nonatomic,strong)UIView *keyType8View;
@property(nonatomic,assign)NSInteger tempIndex_1;
@property(nonatomic,assign)NSInteger tempIndex_2;
@property(nonatomic,assign)NSInteger tempIndex_3;
@property(nonatomic,assign)NSInteger tempIndex_4;
@property(nonatomic,copy) NSString *typeString;

@property(nonatomic,assign)id<keyBoardDelegate>delegate;

-(void)choseKeyType:(NSInteger)keyNumber;

- (id)initWithFrame:(CGRect)frame withString:(NSString *)string;

/**
 *  @author 程凯, 16-07-18 14:07:11
 *
 *  获取键盘
 *
 *  @param keyBoardType 键盘类型 1:600键盘  2:不带特殊字符大写键盘  3:纯数字键盘  4:特殊字符键盘  5:大写键盘  6:小写键盘  7:全仓半仓键盘 8:数字键盘
 *  @param string       右下角大按钮上的文字  取值: "登录"、"完成"...
 *
 *  @return 键盘
 *
 *  @since 1.0
 */
+ (instancetype)sharedInstance:(NSInteger)keyBoardType withString:(NSString *)string;

/**
 *  @author 程凯, 16-07-18 15:07:27
 *
 *  获取键盘
 *
 *  @param keyBoardType 键盘类型 1:600键盘  2:不带特殊字符大写键盘  3:纯数字键盘  4:特殊字符键盘  5:大写键盘  6:小写键盘  7:全仓半仓键盘 8:数字键盘
 *  @param string       右下角大按钮上的文字  取值: "登录"、"完成"...
 *  @param delegate     键盘代理
 *
 *  @return 键盘
 *
 *  @since 1.0
 */
+ (instancetype)sharedInstance:(NSInteger)keyBoardType withString:(NSString *)string delegate:(id<keyBoardDelegate>)delegate;

/**
 *  @author 程凯, 16-07-18 15:07:14
 *
 *  获取键盘,右下角按钮默认为登录按钮
 *
 *  @param keyBoardType 键盘类型 1:600键盘  2:不带特殊字符大写键盘  3:纯数字键盘  4:特殊字符键盘  5:大写键盘  6:小写键盘  7:全仓半仓键盘 8:数字键盘
 *
 *  @return 键盘
 *
 *  @since 1.0
 */
+ (instancetype)sharedInstance:(NSInteger)keyBoardType;

@end
