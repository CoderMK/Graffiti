//
//  LFHTestViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/19.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  测试控制器

// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#import "LFHTestViewController.h"

#import "LFHTestView.h"
#import "LFHCustomTool.h"
#import "LFHExpressionScrollView.h"


@interface LFHTestViewController ()

/* sc */
@property (nonatomic, weak) UIScrollView *scView;

@end

@implementation LFHTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
//    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    aView.backgroundColor = UIColorFromRGB(0xff1493);
    
//    [self.view addSubview:aView];
//    LFHTestView *testView = [[LFHTestView alloc] init];
//    testView.frame = self.view.bounds;
//    [self.view addSubview:testView];
    
    [self setup];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setup {
    LFHExpressionScrollView *view1 = [[LFHExpressionScrollView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    view1.frame = CGRectMake(0, 100, self.view.bounds.size.width, 128);
    [self.view addSubview:view1];
}



@end
