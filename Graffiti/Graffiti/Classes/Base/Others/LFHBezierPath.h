//
//  LFHBezierPath.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  带有颜色属性的 BezierPath

#import <UIKit/UIKit.h>

@interface LFHBezierPath : UIBezierPath

/* 记录路径颜色 */
@property (nonatomic, strong) UIColor *color;

@end
