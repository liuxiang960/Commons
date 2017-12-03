//
//  UIButton.m
//  SEUDApp
//
//  Created by Chengkai on 16/8/19.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "UIButton+Extends.h"
#import "OperateService.h"

@implementation UIButton (Extends)
@dynamic isCstomBol;
static char isCstomBolKey;

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString* name = [NSString stringWithFormat:@"%@:%ld",self.titleLabel.text,(long)self.tag];
    dispatch_async(dispatch_get_main_queue(), ^{
        [OperateService clickButton:name];
    });
    [super touchesBegan:touches withEvent:event];
}

-(void)startCountdown:(NSInteger)secs{
    if (secs <= 0) return;
    if (!self.isCstomBol) {
        [self setBackgroundImage:[UIImage imageNamed:@"verify_selected"] forState:UIControlStateNormal];
    }
    __block NSInteger time = secs - 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isCstomBol) {
                    [self setTitle:@"| 重新获取" forState:UIControlStateNormal];
                    [self setTitleColor:SEUD_Color_Standard_Blue_14 forState:UIControlStateNormal];
                }else{
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setBackgroundImage:[UIImage imageNamed:@"verify_normal"] forState:UIControlStateNormal];
                    [self setTitleColor:SEUD_Color_White_10 forState:UIControlStateNormal];
                }
                self.userInteractionEnabled = YES;
            });
        }else{
            int seconds = (int)time % secs;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.isCstomBol) {
                    [self setTitle:[NSString stringWithFormat:@"| 重发(%ds)", seconds] forState:UIControlStateNormal];
                    [self setTitleColor:SEUD_Color_Standard_Blue_14 forState:UIControlStateNormal];
                }else{
                    [self setTitle:[NSString stringWithFormat:@"重发(%ds)", seconds] forState:UIControlStateNormal];
                    [self setTitleColor:[UIColor colorWithHexString:@"979797"] forState:UIControlStateNormal];
                }
                self.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}
-(void)startCountdown:(NSInteger)secs backgroundImage:(UIImage*)image {
    if (secs <= 0) return;
    [self setBackgroundImage:image forState:UIControlStateNormal];
    __block NSInteger time = secs - 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isCstomBol) {
                    [self setTitle:@"| 重新获取" forState:UIControlStateNormal];
                    [self setTitleColor:SEUD_Color_Standard_Blue_14 forState:UIControlStateNormal];
                     [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }else{
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setBackgroundImage:[UIImage imageNamed:@"verify_normal"] forState:UIControlStateNormal];
                    [self setTitleColor:SEUD_Color_White_10 forState:UIControlStateNormal];
                }
                self.userInteractionEnabled = YES;
            });
        }else{
            int seconds = (int)time % secs;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.isCstomBol) {
                    [self setTitle:[NSString stringWithFormat:@"| 重发(%ds)", seconds] forState:UIControlStateNormal];
                    [self setTitleColor:SEUD_Color_Standard_Blue_14 forState:UIControlStateNormal];
                }else{
                    [self setTitle:[NSString stringWithFormat:@"| 重发(%ds)", seconds] forState:UIControlStateNormal];
                    [self setTitleColor:[UIColor colorWithHexString:@"979797"] forState:UIControlStateNormal];
                }
                self.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

-(void)setIsCstomBol:(BOOL)isCstomBol{
    objc_setAssociatedObject(self, &isCstomBolKey,[NSNumber numberWithBool:isCstomBol], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (isCstomBol) {
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self setTitle:@"| 获取验证码" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:SEUD_Color_Standard_Blue_14 forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}
-(BOOL)isCstomBol{
   return objc_getAssociatedObject(self, &isCstomBolKey);
}
@end
