//
//  XMGLiveChatViewController.m
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGLiveChatViewController.h"
#import "SocketIOClient+XMGSocket.h"
#import "XMGMessageItem.h"
#import <MJExtension/MJExtension.h>
@interface XMGLiveChatViewController ()
@property (nonatomic, strong) NSMutableArray *messages;
@end

@implementation XMGLiveChatViewController

- (NSMutableArray *)messages
{
    if (_messages == nil) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 监听评论事件
    [[SocketIOClient clientSocket] on:@"chat" callback:^(NSArray * _Nonnull data, SocketAckEmitter * _Nonnull ask) {
        
        XMGMessageItem *item = [XMGMessageItem mj_objectWithKeyValues:data.firstObject];
        
        [self.messages addObject:item];
        
        [self.tableView reloadData];
        
        // 当内容超过tableView高度,恢复额外滚到区域
        // 否则用户滚动tableView的时候，第一个cell距离tableView最上面总是有段间距可以滚动，应该是滚动到最上面，就不能在看上面的东西
        if (self.tableView.contentSize.height > self.tableView.bounds.size.height) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self.tableView.contentInset = UIEdgeInsetsZero;
            }];
            
        }
        
        // 让tableView滚到最后一行
         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
        
         [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.bounds.size.height, 0, 0, 0);
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    
    XMGMessageItem *item = _messages[indexPath.row];
    
    cell.textLabel.attributedText = item.chatStr;
    
    return cell;
}

@end
