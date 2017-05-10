//
//  LFHExpressionBtn.m
//  Graffiti
//
//  Created by lifuheng on 2017/5/8.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  表情按钮

#import "LFHExpressionBtn.h"
#import "LFHExpressionBtnItem.h"

@implementation LFHExpressionBtn

/**
 创建按钮时就设置好按钮的图片并取消高亮状态操作

 @param item 按钮模型
 */
+ (instancetype)expressionBtnWithItem:(LFHExpressionBtnItem *)item {
    LFHExpressionBtn *btn =[LFHExpressionBtn buttonWithType:UIButtonTypeCustom];
    btn.expressionBtnItem =item;
    btn.adjustsImageWhenHighlighted = NO;
    [btn setImage:[UIImage imageNamed:item.imageName] forState:UIControlStateNormal];
    return btn;
}

@end
