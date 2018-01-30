//
//  XMGGiftButton.m
//  码哥课堂
//
//  Created by yz on 2016/12/25.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGGiftButton.h"
#import "XMGGiftItem.h"
@implementation XMGGiftButton
- (void)setGiftItem:(XMGGiftItem *)giftItem
{
    _giftItem = giftItem;
    
    [self setImage:[UIImage imageNamed:giftItem.giftName] forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
