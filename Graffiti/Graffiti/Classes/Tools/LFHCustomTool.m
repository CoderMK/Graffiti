//
//  LFHCustomTool.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/20.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  自定义工具类

#define MAX_STRING_WIDTH 300
#define MAX_STRING_HEIGHT 600

#import "LFHCustomTool.h"

@implementation LFHCustomTool

//static LFHToolDrawViewToImage *_instance = nil;
//
//+ (instancetype)shareToolDrawViewToImage {
//    return [[self alloc] init];
//}
//
//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (_instance == nil) {
//            _instance = [super allocWithZone:zone];
//        }
//    });
//    return _instance;
//}

/**
 将 UIView 绘制成 UIImage
 */
+ (UIImage *)createImageWithView:(UIView *)view {
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    // 2.获取位图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 3.把 view.layer 渲染到上下文中
    [view.layer renderInContext:ctx];
    // 4.从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    // 6.返回图片
    return image;
}

/**
 将 NSString 绘制成 UIImage

 @param str 字符串
 @param attrDict 富文本属性
 @return 绘制后的图片
 */
+ (UIImage *)createImageWithString:(NSString *)str attribute:(NSDictionary *)attrDict {
    /********** 计算字符串尺寸 **********/
    // 1.设置最大尺寸
    CGSize maxSize = CGSizeMake(MAX_STRING_WIDTH, MAX_STRING_HEIGHT);
    // 2.计算字符串尺寸矩形框
    CGRect rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrDict context:nil];
    /******************************/
    
    /********** 创建 UILabel **********/
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:30];
    label.text = str;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.bounds = CGRectMake(0, 0, ceil(rect.size.width), ceilf(rect.size.height));
    /******************************/
    
    /**********  将 UILabel 绘制成 UIImage **********/
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, 0);
    // 2.获取位图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 3.把 label.layer 渲染到上下文中
    [label.layer renderInContext:ctx];
    // 4.从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    /******************************/
    
    // 返回图片
    return image;
}

/**
 根据文字尺寸创建合适尺寸的label
 
 @param str 文本字符串
 @param attrDict 富文本属性
 @return 创建的 Label
 */
+ (UILabel *)createLabelWithString:(NSString *)str attribute:(NSDictionary *)attrDict {
    /********** 计算字符串尺寸 **********/
    // 1.设置最大尺寸
    CGSize maxSize = CGSizeMake(MAX_STRING_WIDTH, MAX_STRING_HEIGHT);
    // 2.计算字符串尺寸矩形框
    CGRect rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrDict context:nil];
    /******************************/
    
    /********** 创建 UILabel **********/
    UILabel *label = [[UILabel alloc] init];
    label.font = attrDict[NSFontAttributeName];
    label.text = str;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.bounds = CGRectMake(0, 0, ceil(rect.size.width), ceilf(rect.size.height));
    /******************************/
    
    // 返回 UILabel
    return label;
}

@end
