//
//  XMGLiveGiftViewController.m
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGLiveGiftViewController.h"
#import "SocketIOClient+XMGSocket.h"
#import "XMGGiftItem.h"
#import "XMGGiftButton.h"
#import "MJExtension.h"
#import "XMGGiftAnimView.h"
#import "XMGUserItem.h"

/**
    XMGLiveGiftViewController类
 */
@interface XMGLiveGiftViewController ()
@property (nonatomic, strong) NSMutableArray *positions;
@property (nonatomic, strong) NSMutableArray *giftQueue;
@property (nonatomic, strong) NSMutableArray *giftAnimViews;
@end

@implementation XMGLiveGiftViewController

- (NSMutableArray *)positions
{
    if (_positions == nil) {
        _positions = [NSMutableArray arrayWithObjects:@0,@1, nil];
    }
    return _positions;
}

- (NSMutableArray *)giftAnimViews
{
    if (_giftAnimViews == nil) {
        _giftAnimViews = [NSMutableArray array];
    }
    return _giftAnimViews;
}

- (NSMutableArray *)giftQueue
{
    if (_giftQueue == nil) {
        _giftQueue = [NSMutableArray array];
    }
    return _giftQueue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 监听礼物
    SocketIOClient *socket = [SocketIOClient clientSocket];
    
    [socket on:@"gift" callback:^(NSArray * _Nonnull data, SocketAckEmitter * _Nonnull ask) {
        
        XMGGiftItem *item = [XMGGiftItem mj_objectWithKeyValues:data[0]];
        
        // 设置礼物动画
        [self setupGiftAnim:item];
    }];

}

#pragma mark - 设置礼物动画
// 显示礼物动画 ，并不是每次都需要创建礼物动画View，
// 1.判断是否是连发礼物
// 2.最多同时显示两个礼物
// 3.创建礼物动画
- (void)setupGiftAnim:(XMGGiftItem *)gift
{
    // 1.判断当前接收的礼物是否属于连发礼物 属于直接return，不需要在重新创建新的动画View
    if ([self isComboGift:gift]) return;

    // 2.添加到礼物队列
    [self.giftQueue addObject:gift];

    // 3.判断当前显示多少个礼物动画View
    if (self.giftAnimViews.count == 2) return;
    
    // 4.处理礼物动画
    [self handleGiftAnim:gift];
}

#pragma mark - 判断当前接收礼物是否属于连发礼物
//- (BOOL)isComboGift:(XMGGiftItem *)gift
//{
//    for (XMGGiftItem *giftItem in self.giftQueue) {
//     
//        // 如果是连发礼物就记录下来
//        if (giftItem.giftId == gift.giftId && giftItem.user.id == gift.user.id) {
//            giftItem.giftCount += 1;
//            return YES;
//        }
//    }
//    
//    return NO;
//}

#pragma mark - 判断当前接收礼物是否属于连发礼物
- (BOOL)isComboGift:(XMGGiftItem *)gift
{
    XMGGiftItem *comboGift = nil;
    
    for (XMGGiftItem *giftItem in self.giftQueue) {
        
        // 如果是连发礼物就记录下来
        if (giftItem.giftId == gift.giftId && giftItem.user.id == gift.user.id) {
            comboGift = giftItem;
        }
    }
    
    if (comboGift) { // 连发礼物有值
        // 礼物模型的礼物总数+1
        comboGift.giftCount += 1;
        return YES;
    }
    
    return NO;
}

// 处理礼物动画
- (void)handleGiftAnim:(XMGGiftItem *)gift
{
    // 1.创建礼物动画的View
    XMGGiftAnimView *giftView = [XMGGiftAnimView giftAnimView];
    
    CGFloat h = self.view.bounds.size.height * 0.5;
    CGFloat w = self.view.bounds.size.width;
    
    // 取出礼物位置
    id position = self.positions.lastObject;
    
    // 从数组移除位置
    [self.positions removeObject:position];
    
    CGFloat y = [position floatValue] * h;
    // 2.设置礼物View的frame
    giftView.frame = CGRectMake(0, y, w, h);
    
    // 3.传递礼物模型
    giftView.gift = gift;
    
    // 记录当前位置
    giftView.tag = [position floatValue];
    
    // 添加礼物View
    [self.view addSubview:giftView];
    
    // 添加记录礼物View数组
    [self.giftAnimViews addObject:giftView];
    
    __weak typeof(self) weakSelf = self;
    
    giftView.dismissView = ^(XMGGiftAnimView *giftView){
        [weakSelf dismissView:giftView];
    };
    
    // 设置动画
    giftView.transform = CGAffineTransformMakeTranslation(-w, 0);
    [UIView animateWithDuration:.25 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        giftView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 开始连击动画
        [giftView startComboAnim];
    }];

}

#pragma mark - 销毁礼物View
- (void)dismissView:(XMGGiftAnimView *)giftView
{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        giftView.alpha = 0;
        giftView.transform = CGAffineTransformMakeTranslation(0, -20);
        
    } completion:^(BOOL finished) {
        
        // 移除动画View
        [giftView removeFromSuperview];
        
        [self.giftAnimViews removeObject:giftView];
        
        [self.giftQueue removeObject:giftView.gift];
        
        // 恢复position数组
        if (giftView.tag == 0) {
            [self.positions insertObject:@0 atIndex:0];
        } else {
            [self.positions addObject:@(giftView.tag)];
        }
        
        // 判断还有没有未执行的动画模型
        // 判断队列中是否还有未处理的礼物
        XMGGiftItem *item = [self fetchUnExcuteItem];
        
        // 处理礼物动画
        if (item) {
            [self handleGiftAnim:item];
        }
        
    }];
    
}

- (XMGGiftItem *)fetchUnExcuteItem
{
    
    for (XMGGiftItem *gift in self.giftQueue) {
        if (![self isExcuteing:gift]) return gift;
    }
    
    return nil;
}

- (BOOL)isExcuteing:(XMGGiftItem *)item
{
    for (XMGGiftAnimView *animView in self.giftAnimViews) {
        
        if (animView.gift == item) {
            return YES;
        }
    }
    
    return NO;
}


@end

@interface XMGGiftChooserViewController ()
@property (nonatomic, strong) NSMutableArray *gifts;
@property (strong, nonatomic) IBOutletCollection(XMGGiftButton) NSArray *giftButtons;


@end

@implementation XMGGiftChooserViewController

- (NSMutableArray *)gifts
{
    if (_gifts == nil) {
        
        _gifts = [NSMutableArray array];
        
        SocketIOClient *socket = [SocketIOClient clientSocket];
        
        XMGGiftItem *gift0 = [XMGGiftItem giftWithGiftId:0 giftCount:1 roomKey:socket.roomKey giftName:@"huojian"];
        [_gifts addObject:gift0];
        XMGGiftItem *gift1 = [XMGGiftItem giftWithGiftId:1 giftCount:1 roomKey:socket.roomKey giftName:@"jinzhuan"];
        [_gifts addObject:gift1];
        XMGGiftItem *gift2 = [XMGGiftItem giftWithGiftId:2 giftCount:1 roomKey:socket.roomKey giftName:@"zuanjie"];
        [_gifts addObject:gift2];
        
    }
    return _gifts;
}

- (IBAction)senderGift:(XMGGiftButton *)sender {
    // 发送礼物
    SocketIOClient *socket = [SocketIOClient clientSocket];
    
    
    [socket emit:@"gift" with:@[sender.giftItem.mj_keyValues]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    int i = 0;
    for (XMGGiftItem *gift in self.gifts) {
        XMGGiftButton *btn = _giftButtons[i];
        i++;
        btn.giftItem = gift;
    }
    
}

@end

