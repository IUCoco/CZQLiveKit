//
//  XMGMessageItem.m
//  码哥课堂
//
//  Created by yz on 2016/12/24.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGMessageItem.h"
#import "XMGUserItem.h"
@implementation XMGMessageItem
+ (instancetype)messageWithRoomKey:(NSString *)roomKey message:(NSString *)message
{
    XMGMessageItem *item = [[self alloc] init];
    
    item.roomKey = roomKey;
    
    item.message = message;
    
    item.user = [XMGUserItem user];
    
    return item;
}

- (NSMutableAttributedString *)chatStr
{
    NSString *userName = [NSString stringWithFormat:@"%@:",_user.userName];
    NSMutableAttributedString *userNameAtt = [[NSMutableAttributedString alloc] initWithString:userName attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:_message attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [userNameAtt appendAttributedString:messageAtt];
    
    return userNameAtt;
}
@end
