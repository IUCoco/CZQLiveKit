//
//  XMGMessageItem.h
//  码哥课堂
//
//  Created by yz on 2016/12/24.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGUserItem;
@interface XMGMessageItem : NSObject
@property (nonatomic, strong) NSString *roomKey;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) XMGUserItem *user;
// 不能使用属性，NSMutableAttributedString不能写成json
- (NSMutableAttributedString *)chatStr;

+ (instancetype)messageWithRoomKey:(NSString *)roomKey message:(NSString *)message;
@end
