//
//  LFHMainViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  主页控制器

#import "LFHMainViewController.h"
#import "LFHGraffitiBoardViewController.h"
#import "LFHPhotoEditViewController.h"
#import "LFHImagePickerViewController.h"
#import <Masonry.h>

@interface LFHMainViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation LFHMainViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    [self setupUI];
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
    
}

/**
 初始化UI布局
 */
- (void)setupUI {
    // 设置当前视图背景颜色
    self.view.backgroundColor = [UIColor darkGrayColor];
    // 添加涂鸦板按钮
    UIButton *graffityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    graffityBtn.backgroundColor = [UIColor redColor];
    [graffityBtn setTitle:@"涂鸦板" forState:UIControlStateNormal];
    [self.view addSubview:graffityBtn];
    __weak __typeof(self)weakSelf = self;
    // 添加约束
    [graffityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    // 添加点击事件
    [graffityBtn addTarget:self action:@selector(graffityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    /********** 暂时不开放此功能 **********
    // 添加图片编辑按钮
    UIButton *photoEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoEditBtn.backgroundColor = [UIColor greenColor];
    [photoEditBtn setTitle:@"图片编辑" forState:UIControlStateNormal];
    [self.view addSubview:photoEditBtn];
    // 添加约束
    [photoEditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(graffityBtn);
        make.centerY.mas_equalTo(graffityBtn).offset(30);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    // 添加点击事件
    [photoEditBtn addTarget:self action:@selector(photoEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
    ********************/
    
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

//- (void)photoEditBtnClick {
//    // 跳转到图片选择控制器(modal)
//    LFHImagePickerViewController *imagePickerVC = [[LFHImagePickerViewController alloc] init];
//    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePickerVC.delegate = self;
//    
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
//}

#pragma mark - UIImagePickerControllerDelegate
/**
 ImagePickerController 中点击图片后调用
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    LFHPhotoEditViewController *photoEditVC = [[LFHPhotoEditViewController alloc] init];
    photoEditVC.image = image;
    // 关闭 ImagePickerController
    [self dismissViewControllerAnimated:NO completion:^{
        // 跳转到 PhotoEditViewController
        [self.navigationController pushViewController:photoEditVC animated:YES];
    }];
}

#pragma mark - 设置导航条
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
