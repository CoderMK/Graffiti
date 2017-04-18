//
//  LFHNavViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHNavViewController.h"

@interface LFHNavViewController ()

@end

@implementation LFHNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航条背景颜色为透明色
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 去除导航条底部黑线
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 设置导航条 Title 、按钮文字等颜色
    self.navigationBar.tintColor = [UIColor blackColor];
    // 禁用滑动返回手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
