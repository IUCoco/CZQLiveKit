//
//  SocketIOClient+XMGSocket.h
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <SocketIO/SocketIO-Swift.h>

@interface SocketIOClient (XMGSocket)
+ (instancetype)clientSocket;
@property (nonatomic, strong) NSString *roomKey;
- (void)connectWithSuccess:(void(^)())successBlock;
@end
