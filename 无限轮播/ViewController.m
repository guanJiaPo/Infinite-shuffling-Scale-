//
//  ViewController.m
//  无限轮播
//
//  Created by iphone18 on 16/6/3.
//  Copyright © 2016年 apple18. All rights reserved.
//sdfsdf

#import "ViewController.h"

#import "FUBannerView.h"

@interface ViewController ()<FUBannerDelegate>
{
    FUBannerView *bannerView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bannerView = [[FUBannerView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    
     bannerView.sourceArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];

    
    [self.tableView addSubview:bannerView];
    
    //给tableView设置一个跟轮播图同样高的表头，避免cell显示在轮播图上面
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 200)];
    
    view.userInteractionEnabled = NO;
    
    self.tableView.tableHeaderView = view;
    
    bannerView.isTimer = YES;
    
    bannerView.delegate = self;
    
    
}

- (void)bannerViewClickPage:(NSUInteger)clickPage{
    
    NSLog(@"%ld",(unsigned long)clickPage);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y<0) {
        
        CGRect initFrame = bannerView.frame;
        
        initFrame.origin.y = scrollView.contentOffset.y;
        
        initFrame.size.height = 150-scrollView.contentOffset.y;
        
        bannerView.frame = initFrame;
    }
}

@end
