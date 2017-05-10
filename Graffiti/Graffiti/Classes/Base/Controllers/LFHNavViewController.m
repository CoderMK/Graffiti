//
//  LFHNavViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  自定义导航控制器

#import "LFHNavViewController.h"

@implementation LFHNavViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Navigation Controller
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 设置导航条背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_background"] forBarMetrics:UIBarMetricsDefault];
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    // 设置导航条背景颜色为透明色
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    return [super popViewControllerAnimated:animated];
}

#pragma mark - Setup
/**
 初始化设置
 */
- (void)setup {
    // 设置导航条为半透明
    self.navigationBar.translucent = YES;
    // 设置导航条背景颜色为透明色
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 去除导航条底部黑线
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 设置导航条 Title 、按钮文字等颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    // 禁用滑动返回手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

@end
