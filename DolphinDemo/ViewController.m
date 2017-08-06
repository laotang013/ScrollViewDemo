//
//  ViewController.m
//  DolphinDemo
//
//  Created by Start on 2017/8/3.
//  Copyright © 2017年 het. All rights reserved.
//
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "SleepPlanDisCoverView.h"
@interface ViewController ()
/**头部滚动View*/
@property(nonatomic,strong)SleepPlanDisCoverView *headView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.headView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - **************** 懒加载
-(SleepPlanDisCoverView *)headView
{
    if (!_headView) {
        _headView = [[SleepPlanDisCoverView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    }
    return _headView;
}

@end
