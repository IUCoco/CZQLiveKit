//
//  XMGUserItem.m
//  码哥课堂
//
//  Created by yz on 2016/12/24.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGUserItem.h"

@implementation XMGUserItem
+ (instancetype)user
{
    XMGUserItem *item = [[XMGUserItem alloc] init];
    
    item.id = arc4random_uniform(3);
    
    item.userName = [NSString stringWithFormat:@"用户%ld",item.id];
    
    return item;

}
@end
