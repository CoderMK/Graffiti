//
//  LFHCustomTool.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/20.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  自定义工具类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LFHCustomTool : NSObject

///**
// 单例创建实例对象
// */
//+ (instancetype)shareToolDrawViewToImage;

/**
 将 UIView 绘制成 UIImage
 */
+ (UIImage *)createImageWithView:(UIView *)view;

@end
