//
//  LFHColorBtn.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/19.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  颜色按钮

#import <UIKit/UIKit.h>
#import "LFHColorBtnItem.h"

@interface LFHColorBtn : UIButton

/* 颜色按钮模型 */
@property (nonatomic, strong) LFHColorBtnItem *colorBtnItem;

/**
 工厂方法创建按钮

 @param item 按钮模型
 */
+ (instancetype)colorBtnWithItem:(LFHColorBtnItem *)item;

@end
