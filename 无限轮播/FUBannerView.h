//
//  FUBannerView.h
//  无限轮播
//
//  Created by iphone18 on 16/6/3.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FUBannerDelegate <NSObject>

- (void)bannerViewClickPage:(NSUInteger)clickPage;

@end

@interface FUBannerView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectVw;

//数据源数组
@property (nonatomic,copy) NSArray *sourceArray;

//是否需要定时轮播

@property (nonatomic,assign) BOOL isTimer;

@property (nonatomic,assign) float time;

@property (nonatomic,weak) id<FUBannerDelegate> delegate;

@end
