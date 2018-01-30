//
//  XMGGiftAnimView.m
//  码哥课堂
//
//  Created by yz on 2016/11/9.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGGiftAnimView.h"
#import "XMGGiftItem.h"
#import "XMGUserItem.h"

@interface XMGGiftAnimView ()
@property (weak, nonatomic) IBOutlet UILabel *comboView;
@property (weak, nonatomic) IBOutlet UIImageView *giftView;
@property (weak, nonatomic) IBOutlet UILabel *giftLabel;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger curComboCount;
@property (nonatomic, assign) BOOL isCancel;

@end

@implementation XMGGiftAnimView

+ (instancetype)giftAnimView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setGift:(XMGGiftItem *)gift
{
    _gift = gift;
    
   
    _giftView.image = [UIImage imageNamed:gift.giftName];
    _giftLabel.text = [NSString stringWithFormat:@"%@发送%@",_gift.user.userName,_gift.giftName];
 
}

#pragma mark - 开始礼物动画
- (void)startComboAnim{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(combo) userInfo:nil repeats:YES];
        _curComboCount = 1;
    }
}

// 连击
- (void)combo
{
    // 当前连发数，已经显示完毕
    if (_curComboCount > _gift.giftCount) { // 停止定时器
        
        // 停止定时器
        [self performSelector:@selector(cancel) withObject:nil afterDelay:1];
        
    } else {
        
        // 修改label显示
        _comboView.text = [NSString stringWithFormat:@"x %ld",_curComboCount];
        
        [UIView animateWithDuration:0.15 animations:^{
            
            _comboView.transform = CGAffineTransformMakeScale(3, 3);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.15 animations:^{
                _comboView.transform = CGAffineTransformIdentity;
            }];
        }];
        
        // 取消定时器销毁，这一步不能少，否则会造成连击数还没显示完，定时器就销毁了，就不会显示以后的连击数了
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancel) object:nil];
        
        _curComboCount++;
    }
}


- (void)cancel
{
    if (_isCancel == NO) {
    
        _isCancel = YES;
        
        [_timer invalidate];
        _timer = nil;
        
        if (_dismissView) {
            _dismissView(self);
        }
    }
}




@end
