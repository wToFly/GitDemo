//
//  BannerScrollView.h
//  GitDemo
//
//  Created by admin on 2018/5/17.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Banner : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageURLStr;

@end

typedef NS_ENUM(NSInteger, BannerTitlePosition) {
    BannerTitlePositionBottom = 0,
    BannerTitlePositionTop,
};

@protocol BannerScrollViewDelegate <NSObject>

@optional
- (void)bannerScrollViewDidSelectItemAtIndex:(NSInteger)index;

@end

@interface BannerScrollView : UIView

@property (nonatomic, weak) id<BannerScrollViewDelegate> delegate;

@property (nonatomic, copy) NSArray<Banner *> *bannerArray;
@property (nonatomic, strong) UIColor *currentPageDotColor;
@property (nonatomic, strong) UIColor *pageDotColor;

@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIFont *titleTextFont;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) BannerTitlePosition bannerTitlePosition;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;

@property (nonatomic, assign) BOOL autoScroll;
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

@end
