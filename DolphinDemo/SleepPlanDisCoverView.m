//
//  SleepPlanDisCoverView.m
//  DolphinDemo
//
//  Created by Start on 2017/8/3.
//  Copyright © 2017年 het. All rights reserved.
//

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//图片间距
#define imageSpacingWidth 14
#define imageWidth ScreenWidth/2

#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
// 如果你想在使用equalTo的时候让它也带有自动装箱功能请定义下面这个宏
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "SleepPlanDisCoverView.h"
@interface SleepPlanDisCoverView()<UIScrollViewDelegate>
/**背景View*/
@property(nonatomic,strong)UIImageView *bgIamgeView;
/**Scrllovew*/
@property(nonatomic,strong)UIScrollView *scrollView;
/**数据集合*/
@property(nonatomic,strong)NSArray *dataArray;


@end
@implementation SleepPlanDisCoverView
/*
 * 0.添加一个背景View
 * 1.定义一个ScrollView
 *  1.1 添加ImageView
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews
{
    [self setData];
    [self addSubview:self.bgIamgeView];
    [self addSubview:self.scrollView];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    //设置imageView
    [self setImageView];
}

#pragma mark - **************** method
-(void)setData
{
    self.dataArray = @[@"dolphinShare_4.jpg",
                       @"dolphinShare_1.jpg",
                       @"dolphinShare_2.jpg",
                       @"dolphinShare_3.jpg",
                       @"dolphinShare_4.jpg",
                       @"dolphinShare_1.jpg",];
    
    
}
//添加ImageView
-(void)setImageView
{
    
    for(int i=0;i<self.dataArray.count;i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageWidth*i, 0, imageWidth, self.bounds.size.height)];
        imageView.image = [UIImage imageNamed:self.dataArray[i]];
        [self.scrollView addSubview:imageView];
    }
    
    //设置偏移
    [self.scrollView setContentOffset:CGPointMake(imageWidth/2, 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint contentOffset = scrollView.contentOffset;
//    NSInteger offsetIndex = contentOffset.x / imageWidth;
//    NSLog(@"offsetIndex %ld",(long)offsetIndex);
//    NSLog(@"contentOffset.x %f",contentOffset.x);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
 
    
    NSInteger imageWidtht = scrollView.bounds.size.width/4;
    CGPoint contentOffset = scrollView.contentOffset;
    NSInteger offsetIndex = contentOffset.x / (imageWidtht + (scrollView.bounds.size.width/2));
    NSLog(@"offsetIndex %ld",(long)offsetIndex);
    NSLog(@"contentOffset.x %f",contentOffset.x);
    
    //无限轮播
    //1.判断是否是第一个和最后一个
    if (offsetIndex == 3) {
        [self.scrollView setContentOffset:CGPointMake(0*((scrollView.bounds.size.width/2))+imageWidtht,0) animated:NO];
        return;
    }
    else if (offsetIndex == 0) {
        [self.scrollView setContentOffset:CGPointMake(3*((scrollView.bounds.size.width/2))+imageWidtht,0) animated:NO];
        return;
    }
    
    if (contentOffset.x >= offsetIndex*((scrollView.bounds.size.width/2))+imageWidtht) {
        [self.scrollView setContentOffset:CGPointMake(offsetIndex*((scrollView.bounds.size.width/2))+imageWidtht,0) animated:YES];
    }else
    {
        if (offsetIndex == 0 && contentOffset.x < imageWidtht) {
            [self.scrollView setContentOffset:CGPointMake(imageWidtht, 0) animated:YES];
            return;
        }
        [self.scrollView setContentOffset:CGPointMake((offsetIndex-1)*((scrollView.bounds.size.width/2))+imageWidtht, 0) animated:YES];
    }
}
//判断偏移量
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger imageWidtht = scrollView.bounds.size.width/4;
    CGPoint contentOffset = scrollView.contentOffset;
    NSInteger offsetIndex = contentOffset.x / (imageWidtht + (scrollView.bounds.size.width/2));
    NSLog(@"offsetIndex %ld",(long)offsetIndex);
    NSLog(@"contentOffset.x %f",contentOffset.x);
    
    //无限轮播
    //1.判断是否是第一个和最后一个
    if (offsetIndex == 3) {
        [self.scrollView setContentOffset:CGPointMake(0*((scrollView.bounds.size.width/2))+imageWidtht,0) animated:NO];
        return;
    }else if (offsetIndex == 0) {
        [self.scrollView setContentOffset:CGPointMake(3*((scrollView.bounds.size.width/2))+imageWidtht,0) animated:NO];
        return;
    }
    
    if (contentOffset.x >= offsetIndex*((scrollView.bounds.size.width/2))+imageWidtht) {
        [self.scrollView setContentOffset:CGPointMake(offsetIndex*((scrollView.bounds.size.width/2))+imageWidtht,0) animated:YES];
    }else
    {
        if (offsetIndex == 0 && contentOffset.x < imageWidtht) {
           [self.scrollView setContentOffset:CGPointMake(imageWidtht, 0) animated:YES];
            return;
        }
        [self.scrollView setContentOffset:CGPointMake((offsetIndex-1)*((scrollView.bounds.size.width/2))+imageWidtht, 0) animated:YES];
    }
   
   
}



#pragma mark - **************** setter & getter
-(UIImageView *)bgIamgeView
{
    if (!_bgIamgeView) {
        _bgIamgeView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgIamgeView.image = [UIImage imageNamed:@"dolphinMainBack.jpg"];
    }
    return _bgIamgeView;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(imageWidth *7, 0);
    }
    return _scrollView;
}
@end
