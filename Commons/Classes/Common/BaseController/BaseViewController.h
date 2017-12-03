//
//  BaseViewController.h
//  smartcar
//
//  Created by lbs on 15/4/20.
//  Copyright (c) 2015年 lbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseControllerModel.h"
@interface MEOBarButton : UIButton//类似于BarButton

- (nullable instancetype)initWithTitle:(nullable NSString *)title Target:(nullable id)target Action:(nullable SEL)action;

- (nullable instancetype)initWithBackGroundImg:(nullable UIImage *)image Target:(nullable id)target Action:(nullable SEL)action;

- (nullable instancetype)initWithImg:(nullable UIImage *)image Target:(nullable id)target Action:(nullable SEL)action;

- (nullable instancetype)initWithCustomView:(nullable UIButton *)button Target:(nullable id)target Action:(nullable SEL)action;

@end
@class BaseViewController;
typedef void(^VCCallBack)(BOOL success,int code,NSString* desc,NSObject* data,BaseViewController* curerentVc);
@interface BaseViewController : UIViewController

{
@public
    UIView *_navigationBarView;
    UIButton *_baseButton;
    BOOL _modalType;
    NSString *_navTitle;
//    UIImageView *_baseImageView;
}
@property (copy)VCCallBack CallBack;
-(void)setCallBack:(VCCallBack)CallBack;
@property(nonatomic,copy)NSString *lxStockCode;/**交易代码*/
@property(nullable, nonatomic, strong) MEOBarButton *leftButton;//左边按钮
@property(nullable, nonatomic, copy) NSArray<MEOBarButton *> *leftButtons;//右边按钮组
@property(nullable, nonatomic, strong) MEOBarButton *rightButton;//右边按钮
@property (nullable, nonatomic, strong) MEOBarButton *bigRightButton;//大的右侧按钮
@property (nullable, nonatomic, strong) MEOBarButton *bigLeftButton;
@property(nullable, nonatomic, copy) NSArray<MEOBarButton *> *rightButtons;//右边按钮组
@property (nullable, nonatomic, strong) UIImageView *baseImageView;
@property (nonatomic, strong) UIView *leftNavView;/**< 左侧返回按钮的位置 */
/**设置导航栏处于最顶端*/
@property (nonatomic, assign) BOOL makeNavViewToTop;

- (void)addTitleView:(nullable NSString *)title;
- (void)UpTitleView:(nullable NSString *)title;/**< 更新标题 */
- (void)addCustomTitleView:(nullable NSString *)title image:(nullable UIImage *)image;
- (void)UpCustomTitleView:(nullable NSString *)title image:(nullable UIImage *)image;
-(nullable UILabel*)isGetTitleLable;/**< 获取标题对象 */
///////////////////////////////////////////////////////////

-(void)addSubView:(nullable UIView*)view;
-(void)addSubViewFalg:(UIView *)view;
-(void)postEvent:(nullable NSString*)name;
-(void)postEvent:(nullable NSString*)name data:(nullable id)data;

@property(nullable,nonatomic,strong) BaseControllerModel* model;/**< ViewModel(视图modle) */

-(void)viewWillAppear:(BOOL)animated;

///////////////////////////////// DZComponent /////////////////////////////////

-(BOOL)diff:(NSString*)key;
-(void)render;
-(NSDictionary*)schema;
-(NSDictionary*)readSchema:(NSString*)name;
-(void)clearDiff;
-(void)startRandomState;
-(void)stopRandomState;

@property(nonatomic,strong)NSDictionary* state;

@end
