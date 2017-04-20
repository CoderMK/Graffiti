//
//  LFHCustomTool.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/20.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

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

+ (UIImage *)createImageWithView:(UIView *)view {
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    // 2.获取位图上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 3.把当前handleImageView渲染到上下文中
    [view.layer renderInContext:ctx];
    // 4.从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
