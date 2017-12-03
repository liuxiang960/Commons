//
//  UIViewController.m
//  SEUDApp
//
//  Created by Chengkai on 16/6/22.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "UIViewController+CurrentViewController.h"

@implementation UIViewController (CurrentViewController)

+(UIViewController *) findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0){
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0){
            return [UIViewController findBestViewController:svc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0){
            return [UIViewController findBestViewController:svc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        return vc;
    }
}

+(UIViewController *) currentViewController {
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

+(NSArray *)tabRootViewControllers{
    UIViewController *controller = [self currentViewController];
    NSArray *tmpArray = [controller.tabBarController viewControllers];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    UIViewController *tmpVC;
    for (int i = 0; i < tmpArray.count; i++) {
        tmpVC = tmpArray[i];
        [resultArray addObject:[UIViewController findBestViewController:tmpVC]];
    }
    return resultArray;
}

@end
