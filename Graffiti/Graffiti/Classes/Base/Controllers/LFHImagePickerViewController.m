//
//  LFHImagePickerViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  图片选择控制器

#import "LFHImagePickerViewController.h"

@interface LFHImagePickerViewController ()

@end

@implementation LFHImagePickerViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
/**
 初始化导航条
 */
- (void)setupNavigationBar {
    [self.navigationBar setTintColor:[UIColor blackColor]];
}

#pragma mark - 设置导航条
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
