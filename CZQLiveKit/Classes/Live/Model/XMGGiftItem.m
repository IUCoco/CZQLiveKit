//
//  XMGGiftItem.m
//  码哥课堂
//
//  Created by yz on 2016/12/24.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGGiftItem.h"
#import "XMGUserItem.h"
@implementation XMGGiftItem
+ (instancetype)giftWithGiftId:(NSInteger)giftId giftCount:(NSInteger)giftCount roomKey:(NSString *)roomKey giftName:(NSString *)giftName
{
    XMGGiftItem *item = [[self alloc] init];
    item.giftId = giftId;
    item.user = [[XMGUserItem alloc] init];
    // ID一样，模拟只有一个用户
    item.user.id = 1;
    item.user.userName = @"用户1";
    item.giftCount = giftCount;
    item.roomKey = roomKey;
    item.giftName = giftName;
    return item;

}
@end
