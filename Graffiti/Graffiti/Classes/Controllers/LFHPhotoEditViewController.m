//
//  LFHPhotoEditViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHPhotoEditViewController.h"

@interface LFHPhotoEditViewController ()

@end

@implementation LFHPhotoEditViewController

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
    // 添加 BarButtonItem
    // 撤销按钮
    UIBarButtonItem *backwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backward"] style:UIBarButtonItemStylePlain target:self action:@selector(backwardBtnClick)];
    // 前进按钮
    UIBarButtonItem *forwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardBtnClick)];
    // 还原按钮
    UIBarButtonItem *resetBtn = [[UIBarButtonItem alloc] initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(resetBtnClick)];
    // 保存/分享按钮
    UIBarButtonItem *saveOrShareBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存/分享" style:UIBarButtonItemStylePlain target:self action:@selector(saveOrShareBtnClick)];
    
    // 打包添加到 NavigationItem
    NSArray *barButtonItemArray = @[saveOrShareBtn, resetBtn, forwardBtn, backwardBtn];
    self.navigationItem.rightBarButtonItems = barButtonItemArray;
}

/**
 初始化UI布局
 */
- (void)setupUI {
    self.view.backgroundColor = [UIColor blueColor];
}

#pragma mark - Button Click
- (void)backwardBtnClick {
    
}
- (void)forwardBtnClick {
    
}

- (void)resetBtnClick {
    
}
- (void)saveOrShareBtnClick {
    
}

#pragma mark -
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
