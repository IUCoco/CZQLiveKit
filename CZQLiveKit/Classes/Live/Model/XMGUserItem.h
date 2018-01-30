//
//  XMGUserItem.h
//  码哥课堂
//
//  Created by yz on 2016/12/24.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGUserItem : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) NSInteger id;

+ (instancetype)user;

@end
