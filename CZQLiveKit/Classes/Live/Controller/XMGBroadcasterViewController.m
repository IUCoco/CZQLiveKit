//
//  XMGBroadcasterViewController.m
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGBroadcasterViewController.h"
#import "SVProgressHUD.h"

#import "SocketIOClient+XMGSocket.h"

#import <MJExtension/MJExtension.h>
#import "XMGRoomItem.h"
#import "LFLiveKit.h"

// rtmp://59.110.6.8:1935/live/room
static NSString * const XMGRTMPPushUrl = @"rtmp://59.110.6.8:1935/live/";

@interface XMGBroadcasterViewController ()<LFLiveSessionDelegate>
@property (weak, nonatomic) IBOutlet UIView *preView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (nonatomic, strong) XMGRoomItem *item;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) LFLiveSession *session;
@end

@implementation XMGBroadcasterViewController

- (LFLiveSession *)session
{
    if (_session == nil) {
        
        LFLiveAudioConfiguration *voiceConf = [LFLiveAudioConfiguration defaultConfiguration];
        
        LFLiveVideoConfiguration *videoConf = [LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium3];
        
        LFLiveSession *session = [[LFLiveSession alloc] initWithAudioConfiguration:voiceConf videoConfiguration:videoConf];
        
        session.captureDevicePosition = AVCaptureDevicePositionBack;
        
        // 设置预览View
        session.preView = self.preView;
        
        session.delegate = self;
        
        _session = session;
    }
    return _session;
}

- (IBAction)closeRoom:(id)sender {
    
    // 失去连接，返回上一个界面
    [[SocketIOClient clientSocket] disconnect];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 当主播界面销毁的时候
    // 关闭捕获
    self.session.running = NO;
    
    //  关闭推送
    [self.session stopLive];

    
}

- (IBAction)createRoom:(id)sender {
    
    // 获取房间名称
    if (_textField.text.length == 0) {
        [SVProgressHUD showImage:nil status:@"请输出房间名称"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        
        return;
    }
    
    // 创建房间
    NSString *roomName = _textField.text;
    _item = [XMGRoomItem itemWithName:roomName];
    
    // 创建房间
    [[SocketIOClient clientSocket] emit:@"createRoom" with:@[_item.mj_keyValues]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blur"]];
    imageView.frame = self.view.bounds;
    [_preView addSubview:imageView];
    
    // 监听创建房间是否成功
    [[SocketIOClient clientSocket] on:@"createRoomResult" callback:^(NSArray * _Nonnull data, SocketAckEmitter * _Nonnull ack) {
       
        BOOL success = [data[0] boolValue];
        
        if (success) {
            // 进入主播界面，移除高斯模糊
            [_blurView removeFromSuperview];
            _roomLabel.text = _item.roomName;
            
            [SocketIOClient clientSocket].roomKey = _item.roomKey;
            
            // 开始直播
            [self startLive];
        } else {
            // 清空文本框
            _textField.text = @"";
            
            // 提示重新输入
            [SVProgressHUD showImage:nil status:@"房间同名,请重新输入房间名称"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        }
    }];
}

- (void)startLive
{
    // 开启直播会话
    LFLiveStreamInfo *info = [LFLiveStreamInfo new];
    
    // rtmp:地址
    info.url = [XMGRTMPPushUrl stringByAppendingString:@"room"];
    
    // 开启捕获
    self.session.running = YES;
    
    //  开始推送
    [self.session startLive:info];
}


@end
