//
//  XMGRoomItem.h
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRoomItem : NSObject
@property (nonatomic, strong) NSString *roomKey;
@property (nonatomic, strong) NSString *roomName;

+ (instancetype)itemWithName:(NSString *)name;

@end
