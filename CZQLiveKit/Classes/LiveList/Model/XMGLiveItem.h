//
//  XMGLiveItem.h
//  码哥课堂
//
//  Created by yz on 2017/1/13.
//  Copyright © 2017年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGCreatorItem;
@interface XMGLiveItem : NSObject
/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong) XMGCreatorItem *creator;
@end
