//
//  BaseControllerModel.h
//  SEUDApp
//
//  Created by Souyun on 16/6/1.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  ---------------------UIViewController的分类,方便从ViewModel回调ViewController-----------------
 */
typedef NSUInteger SEViewControllerAction;

@interface UIViewController(ViewModel)

- (void)callBackAction;

- (void)callBackAction:(SEViewControllerAction)action;

- (void)callBackAction:(SEViewControllerAction)action info:(id)info;

@end

/**
 *  ---------------------------ViewModel父类相关的定义---------------------------------
 */
typedef void(^EventCallback)(id sender,id data);

@interface BaseControllerModel : NSObject

@property (nonatomic, weak) UIViewController *modelController;
+(instancetype)modelWithViewController:(UIViewController *)viewController;

-(void)onEvent:(NSString*)name callback:(EventCallback)callback;
-(void)removeEvent:(NSString*)name;
-(void)pushEvent:(NSString*)bane sender:(id)sender data:(id)data;

@end
