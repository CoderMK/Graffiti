//
//  LFHImagePickerViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHImagePickerViewController.h"

@interface LFHImagePickerViewController ()

@end

@implementation LFHImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    [self.navigationBar setTintColor:[UIColor blackColor]];
}

#pragma mark -
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
