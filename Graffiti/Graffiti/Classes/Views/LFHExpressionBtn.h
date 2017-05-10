//
//  LFHExpressionBtn.h
//  Graffiti
//
//  Created by lifuheng on 2017/5/8.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  表情按钮

#import <UIKit/UIKit.h>
@class LFHExpressionBtnItem;

@interface LFHExpressionBtn : UIButton

/* 表情按钮模型 */
@property (nonatomic, strong) LFHExpressionBtnItem *expressionBtnItem;

/**
 工厂方法创建按钮
 
 @param item 按钮模型
 */
+ (instancetype)expressionBtnWithItem:(LFHExpressionBtnItem *)item;

@end
