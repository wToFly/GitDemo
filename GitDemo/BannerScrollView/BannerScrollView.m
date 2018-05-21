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

@class BannerView;

@protocol BannerViewDelegate <NSObject>

@optional
- (void)BannerViewTap:(BannerView *)bannerView;

@end

@interface BannerView : UIView

@property (nonatomic, weak) id<BannerViewDelegate> delegate;

@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIFont *titleTextFont;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) BannerTitlePosition bannerTitlePosition;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
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

- (void)tap:(UITapGestureRecognizer *)tapGesture {
    if ([self.delegate respondsToSelector:@selector(BannerViewTap:)]) {
        [self.delegate BannerViewTap:self];
    }
}

- (void)configWithBanner:(Banner *)banner {
    self.banner = banner;
    _imageView.image = [UIImage imageNamed:banner.imageURLStr];
    _label.text = banner.title;
    
}

- (void)layoutFrame {
    
    _imageView.frame = self.bounds;
    CGFloat titleH = _titleHeight;
    CGFloat titleX = 0;
    CGFloat titleY = (_bannerTitlePosition == BannerTitlePositionBottom) ? (self.frame.size.height - titleH) : 0;
    CGFloat titleW = self.frame.size.width;
    _label.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutFrame];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor;
    _label.textColor = titleTextColor;
}

- (void)setTitleTextFont:(UIFont *)titleTextFont {
    _titleTextFont = titleTextFont;
    _label.font = titleTextFont;
}

- (void)setTitleHeight:(CGFloat)titleHeight {
    _titleHeight = titleHeight;
    [self layoutFrame];
}

- (void)setBannerTitlePosition:(BannerTitlePosition)bannerTitlePosition {
    _bannerTitlePosition = bannerTitlePosition;
    [self layoutFrame];
}

- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment {
    _titleTextAlignment = titleTextAlignment;
    _label.textAlignment = titleTextAlignment;
}

@end

#pragma mark  BannerScrollView

@interface BannerScrollView () <UIScrollViewDelegate, BannerViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) BannerView *bannerView1;
@property (nonatomic, weak) BannerView *bannerView2;
@property (nonatomic, weak) BannerView *bannerView3;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation BannerScrollView

- (instancetype)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self initialization];
     [self createUI];
    [self reloadData];
    
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialization];
    [self createUI];
    
}

- (void)initialization {
    
    _currentPage = 0;
    _currentPageDotColor = [UIColor redColor];
    _pageDotColor = [UIColor lightGrayColor];
    
    _titleTextFont = [UIFont systemFontOfSize:13];
    _titleTextColor = [UIColor redColor];
    _titleHeight = 30;
    _bannerTitlePosition = BannerTitlePositionBottom;
    _titleTextAlignment = NSTextAlignmentRight;
    
    _autoScroll = YES;
    _autoScrollTimeInterval = 2.0;
    
}

- (void)createUI {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = _pageDotColor;
    pageControl.currentPageIndicatorTintColor = _currentPageDotColor;
    pageControl.hidesForSinglePage = YES;
    [self addSubview:pageControl];
    _pageControl = pageControl;
    
}

- (void)createTimer {
    if (self.bannerArray.count > 1 && self.autoScroll) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(autoScrollMethod) userInfo:nil repeats:YES];
        _timer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void)autoScrollMethod {
    
    if (self.bannerArray.count > 1) {
        [_scrollView setContentOffset:CGPointMake(2 * _scrollView.bounds.size.width, 0) animated:YES];
    }
    
}

- (void)reloadData {
    
    if (self.bannerArray.count > 1) {
        
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
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0)];
        
    }
    [_bannerView2 configWithBanner:_bannerArray[_currentPage]];
    _pageControl.currentPage = _currentPage;
    
}

- (void)createBannerView {
    
    if (self.bannerArray.count > 0) {
        
        if (self.bannerArray.count > 1) {
            
            if (_bannerView1 == nil) {
                BannerView *bannerView1 = [[BannerView alloc] init];
                bannerView1.delegate = self;
                [_scrollView addSubview:bannerView1];
                _bannerView1 = bannerView1;
            }
            if (_bannerView3 == nil) {
                BannerView *bannerView3 = [[BannerView alloc] init];
                bannerView3.delegate = self;
                [_scrollView addSubview:bannerView3];
                _bannerView3 = bannerView3;
            }
            [self setBannerViewProperty:_bannerView1];
            [self setBannerViewProperty:_bannerView3];
            
        }
        if (_bannerView2 == nil) {
            BannerView *bannerView2 = [[BannerView alloc] init];
            bannerView2.delegate = self;
            [_scrollView addSubview:bannerView2];
            _bannerView2 = bannerView2;
        }
        [self setBannerViewProperty:_bannerView2];
        
        
    }
    
    
}

- (void)setBannerViewProperty:(BannerView *)bannerView {
    bannerView.titleTextColor = self.titleTextColor;
    bannerView.titleTextFont = self.titleTextFont;
    bannerView.titleHeight = self.titleHeight;
    bannerView.bannerTitlePosition = self.bannerTitlePosition;
    bannerView.titleTextAlignment = self.titleTextAlignment;
}

- (void)reloadLayout {
    
    _scrollView.frame = self.bounds;
    
    _pageControl.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height - 18);
    if (_bannerView1 != nil) {
        _bannerView1.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    }
    if (_bannerView2 != nil ) {
        if (self.bannerArray.count > 1) {
            _bannerView2.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        } else {
            _bannerView2.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        }
    }
    if (_bannerView3 != nil) {
        _bannerView3.frame = CGRectMake(_scrollView.bounds.size.width * 2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
    }
    [_scrollView setContentSize:CGSizeMake((self.bannerArray.count > 1 ? 3 : 1) * _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    if (self.bannerArray.count > 1) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0)];
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self createTimer];
    [self scrollViewSlideHandle];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewSlideHandle];
}

- (void)scrollViewSlideHandle {
 
    if (self.bannerArray.count > 1) {
        
        CGFloat sw = _scrollView.bounds.size.width;
        NSUInteger page = (NSUInteger)_scrollView.contentOffset.x / sw;
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
    
}

- (void)BannerViewTap:(BannerView *)bannerView {
    if ([self.delegate respondsToSelector:@selector(bannerScrollViewDidSelectItemAtIndex:)]) {
        [self.delegate bannerScrollViewDidSelectItemAtIndex:_currentPage];
    }
}

#pragma mark - getter & setter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self reloadLayout];
}

- (void)setBannerArray:(NSArray<Banner *> *)bannerArray {
    
    _bannerArray = [bannerArray copy];
    _pageControl.numberOfPages = _bannerArray.count;
    _pageControl.currentPage = 0;
    [self createBannerView];
    [self reloadData];
    [self createTimer];
    
}

- (void)setAutoScroll:(BOOL)autoScroll {
    
    _autoScroll = autoScroll;
    [_timer invalidate];
    _timer = nil;
    if (autoScroll) {
        [self createTimer];
    }
    
}

- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval {
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}

- (void)setPageDotColor:(UIColor *)pageDotColor {
    _pageDotColor = pageDotColor;
    _pageControl.pageIndicatorTintColor = pageDotColor;
}

- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor {
    _currentPageDotColor = currentPageDotColor;
    _pageControl.currentPageIndicatorTintColor = currentPageDotColor;
}

- (void)setTitleTextFont:(UIFont *)titleTextFont {
    _titleTextFont = titleTextFont;
    [self setBannerViewValue:titleTextFont foKey:@"titleTextFont"];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor;
    [self setBannerViewValue:titleTextColor foKey:@"titleTextColor"];
}

- (void)setTitleHeight:(CGFloat)titleHeight {
    _titleHeight = titleHeight;
    [self setBannerViewValue:@(titleHeight) foKey:@"titleHeight"];
}

- (void)setBannerTitlePosition:(BannerTitlePosition)bannerTitlePosition {
    _bannerTitlePosition = bannerTitlePosition;
    [self setBannerViewValue:@(bannerTitlePosition) foKey:@"bannerTitlePosition"];
}

- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment {
    _titleTextAlignment = titleTextAlignment;
    [self setBannerViewValue:@(titleTextAlignment) foKey:@"titleTextAlignment"];
}

- (void)setBannerViewValue:(id)value foKey:(NSString *)key {
    
    if (_bannerView1 != nil) {
        [_bannerView1 setValue:value forKey:key];
    }
    if (_bannerView2 != nil) {
        [_bannerView2 setValue:value forKey:key];
    }
    if (_bannerView3 != nil) {
        [_bannerView3 setValue:value forKey:key];
    }
    
}

@end















