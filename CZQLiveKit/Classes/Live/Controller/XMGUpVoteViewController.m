//
//  XMGUpVoteViewController.m
//  码哥课堂
//
//  Created by yz on 2016/12/23.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGUpVoteViewController.h"
#import "SocketIOClient+XMGSocket.h"
#import "UIView+XMGFrame.h"
@interface XMGUpVoteViewController ()

@end

@implementation XMGUpVoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[SocketIOClient clientSocket] on:@"upvote" callback:^(NSArray * _Nonnull data, SocketAckEmitter * _Nonnull ack) {
       // 监听到点赞,进行点赞动画
        [self setupVoteLayer];
    }];
    
}

- (void)setupVoteLayer
{
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"hearts (1)"].CGImage;
    [self.view.layer addSublayer:layer];
    layer.bounds = CGRectMake(0, 0, 30, 30);
    layer.position = CGPointMake(self.view.width * 0.5, self.view.height);
    
    [self setupAnim:layer];
}

- (void)setupAnim:(CALayer *)layer
{
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }];
    
    // 创建basic动画
    CABasicAnimation *alphaAnim = [CABasicAnimation animation];
    alphaAnim.keyPath = @"alpha";
    alphaAnim.fromValue = @0;
    alphaAnim.toValue = @1;
    
    // 路径动画
    CAKeyframeAnimation *pathAnim = [CAKeyframeAnimation animation];
    pathAnim.keyPath = @"position";
    pathAnim.path = [self animPath].CGPath;
    
    
    // 创建动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[alphaAnim,pathAnim];
    group.duration = 5;
    [layer addAnimation:group forKey:nil];
    
    
    
    [CATransaction commit];
}


- (UIBezierPath *)animPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat y = self.view.height;
    CGFloat x = self.view.width * 0.5;
    while (y > 0) {
        x = arc4random_uniform(self.view.width - 20) + 20;
        if (y == self.view.height) {
            [path moveToPoint:CGPointMake(x, y)];
        } else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
        y -= 20;
    }
    
    
    return path;
}

@end
