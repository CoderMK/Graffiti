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

/**
 将 NSString 绘制成 UIImage

 @param str 字符串
 @param attrDict 富文本属性
 @return 绘制后的图片
 */
+ (UIImage *)createImageWithString:(NSString *)str attribute:(NSDictionary *)attrDict;

/**
 根据文字尺寸创建合适尺寸的label

 @param str 文本字符串
 @param attrDict 富文本属性
 @return 创建的 Label
 */
+ (UILabel *)createLabelWithString:(NSString *)str attribute:(NSDictionary *)attrDict;

@end
