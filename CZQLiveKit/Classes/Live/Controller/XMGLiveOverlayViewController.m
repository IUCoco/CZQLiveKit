//
//  XMGLiveOverlayViewController.m
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGLiveOverlayViewController.h"
#import "SocketIOClient+XMGSocket.h"
#import <IHKeyboardAvoiding/IHKeyboardAvoiding-Swift.h>
#import "XMGMessageItem.h"
#import <MJExtension/MJExtension.h>
#import "XMGLiveGiftViewController.h"
@interface XMGLiveOverlayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *chatField;
@end

@implementation XMGLiveOverlayViewController

- (IBAction)clickUpvote:(id)sender {
    
    // 发送点赞事件
    [[SocketIOClient clientSocket] emit:@"upvote" with:@[[SocketIOClient clientSocket].roomKey]];
    
}

- (IBAction)clickGift:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Live" bundle:nil];
    
    XMGGiftChooserViewController *chooseVc = [storyboard instantiateViewControllerWithIdentifier:@"giftChooser"];
    
    chooseVc.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:chooseVc animated:YES
                     completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 监听聊天文本框
    _chatField.delegate = self;
    
    [KeyboardAvoiding setAvoidingView:_chatField];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (_chatField.text.length == 0) return YES;
    
    // 发送聊天事件
    XMGMessageItem *message = [XMGMessageItem messageWithRoomKey:[[SocketIOClient clientSocket] roomKey] message:_chatField.text];
    
    NSLog(@"%@",message.mj_keyValues);
    
    // 需要用到scoket，整个项目都要用到，搞个全局单例
    [[SocketIOClient clientSocket] emit:@"chat" with:@[message.mj_keyValues]];
    
    _chatField.text = nil;
    
    return YES;
}


@end
