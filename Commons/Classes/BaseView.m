//
//  BaseView.m
//  SEUDApp
//
//  Created by Souyun on 16/6/1.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "BaseView.h"
#import "DZComponent.h"
#import "BaseControllerModel.h"
@interface BaseView (){
    dispatch_source_t _timer;
}

@property(nonatomic,strong)DZComponent* component;

@end

@implementation BaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)addSubView:(UIView *)view{
    [super addSubview:view];
    if ( [view isKindOfClass:[BaseView class]] ){
        ((BaseView*)view).parent = self;
    }
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    self.parent = nil;
}

-(void)postEvent:(NSString *)name{
    [self postEvent:name data:nil];
}

-(void)postEvent:(NSString *)name data:(id)data{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ( self.model ){
            [(BaseControllerModel*)self.model pushEvent:name sender:self data:data];
        }
    });
}

#pragma mark - DZComponent

-(void)render{
    [self.component clearDiff];
}

-(NSDictionary*)schema{
    return nil;
}

-(NSDictionary*)readSchema:(NSString *)name{
    return [self.component readSchema:name];
}

-(BOOL)diff:(NSString *)key{
    return [self.component diff:key];
}

-(void)clearDiff{
    [self.component clearDiff];
}

-(void)startRandomState{
    if ( !_timer ){
        dispatch_queue_t queue = dispatch_get_main_queue();
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), 0.5*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^()
        {
            [self setState:[self.component randomState:self.schema]];
        });
        dispatch_resume(_timer);
    }
}

-(void)stopRandomState{
    if ( _timer ){
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(NSString*)checkSchema:(id)prototype data:(id)value{
    return [self.component checkSchema:prototype data:value];
}

-(DZComponent*)component{
    if ( !_component ){
        _component = [[DZComponent alloc] init];
        _component.wrapper = self;
    }
    return _component;
}

-(NSDictionary*)state{
    return self.component.state;
}

-(void)setState:(NSDictionary *)state{
    self.component.state = state;
}

#pragma mark - propertys

-(id)model{
    id viewModel = nil;
    for (id node = self.parent; node; ) {
        if ( [node respondsToSelector:@selector(model)] ){
            viewModel = [node performSelector:@selector(model)];
            break;
        }
        else{
            if ( [node respondsToSelector:@selector(getParent)] ){
                node = [node performSelector:@selector(getParent)];
            }
            else{
                break;
            }
        }
    }
    return viewModel;
}

@end
