//
//  XMGLiveListViewController.m
//  码哥课堂
//
//  Created by yz on 2016/12/9.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "XMGLiveListViewController.h"
#import "XMGBroadcasterViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "XMGLiveItem.h"
#import "XMGLiveCell.h"
#import "XMGAudienceViewController.h"
static NSString * const ID = @"cell";
@interface XMGLiveListViewController ()
/** 直播 */
@property(nonatomic, strong) NSMutableArray *lives;
@end

@implementation XMGLiveListViewController

// 进入主播界面
- (IBAction)ToBroadcaster:(id)sender {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    
    NSString *sName = [NSString stringWithFormat:@"%@.bundle/Live",bundle.infoDictionary[@"CFBundleName"]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sName bundle:bundle];
    
    XMGBroadcasterViewController *broadcasterVc = [storyboard instantiateViewControllerWithIdentifier:@"broadcaster"];
    
    [self presentViewController:broadcasterVc animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载直播数据
    // http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    AFJSONResponseSerializer *rsp = [AFJSONResponseSerializer serializer];
    
    rsp.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    mgr.responseSerializer = rsp;
    
    [mgr GET:@"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  responseObject) {
        
        _lives = [XMGLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *nibName = [NSString stringWithFormat:@"%@.bundle/XMGLiveCell",bundle.infoDictionary[@"CFBundleName"]];
    
    [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:bundle] forCellReuseIdentifier:ID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.live = _lives[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    

    NSString *sName = [NSString stringWithFormat:@"%@.bundle/Live",bundle.infoDictionary[@"CFBundleName"]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sName bundle:bundle];
    
    XMGAudienceViewController *audienceVC = [storyboard instantiateViewControllerWithIdentifier:@"audience"];
    
    audienceVC.item = _lives[indexPath.row];
    
    [self presentViewController:audienceVC animated:YES completion:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 430;
}

@end
