//
//  FUBannerView.m
//  无限轮播
//
//  Created by iphone18 on 16/6/3.
//  Copyright © 2016年 apple18. All rights reserved.
//

#import "FUBannerView.h"

@interface FUBannerView ()
{
    UIPageControl *pageCl;
    
    NSTimer *timer;
    
    UICollectionViewFlowLayout *flowLayout;
}

@end

@implementation FUBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setCollectView:frame];
        
        pageCl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-20,frame.size.width , 20)];
        
        pageCl.backgroundColor = [UIColor clearColor];
        
        [self addSubview:pageCl];
    }
    
    return self;
}

- (void)setCollectView:(CGRect)frame{
    
    flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectVw = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    
    _collectVw.dataSource = self;
    
    _collectVw.delegate = self;
    
    //分页
    _collectVw.pagingEnabled = YES;
    
    [self addSubview:_collectVw];
    
    
    flowLayout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    
    [_collectVw registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:@"id"];
    
    _collectVw.showsHorizontalScrollIndicator = NO;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    
    [_collectVw addGestureRecognizer:tap];
}

-(void)tap{
    
    if ([self.delegate respondsToSelector:@selector(bannerViewClickPage:)]) {
        
        [self.delegate bannerViewClickPage:pageCl.currentPage];
        
    }
}

#pragma mark delegate dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 100;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _sourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    
    imageView.image = [UIImage imageNamed:_sourceArray[indexPath.item]];

    
   // pageCl.currentPage = indexPath.item;
    
    cell.backgroundView = imageView;
    
    
    return cell;
}

- (void)setSourceArray:(NSArray *)sourceArray{
    
    _sourceArray = sourceArray;
    
    pageCl.numberOfPages = sourceArray.count;
    
    
    //直接跳到第n段
    [_collectVw scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:100/2] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    [_collectVw reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
     int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width + 0.5)%self.sourceArray.count;
    
    pageCl.currentPage = page;
}

- (void)setIsTimer:(BOOL)isTimer{
    
    _isTimer = isTimer;
    
    if (isTimer) {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updatePage) userInfo:nil repeats:YES];
    }
    
}

- (void)updatePage{
    
    //获取当前显示内容的段和行
    NSIndexPath *currentIndexPath = [[_collectVw indexPathsForVisibleItems] lastObject];
    
    
    NSIndexPath *currentIndexResent = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:100/2];
    
    [_collectVw scrollToItemAtIndexPath:currentIndexResent atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
  
    
    NSInteger currentItem = currentIndexPath.item;
    
    currentItem++;
    
    NSInteger nextItem = currentItem ;
    
     NSInteger nextSection = currentIndexResent.section;
    
    if (nextItem == self.sourceArray.count) {
        
        nextSection++;
        
        nextItem = 0;
    }
    
    //跳转下一个cell
    [_collectVw scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    timer.fireDate = [NSDate distantFuture];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
}

- (void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    _collectVw.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    flowLayout.itemSize = frame.size;
    
    pageCl.frame = CGRectMake(0, frame.size.height-20, frame.size.width, 20);
    
    [_collectVw reloadData];
}

- (void)dealloc{
    
    [timer invalidate];
    
    timer = nil;
}

@end
