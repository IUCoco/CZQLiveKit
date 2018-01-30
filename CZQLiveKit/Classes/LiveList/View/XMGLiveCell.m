//
//  XMGLiveCell.m
//  码哥课堂
//
//  Created by yz on 2017/1/13.
//  Copyright © 2017年 yz. All rights reserved.
//

#import "XMGLiveCell.h"
#import "XMGLiveItem.h"
#import "XMGCreatorItem.h"
#import "UIImageView+WebCache.h"
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface XMGLiveCell ()

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *liveLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *chaoyangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigPicView;

@end

@implementation XMGLiveCell



- (void)setLive:(XMGLiveItem *)live
{
    _live = live;
    
    NSURL *imageUrl = [NSURL URLWithString:live.creator.portrait];
    
    if (![live.creator.portrait containsString:@"http:"]) {
        imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img2.inke.cn/%@",live.creator.portrait]];
    }
    
    [self.headImageView sd_setImageWithURL:imageUrl placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    if (live.city.length == 0) {
        _addressLabel.text = @"难道在火星?";
    }else{
        _addressLabel.text = live.city;
    }
    
    self.nameLabel.text = live.creator.nick;
    
    [self.bigPicView sd_setImageWithURL:imageUrl placeholderImage:nil];
    
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%zd人在看", live.online_users];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%zd", live.online_users]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:Color(216, 41, 116) range:range];
    self.chaoyangLabel.attributedText = attr;
}

- (void)awakeFromNib {
    // Initialization code
    _headImageView.layer.cornerRadius = 5;
    _headImageView.layer.masksToBounds = YES;
    
    _liveLabel.layer.cornerRadius = 5;
    _liveLabel.layer.masksToBounds = YES;
}

@end
