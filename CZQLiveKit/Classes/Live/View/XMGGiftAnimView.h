//
//  XMGGiftAnimView.h
//  码哥课堂
//
//  Created by yz on 2016/11/9.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGGiftItem;
@interface XMGGiftAnimView : UIView
@property (nonatomic, strong) XMGGiftItem *gift;
@property (nonatomic, strong) void(^dismissView)(XMGGiftAnimView *giftView);
+ (instancetype)giftAnimView;
- (void)startComboAnim;
@end
