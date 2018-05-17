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

@interface BannerScrollView : UIView

@property (readonly, nonatomic, copy) NSArray<Banner *> *bannerArray;


- (instancetype)initWithBannerArray:(NSArray<Banner *> *)bannerArray;

@end
