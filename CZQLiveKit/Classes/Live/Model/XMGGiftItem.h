//
//  XMGGiftItem.h
//  码哥课堂
//
//  Created by yz on 2016/12/24.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMGUserItem;
@interface XMGGiftItem : NSObject

// 礼物ID
@property (nonatomic, assign) NSInteger giftId;

// 用户模型:记录哪个用户发送
@property (nonatomic, strong) XMGUserItem *user;

// 礼物名称
@property (nonatomic, strong) NSString *giftName;

// 礼物个数,用来记录礼物的连击数
@property (nonatomic, assign) NSInteger giftCount;

// 发送哪个房间
@property (nonatomic, strong) NSString *roomKey;

+ (instancetype)giftWithGiftId:(NSInteger)giftId  giftCount:(NSInteger)giftCount roomKey:(NSString *)roomKey giftName:(NSString *)giftName;

@end
