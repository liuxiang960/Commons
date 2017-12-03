//
//  LXTabBarControllerConfig.m
//  SeudBaseProject
//
//  Created by 刘湘 on 2017/11/12.
//  Copyright © 2017年 刘湘. All rights reserved.
//

#import "LXTabBarControllerConfig.h"
#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"
#import "UINavigationController+GKCategory.h"
#import "GKNavigationBarConfigure.h"
@interface LXTabBarControllerConfig()
@property (nonatomic,copy)NSArray *controlls;
@property (nonatomic,copy)NSArray *configArry;
@end
@implementation LXTabBarControllerConfig
-(id)initWithController:(NSArray *)controllArry AndTitleAndColor:(NSArray *)configArry defaultSelet:(NSInteger)slectIndex{
    if ([self init]) {
        self.controlls   = controllArry;
        self.configArry  = configArry ;
        self.selectIndex = slectIndex;
    }
    return self;
}

-(void)setControlls:(NSArray *)controlls{
    NSMutableArray *muControlls = [[NSMutableArray alloc] init];
    for (UIViewController *vc in controlls) {
        UINavigationController *nav = [UINavigationController rootVC:vc translationScale:YES];
        nav.gk_openScrollLeftPush = YES;
        [muControlls  addObject:nav];
    }
    _controlls = muControlls  ;
}
-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    self.tabBarController.selectedIndex = selectIndex;
}


- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        CYLTabBarController * tabBarController = [[CYLTabBarController alloc] init];
        tabBarController.tabBarItemsAttributes = self.configArry;
        tabBarController.viewControllers = self.controlls;
        _tabBarController = tabBarController;
        [self customizeInterface];
    }
    return _tabBarController;
}


- (void)customizeInterface {
    [self setUpNavigationBarAppearance];
}

/**
 *  设置navigationBar样式
 */
- (void)setUpNavigationBarAppearance {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"tabbar_market"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"tabbar_market"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
@end
