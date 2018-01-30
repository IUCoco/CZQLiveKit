//
//  UIView+XMGFrame.h
//  码哥课堂
//
//  Created by yz on 2016/11/15.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMGFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
/** 从xib中创建一个控件 */
+ (instancetype)viewFromXib;

@end
