//
//  LFHColorBtn.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/19.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  颜色按钮

#import "LFHColorBtn.h"

@implementation LFHColorBtn

/**
 创建按钮时就设置好按钮在正常状态和选中状态下的图片

 @param item 按钮模型
 */
+ (instancetype)colorBtnWithItem:(LFHColorBtnItem *)item {
    LFHColorBtn *btn = [LFHColorBtn buttonWithType:UIButtonTypeCustom];
    btn.colorBtnItem = item;
    [btn setImage:[UIImage imageNamed:item.normalImageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:item.selectedImageName] forState:UIControlStateSelected];

    return btn;
}

@end
