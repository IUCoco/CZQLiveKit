//
//  XMGRoomItem.m
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGRoomItem.h"

@implementation XMGRoomItem
+ (instancetype)itemWithName:(NSString *)name
{
    XMGRoomItem *item = [[self alloc] init];
    
    item.roomKey = [NSString stringWithFormat:@"%d",arc4random_uniform(100000)];
    
    item.roomName = name;
    
    return item;
}
@end
