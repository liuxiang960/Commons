//
//  LXTabBarControllerConfig.h
//  SeudBaseProject
//
//  Created by 刘湘 on 2017/11/12.
//  Copyright © 2017年 刘湘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYLTabBarController.h"
@interface LXTabBarControllerConfig : NSObject
@property (nonatomic, strong) CYLTabBarController * tabBarController;
@property (nonatomic,assign)  NSInteger selectIndex;/** 选择哪个*/
/******
 NSDictionary *dict = @{
 CYLTabBarItemTitle : titleArr[i],
 CYLTabBarItemImage : images[i],
 CYLTabBarItemSelectedImage : imageSel[i],
 };***/
-(id)initWithController:(NSArray *)controllArry AndTitleAndColor:(NSArray *)configArry defaultSelet:(NSInteger)slectIndex;
@end
