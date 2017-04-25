//
//  LFHColorBtnItem.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/19.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  颜色按钮模型

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LFHColorBtnItem : NSObject

/* 按钮正常状态图片名称 */
@property (nonatomic, copy) NSString *normalImageName;

/* 按钮选中状态图片名称 */
@property (nonatomic, copy) NSString *selectedImageName;

/* 按钮对应颜色 */
@property (nonatomic, copy) NSString *color;

@end
