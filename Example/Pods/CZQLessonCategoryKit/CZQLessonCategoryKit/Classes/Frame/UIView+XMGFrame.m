//
//  UIView+XMGFrame.m
//  码哥课堂
//
//  Created by yz on 2016/11/15.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "UIView+XMGFrame.h"

@implementation UIView (XMGFrame)

- (void)setX:(CGFloat)x
{
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

+ (instancetype)viewFromXib
{
    NSBundle *bundle = [NSBundle bundleForClass:self];
    
    NSString *bundleName = bundle.infoDictionary[@"CFBundleName"];
    
    NSString *nibName = [NSString stringWithFormat:@"%@.bundle/%@",bundleName,NSStringFromClass(self)];
    return [[bundle loadNibNamed:nibName owner:nil options:nil] lastObject];

}

@end
