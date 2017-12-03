//
//  UIViewController.h
//  SEUDApp
//
//  Created by Chengkai on 16/6/22.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CurrentViewController)

+(UIViewController *) currentViewController;

/**
 *  @author 程凯, 16-08-25 11:08:32
 *
 *  tabbar所有根视图
 *
 *  @return
 *
 *  @since 1.0
 */
+(NSArray *)tabRootViewControllers;

@end
