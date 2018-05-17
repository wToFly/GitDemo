//
//  ViewController.m
//  GitDemo
//
//  Created by admin on 2018/5/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "BannerScrollView/BannerScrollView.h"

@interface ViewController ()

@property (nonatomic, weak) BannerScrollView *bannerScrollView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BannerScrollView *bannerScrollView = [[BannerScrollView alloc] initWithBannerArray:self.dataArray];
    [self.view addSubview:bannerScrollView];
    _bannerScrollView = bannerScrollView;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _bannerScrollView.frame = self.view.bounds;
    
}

- (NSMutableArray *)dataArray {
    
    if (_dataArray) {
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
