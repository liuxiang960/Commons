//
//  BaseApi.m
//  BottomProject
//
//  Created by 刘湘 on 2017/11/30.
//  Copyright © 2017年 刘湘. All rights reserved.
//

#import "BaseApi.h"

@implementation BaseApi
-(void)jumpToBussions:(BaseViewController *)currentVc Data:(NSObject*)data CallBack:(apiCallBack)call{
    self.currentVc = currentVc;
    self.data = data;
    self.CallBack = call;
}
@end
