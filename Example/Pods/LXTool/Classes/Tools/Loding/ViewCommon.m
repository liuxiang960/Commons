//
//  ViewCommon.m
//  SEUDApp
//
//  Created by Souyun on 16/5/31.
//  Copyright © 2016年 chuangwuxian. All rights reserved.
//

#import "ViewCommon.h"
#import "MEOHintView.h"
#import "Masonry.h"
#import "SEAlertView.h"
#import "SEAlertBoxHandle.h"
#import "MsgBubbleView.h"
#import "SVProgressHUD.h"
#import "MsgBubbleHandle.h"
#import "LXInformationViewController.h"
//#import "LXLoding.h"
@implementation ViewCommon

+(void)toast:(NSString *)text
{
    [MEOHintView showHintViewWith:text];
}

+(void)openQQ:(NSString *)qq{
//    if ( [QQApiInterface isQQInstalled] ){
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qq]];
//        url = [NSURL URLWithString:@"http://www.365webcall.com/chat/newLeaveWord3.aspx?settings=mw7mXNPmPwbP70z3APm6N0z3A7ImbX6mmN6&res=1920*1080&color=24&ts=N6mw67NIm6mXmNNm7z2EPPz2EbXz2EN&loc=http%3A//www.365webcall.com/chat/ChatWin3.aspx%3Fsettings%3Dmw7mXNPmPwbP70z3APm6N0z3A7ImbX6mmN6&ref=&pUserID=71025"];
//        [[UIApplication sharedApplication] openURL:url];
//    }
//    else{
//        [self toast:@"请先安装QQ"];
//    }
    NSString* url = @"http://www.365webcall.com/chat/ChatWin3.aspx?settings=mw7mmNPmPwbP70z3APm6N0z3AX07z3A66mmmI&UserID=-1";
    LXInformationViewController *web=[[LXInformationViewController alloc] init];
    web.titleStr = @"在线客服";
    web.contentURL = url;
    web.isOnlineService = YES;
    web.hidesBottomBarWhenPushed=YES;
    [[SeudPublic findTopViewController].navigationController pushViewController:web animated:YES];
}

+(void)showSharePad:(NSString *)url{
   
}

+(void)toastWarning:(NSString *)message{
    __block UIView *toastView = [[UIView alloc] init];
    toastView.layer.borderColor = [UIColor redColor].CGColor;
    toastView.layer.borderWidth = 1.f;
    toastView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    UIView *parentView = [UIApplication sharedApplication].keyWindow;
    [parentView addSubview:toastView];
    
    UILabel *label = [[UILabel alloc] init];
    [label setText:message];
    label.numberOfLines = 0;
    label.textColor = SEUD_Color_White_10;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    [label setBackgroundColor:[UIColor clearColor]];
    [toastView addSubview:label];
    
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 15 * 2;
    label.preferredMaxLayoutWidth = maxWidth;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(toastView.mas_centerX);
        make.centerY.equalTo(toastView.mas_centerY);
    }];
    
    [toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(parentView.mas_centerX);
        make.centerY.equalTo(parentView.mas_centerY).offset(150.f);
        make.width.equalTo(label.mas_width).offset(18.f);
        make.height.equalTo(label.mas_height).offset(20.f);
    }];
    
    [UIView animateWithDuration:.4f delay:1.6f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toastView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [toastView removeFromSuperview];
        toastView = nil;
    }];
    
}

+(void)showOperatorNotification:(NSString *)title content:(NSString *)content{
    SEAlertView *alertView = [[SEAlertView alloc] init];
    alertView.title = title;
    alertView.message = content;
    alertView.rightButtonTitle = @"确定";
    alertView.isLeftBtnHidden = YES;
    [alertView showAlertView:^{
        [alertView dismissAlertView];
    }];
}

+(void)showUpgradeNotification:(NSString *)title content:(NSString *)content url:(NSString *)url must:(BOOL)must{
    
    SEAlertBoxTypeCView *altView = (SEAlertBoxTypeCView *)[SEAlertBoxHandle createAlertBoxView:SEAlertBoxTypeC];
    altView.lblTitle.text = title;
    altView.lblContentTitle.text = @"更新内容";
//    content = @"这咋一看好像没什么用。实际上，为什么不仅仅增加 content size 呢？除非没办法，否则你需要避免改变scroll view 的 content size。想要知道为什么？想想一个 table view（UItableView是UIScrollView 的子类，所以它有所有相同的属性），table view 为了适应每一个cell，它的可滚动区域是通过精心计算的。当你滚动经过 table view 的第一个或最后一个 cell 的边界时，table view将 content offset 弹回并复位，所以 cells 又一次恰到好处的紧贴 scroll view 的 bounds。当你想要使用 UIRefreshControl 实现拉动刷新时发生了什么？你不能在 table view 的可滚动区域内放置 UIRefreshControl，否则，table view 将会允许用户通过 refresh control 中途停止滚动，并且将 refresh control 的顶部弹回到视图的顶部。因此，你必须将 refresh control 放在可滚动区域上方。这将允许首先将 content offset 弹回第一行，而不是 refresh control这咋一看好像没什么用。实际上，为什么不仅仅增加 content size 呢？除非没办法，否则你需要避免改变scroll view 的 content size。想要知道为什么？想想一个 table view（UItableView是UIScrollView 的子类，所以它有所有相同的属性），table view 为了适应每一个cell，它的可滚动区域是通过精心计算的。当你滚动经过 table view 的第一个或最后一个 cell 的边界时，table view将 content offset 弹回并复位，所以 cells 又一次恰到好处的紧贴 scroll view 的 bounds。当你想要使用 UIRefreshControl 实现拉动刷新时发生了什么？你不能在 table view 的可滚动区域内放置 UIRefreshControl，否则，table view 将会允许用户通过 refresh control 中途停止滚动，并且将 refresh control 的顶部弹回到视图的顶部。因此，你必须将 refresh control 放在可滚动区域上方。这将允许首先将 content offset 弹回第一行，而不是 refresh control";
    altView.lblContentSubTitle.text = content;
    altView.titleForBtnSure = @"立即更新";
    if (!must){
        altView.isHiddenCancelBtn = NO;
        altView.titleForBtnCancel = @"暂不更新";
    } else {
        altView.isHiddenCancelBtn = YES;
        altView.isHiddenCloseBtn = YES;
    }
    [altView show:^(SEAlertBoxButtonFlag flag) {
        if (!must) [altView dismiss];
        
        if (flag == AlertBoxButtonSure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            });
        }
    }];
    
//    SEAlertView *alertView = [[SEAlertView alloc] init];
//    alertView.title = title;
//    alertView.message = content;
//    if ( !must ){
//        alertView.leftButtonTitle = @"暂不更新";
//        alertView.isLeftBtnHidden = NO;
//    }
//    else{
//        alertView.isLeftBtnHidden = YES;
//    }
//    alertView.rightButtonTitle = @"立即更新";
//    [alertView showAlertView:^{
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
//    }];
}

+(void)showExchangeBubble:(NSString *)text{
    if (DE.isLogin)
        [[MsgBubbleHandle sharedInstance] msgBroadcastSingleMsg:text];
}

+(void)showLoadingView{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}
+(void)showLoadingViewWithMode:(BOOL)mode {
//    [LXLoding showLodingActivityMode:mode];
}
+(void)dismissHiddenInterval:(NSTimeInterval)time{
//    [SVProgressHUD ProgressDismiss:time];
}

+(void)dismissLoadingView{
    [SVProgressHUD dismiss];
}

@end
