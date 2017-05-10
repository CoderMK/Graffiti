//
//  LFHMainViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  主页控制器

#import "LFHMainViewController.h"
#import "LFHGraffitiBoardViewController.h"
#import "LFHImagePickerViewController.h"
#import <Masonry.h>

@interface LFHMainViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation LFHMainViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

#pragma mark - Setup
/**
 初始化UI布局
 */
- (void)setupUI {
    // 设置当前视图背景颜色
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [self.view addSubview:imageV];
    imageV.frame = self.view.frame;
    imageV.image = [UIImage imageNamed:@"mainpage"];
    
    // 添加 提示文字
    UILabel *welcomeLabel = [[UILabel alloc] init];
    [self.view addSubview:welcomeLabel];
    welcomeLabel.textColor = [UIColor greenColor];
    welcomeLabel.font = [UIFont systemFontOfSize:30];
    welcomeLabel.text = @"点击下方按钮进入涂鸦画板";
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    [welcomeLabel sizeToFit];
    welcomeLabel.center = CGPointMake(self.view.bounds.size.width / 2, 250);
    
    // 添加涂鸦板按钮
    UIButton *graffityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:graffityBtn];
    [graffityBtn setImage:[UIImage imageNamed:@"colorboard"] forState:UIControlStateNormal];
    [graffityBtn sizeToFit];
    graffityBtn.center = self.view.center;
    
    // 添加点击事件
    [graffityBtn addTarget:self action:@selector(graffityBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button Click
/**
 点击涂鸦画板按钮后调用
 */
- (void)graffityBtnClick {
    // 跳转到涂鸦画板
    LFHGraffitiBoardViewController *graffiitiBoardVC = [[LFHGraffitiBoardViewController alloc] init];
    [self.navigationController pushViewController:graffiitiBoardVC animated:YES];
}

#pragma mark - 设置导航条
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
