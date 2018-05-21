//
//  ViewController.m
//  GitDemo
//
//  Created by admin on 2018/5/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "BannerScrollView/BannerScrollView.h"

@interface ViewController () <BannerScrollViewDelegate>

@property (nonatomic, weak) BannerScrollView *bannerScrollView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BannerScrollView *bannerScrollView = [[BannerScrollView alloc] init];
    bannerScrollView.delegate = self;
    bannerScrollView.bannerArray = self.dataArray;
    bannerScrollView.autoScroll = NO;
    bannerScrollView.titleTextColor = [UIColor blackColor];
    [self.view addSubview:bannerScrollView];
    _bannerScrollView = bannerScrollView;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _bannerScrollView.bannerTitlePosition = BannerTitlePositionTop;
        _bannerScrollView.titleTextFont = [UIFont systemFontOfSize:30];
        _bannerScrollView.titleTextColor = [UIColor redColor];
        _bannerScrollView.titleTextAlignment = NSTextAlignmentCenter;
        
    });
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _bannerScrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
}

#pragma mark - BannerScrollViewDelegate
- (void)bannerScrollViewDidSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", (long)index);
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            Banner *banner = [[Banner alloc] init];
            banner.title = [NSString stringWithFormat:@"title%d", i];
            banner.imageURLStr = [NSString stringWithFormat:@"image%d", i];
            [_dataArray addObject:banner];
        }
    }
    return _dataArray;
    
}

@end
