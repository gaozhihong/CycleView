//
//  CycleView.m
//  CycleView
//
//  Created by apple on 2018/11/2.
//  Copyright © 2018 HYR. All rights reserved.
//

#import "CycleView.h"
#define KSection_Num 100
#define Random_colors [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1.0]

@interface  CycleView() <UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSTimer *timer;//timer
@property(nonatomic,strong)NSArray *dataList;
@property(nonatomic,strong)UIPageControl *pageControl;

@end
static NSString *const reuseIdentifier = @"reuseIdentifier";
@implementation CycleView
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(instancetype)initCycleViewWithListArray:(NSArray<NSString *> *)array frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.dataList = [array copy];
        [self addSubview:self.collectionView];
        [self initPageControlWithNumber:array.count];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:KSection_Num/2] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
        [self addTimer];
        
    }
    return self;
}
#pragma mark  -- Timer
-(void)addTimer{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}
-(void)nextImage{
    NSIndexPath *currentIndexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:KSection_Num/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.dataList.count) {
        nextItem = 0;
        nextSection ++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
}
-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark  -- Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return KSection_Num;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CycleTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = Random_colors;
    NSString *imgStr = self.dataList[indexPath.item];
    cell.imgUrl = imgStr;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cycleViewDidSelected) {
        self.cycleViewDidSelected(indexPath.item);
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = (NSInteger)(scrollView.contentOffset.x /scrollView.bounds.size.width +0.5) %self.dataList.count;
    self.pageControl.currentPage = currentPage;
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

#pragma mark  -- LAZY
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor =[UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [_collectionView registerClass:[CycleTabCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}
-(void)initPageControlWithNumber:(NSInteger)num{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = num;
        CGFloat pageW = 120,pageH = 40;
        _pageControl.frame = CGRectMake((self.bounds.size.width-pageW)/2.0, self.bounds.size.height-pageH-10, pageW,pageH );
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
    }
}
@end


@interface CycleTabCell()
@property(nonatomic,strong)UIImageView *imgView;

@end

@implementation CycleTabCell
-(instancetype)init{
    if (self = [super init]) {
//        [self.contentView addSubview:self.imgView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         [self.contentView addSubview:self.imgView];
    }
    return self;
}
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView =[[UIImageView alloc] initWithFrame:self.contentView.bounds];
    }
    return _imgView;
}
-(void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
    _imgView.image = [UIImage imageWithData:imgData];
}
@end
