//
//  BannerScrollView.m
//  GitDemo
//
//  Created by admin on 2018/5/17.
//  Copyright © 2018年 admin. All rights reserved.
//


#import "BannerScrollView.h"

@implementation Banner



@end

@interface BannerView : UIView

- (void)configWithBanner:(Banner *)banner;

@end

@interface BannerView ()

@property (nonatomic, strong) Banner *banner;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation BannerView

- (instancetype)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    [self createUI];
    
    return self;
    
}

- (void)createUI {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    _imageView = imageView;
    
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    _label = label;
    
}

- (void)configWithBanner:(Banner *)banner {
    self.banner = banner;
    _imageView.image = [UIImage imageNamed:banner.imageURLStr];
    _label.text = banner.title;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    CGFloat titleH = 30;
    CGFloat titleX = 0;
    CGFloat titleY = self.frame.size.height - titleH;
    CGFloat titleW = self.frame.size.width;
    _label.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}

@end

#pragma mark  BannerScrollView

@interface BannerScrollView () <UIScrollViewDelegate>

@property (readwrite, nonatomic, copy) NSArray<Banner *> *bannerArray;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) BannerView *bannerView1;
@property (nonatomic, weak) BannerView *bannerView2;
@property (nonatomic, weak) BannerView *bannerView3;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation BannerScrollView

- (instancetype)initWithBannerArray:(NSArray<Banner *> *)bannerArray {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.bannerArray = bannerArray;
    [self initialization];
     [self createUI];
    [self reloadData];
    _pageControl.numberOfPages = self.bannerArray.count;
    _pageControl.currentPage = 0;
    
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialization];
    [self createUI];
    
}

- (void)initialization {
    
    _currentPage = 0;
    
}

- (void)createUI {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self addSubview:pageControl];
    _pageControl = pageControl;
    
    BannerView *bannerView1 = [[BannerView alloc] init];
    [_scrollView addSubview:bannerView1];
    _bannerView1 = bannerView1;
    
    BannerView *bannerView2 = [[BannerView alloc] init];
    [_scrollView addSubview:bannerView2];
    _bannerView2 = bannerView2;
    
    BannerView *bannerView3 = [[BannerView alloc] init];
    [_scrollView addSubview:bannerView3];
    _bannerView3 = bannerView3;
    
}

- (void)reloadData {
    
    if (_currentPage == 0) {
        [_bannerView1 configWithBanner:_bannerArray[_bannerArray.count - 1]];
        [_bannerView3 configWithBanner:_bannerArray[_currentPage + 1]];
    } else if (_currentPage == _bannerArray.count - 1) {
        [_bannerView1 configWithBanner:_bannerArray[_currentPage - 1]];
        [_bannerView3 configWithBanner:_bannerArray.firstObject];
    } else {
        [_bannerView1 configWithBanner:_bannerArray[_currentPage - 1]];
        [_bannerView3 configWithBanner:_bannerArray[_currentPage + 1]];
    }
    [_bannerView2 configWithBanner:_bannerArray[_currentPage]];
    _pageControl.currentPage = _currentPage;
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0)];
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self reloadLayout];
    
}

- (void)reloadLayout {
    
    _scrollView.frame = self.bounds;
    
    _pageControl.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height - 18);
    
    _bannerView1.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    _bannerView2.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    _bannerView3.frame = CGRectMake(_scrollView.bounds.size.width * 2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    [_scrollView setContentSize:CGSizeMake(3 * _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0)];
    
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat sw = scrollView.bounds.size.width;
    NSUInteger page = (NSUInteger)scrollView.contentOffset.x / sw;
    if (page == 0) {
        _currentPage = _currentPage - 1;
        if (_currentPage < 0) {
            _currentPage = _bannerArray.count - 1;
        }
    } else if (page == 2) {
        _currentPage = _currentPage + 1;
        if (_currentPage > _bannerArray.count - 1) {
            _currentPage = 0;
        }
    }
    [self reloadData];
    
}

@end
