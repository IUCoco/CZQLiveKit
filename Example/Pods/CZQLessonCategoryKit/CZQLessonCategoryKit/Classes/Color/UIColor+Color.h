//
//  UIColor+Color.h
//  码哥课堂
//
//  Created by yz on 2016/12/5.
//  Copyright © 2016年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define navigationBarColor COLOR(37, 145, 235,1.0)
@interface UIColor (Color)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end
