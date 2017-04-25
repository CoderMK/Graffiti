//
//  LFHBezierPath.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  带有颜色属性的 BezierPath

#import "LFHBezierPath.h"

@implementation LFHBezierPath

#pragma mark - NSObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化设置
        [self setup];
    }
    return self;
}

#pragma mark - Setup
/**
 初始化设置
 */
- (void)setup {
    // 端点为圆角
    self.lineCapStyle = kCGLineCapRound;
    // 线连接处为圆角
    self.lineJoinStyle = kCGLineJoinRound;
}

@end
