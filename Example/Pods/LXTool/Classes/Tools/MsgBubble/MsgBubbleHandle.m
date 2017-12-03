//
//  MsgBubbleHandle.m
//  SEUDApp
//
//  Created by Chengkai on 16/6/22.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "MsgBubbleHandle.h"
#import "MsgBubbleView.h"

@interface MsgBubbleHandle ()

@property (atomic, strong) NSMutableArray *messageStack;
@property (nonatomic, assign) NSInteger msgCount;

@end

@implementation MsgBubbleHandle

#pragma mark -
#pragma mark Life Cycle

+ (instancetype)sharedInstance
{
    static MsgBubbleHandle *sharedInstance = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[MsgBubbleHandle alloc] initPrivate];
    });
    return sharedInstance;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"这个是个单例"
                                   reason:@"应该这样调用 [MsgBubbleHandle sharedInstance]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _msgCount = 0;
        _messageStack = [[NSMutableArray alloc] init];
        [self addObserver:self forKeyPath:@"msgCount" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


#pragma mark -
#pragma mark Private Method

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([@"msgCount" isEqualToString:keyPath]) {
        [self showBubbleMsg];
    }
}

-(void)showBubbleMsg{
    if (self.messageStack.count > 0) {
        if (![MsgBubbleView sharedInstance].isShowing) {
            [[MsgBubbleView sharedInstance] showBubble:self.messageStack.firstObject callback:^{
                if (!DE.isLogin) {
                    [self.messageStack removeAllObjects];
                }else{
                    [self showBubbleMsg];
                }
            }];
            [self.messageStack removeObjectAtIndex:0];
        }
    }
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"msgCount"];
}

#pragma mark -
#pragma mark Event Response


#pragma mark -
#pragma mark Getter & Setter



#pragma mark -
#pragma mark PublicMethod

-(void)msgBroadcastSingleMsg:(NSString *)msg{
    if (!msg || [@"" isEqualToString:msg]) return;
    [self.messageStack addObject:msg];
    self.msgCount++;
}

-(void)msgBroadcastMultiMsg:(NSArray *)msgs{
    [self.messageStack addObjectsFromArray:[self removeEmptyMsg:msgs]];
    self.msgCount += msgs.count;
}

-(NSArray *)removeEmptyMsg:(NSArray *)msgs{

    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    NSString *msg;
    for (int i = 0; i < msgs.count; i++) {
        msg = msgs[i];
        if (msg && ![@"" isEqualToString:msg]) {
            [resultArray addObject:msg];
        }
    }
    return resultArray;
}

@end
