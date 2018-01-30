//
//  SocketIOClient+XMGSocket.m
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "SocketIOClient+XMGSocket.h"
#define SocketURL @"ws://192.168.0.100:8080"
static NSString *_roomKey = nil;
static SocketIOClient *_clientSocket = nil;
@implementation SocketIOClient (XMGSocket)

+ (instancetype)clientSocket
{
    if (_clientSocket == nil) {
        // 发送请求
        NSURL *url = [NSURL URLWithString:SocketURL];
        _clientSocket = [[SocketIOClient alloc] initWithSocketURL:url config:nil];
        
    }
    
    return _clientSocket;
}

- (void)setRoomKey:(NSString *)roomKey
{
    _roomKey = roomKey;
}

- (NSString *)roomKey
{
    return _roomKey;
}

- (void)connectWithSuccess:(void (^)())successBlock
{
    [_clientSocket connect];
    
    [_clientSocket on:@"connect" callback:^(NSArray * _Nonnull data, SocketAckEmitter * _Nonnull ack) {
        
        if (successBlock) {
            successBlock();
        }
    }];
    
}

+ (instancetype)alloc
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _clientSocket = [super  alloc];
    });
    return _clientSocket;
}

@end
