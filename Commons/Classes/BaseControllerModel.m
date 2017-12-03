//
//  BaseControllerModel.m
//  SEUDApp
//
//  Created by Souyun on 16/6/1.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "BaseControllerModel.h"
#import "BaseViewController.h"

/**
 *  ---------------------UIViewController的分类,方便从ViewModel回调ViewController-----------------
 */
@implementation UIViewController(ViewModel)

- (void)callBackAction{
    [self callBackAction:0 info:nil];
}

- (void)callBackAction:(SEViewControllerAction)action{
    [self callBackAction:action info:nil];
}

- (void)callBackAction:(SEViewControllerAction)action info:(id)info{
}

@end


/**
 *  ---------------------------ViewModel父类相关的定义---------------------------------
 */
@interface BaseControllerModel ()

@property(nonatomic,strong)NSMutableDictionary* eventMap;

@end

@implementation BaseControllerModel

-(id)init{
    if ( self = [super init] ){
        self.eventMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)onEvent:(NSString *)name callback:(EventCallback)callback{
    [self.eventMap setObject:callback forKey:name];
}

-(void)removeEvent:(NSString *)name{
    if ( [self.eventMap objectForKey:name] ){
        [self.eventMap removeObjectForKey:name];
    }
}

-(void)pushEvent:(NSString *)name sender:(id)sender data:(id)data{
    EventCallback callback = (EventCallback)[self.eventMap objectForKey:name];
    if ( callback ){
        callback(sender,data);
    }
}

+(instancetype)modelWithViewController:(UIViewController *)viewController{
    BaseControllerModel *model = self.new;
    if (model) {
        model.modelController = viewController;
    }
    return model;
}

@end
