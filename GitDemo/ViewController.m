//
//  ViewController.m
//  GitDemo
//
//  Created by admin on 2018/5/16.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate> {
    
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIPageControl *_pageControl;
    
    UIImageView *_singlePageImageView;
    
    UIImageView *_imageView1;
    UIImageView *_imageView2;
    UIImageView *_imageView3;
    NSInteger _currentPage;
    
    
}

@end

static const NSInteger pageCount = 2;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageControl.numberOfPages = pageCount;
    _pageControl.currentPage = 0;
    _currentPage = 0;
    
    if (pageCount > 0) {
        
        if (pageCount == 1) {
            
            _singlePageImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%ld", pageCount - 1]]];
            _singlePageImageView.translatesAutoresizingMaskIntoConstraints = NO;
            [_scrollView addSubview:_singlePageImageView];
            NSMutableArray *layoutArray = [NSMutableArray array];
            
            [layoutArray addObject:[NSLayoutConstraint constraintWithItem:_singlePageImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [layoutArray addObject:[NSLayoutConstraint constraintWithItem:_singlePageImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            [layoutArray addObject:[NSLayoutConstraint constraintWithItem:_singlePageImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
            [layoutArray addObject:[NSLayoutConstraint constraintWithItem:_singlePageImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
            [layoutArray addObject:[NSLayoutConstraint constraintWithItem:_singlePageImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            [layoutArray addObject:[NSLayoutConstraint constraintWithItem:_singlePageImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
            [_scrollView addConstraints:layoutArray];
            
        } else {
            
            _imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%ld", pageCount - 1]]];
            _imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image0"]];
            _imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image1"]];
            _imageView1.translatesAutoresizingMaskIntoConstraints = NO;
            _imageView2.translatesAutoresizingMaskIntoConstraints = NO;
            _imageView3.translatesAutoresizingMaskIntoConstraints = NO;
            [_scrollView addSubview:_imageView1];
            [_scrollView addSubview:_imageView2];
            [_scrollView addSubview:_imageView3];
            
            NSMutableArray *layoutArray1 = [NSMutableArray array];
            
            [layoutArray1 addObject:[NSLayoutConstraint constraintWithItem:_imageView1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [layoutArray1 addObject:[NSLayoutConstraint constraintWithItem:_imageView1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            [layoutArray1 addObject:[NSLayoutConstraint constraintWithItem:_imageView1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
            [layoutArray1 addObject:[NSLayoutConstraint constraintWithItem:_imageView1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
            [layoutArray1 addObject:[NSLayoutConstraint constraintWithItem:_imageView1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            [_scrollView addConstraints:layoutArray1];
            
            NSMutableArray *layoutArray2 = [NSMutableArray array];
            
            [layoutArray2 addObject:[NSLayoutConstraint constraintWithItem:_imageView2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [layoutArray2 addObject:[NSLayoutConstraint constraintWithItem:_imageView2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            [layoutArray2 addObject:[NSLayoutConstraint constraintWithItem:_imageView2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
            [layoutArray2 addObject:[NSLayoutConstraint constraintWithItem:_imageView2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_imageView1 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
            [_scrollView addConstraints:layoutArray2];
            
            NSMutableArray *layoutArray3 = [NSMutableArray array];
            
            [layoutArray3 addObject:[NSLayoutConstraint constraintWithItem:_imageView3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
            [layoutArray3 addObject:[NSLayoutConstraint constraintWithItem:_imageView3 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
            [layoutArray3 addObject:[NSLayoutConstraint constraintWithItem:_imageView3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
            [layoutArray3 addObject:[NSLayoutConstraint constraintWithItem:_imageView3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_imageView2 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
            [layoutArray3 addObject:[NSLayoutConstraint constraintWithItem:_imageView3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
            [_scrollView addConstraints:layoutArray3];
            
            
//            NSInteger count = pageCount + 2;
//            UIView *lastView = nil;
//            for (int i = 0; i < count; i++) {
//
//                NSString *imageStr = @"";
//                if (i == 0) {
//                    imageStr = [NSString stringWithFormat:@"image%ld", pageCount - 1];
//                } else if (i == count - 1) {
//                    imageStr = @"image0";
//                } else {
//                    imageStr = [NSString stringWithFormat:@"image%d", i - 1];
//                }
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageStr]];
//                [_scrollView addSubview:imageView];
//                imageView.translatesAutoresizingMaskIntoConstraints = NO;
//
//                NSMutableArray *layoutArray = [NSMutableArray array];
//
//                [layoutArray addObject:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//                [layoutArray addObject:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
//                [layoutArray addObject:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
//                if (i == 0) {
//                    [layoutArray addObject:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
//                    [layoutArray addObject:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//                } else {
//                    [layoutArray addObject:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
//                }
//                if (i == count - 1) {
//                    [layoutArray addObject:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
//                }
//                [_scrollView addConstraints:layoutArray];
//
//                lastView = imageView;
//
//            }
            [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0)];
            
        }
        
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog(@"%f", scrollView.contentOffset.x);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
//    NSInteger count = pageCount + 2;
    CGFloat sw = scrollView.bounds.size.width;
    NSUInteger page = (NSUInteger)scrollView.contentOffset.x / sw;
    NSLog(@"page:%lu", (unsigned long)page);
//    if (page == 0) {
//        _pageControl.currentPage = count - 2;
//        [scrollView setContentOffset:CGPointMake((_pageControl.currentPage + 1) * sw, 0)];
//    } else if (page == (count - 1)) {
//        _pageControl.currentPage = 0;
//        [scrollView setContentOffset:CGPointMake((_pageControl.currentPage + 1) * sw, 0)];
//    } else {
//        _pageControl.currentPage = page - 1;
//    }
    
    if (pageCount != 1 && page != 1) {
        
        if (page == 0) {
            _currentPage = _currentPage - 1;
            if (_currentPage < 0) {
                _currentPage = pageCount - 1;
            }
        } else if (page == 2) {
            _currentPage = _currentPage + 1;
            if (_currentPage > pageCount - 1) {
                _currentPage = 0;
            }
        }
        if (_currentPage == 0) {
            _imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld", pageCount - 1]];
            _imageView3.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld", (long)_currentPage + 1]];
        } else if (_currentPage == pageCount - 1) {
            _imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld", (long)_currentPage - 1]];
            _imageView3.image = [UIImage imageNamed:@"image0"];
        } else {
            _imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld", (long)_currentPage - 1]];
            _imageView3.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld", (long)_currentPage + 1]];
        }
        _imageView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld", (long)_currentPage]];
        _pageControl.currentPage = _currentPage;
        [scrollView setContentOffset:CGPointMake(sw, 0)];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
