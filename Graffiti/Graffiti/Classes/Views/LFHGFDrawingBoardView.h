//
//  LFHGFDrawingBoardView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  涂鸦画板视图

#import <UIKit/UIKit.h>

@interface LFHGFDrawingBoardView : UIView

/* 要绘制的图片 */
@property (nonatomic, strong) UIImage *image;

/**
 清除所有路径
 */
- (void)clearDrawing;

/**
 撤销上一次绘制的路径
 */
- (void)backwardPath;

/**
 重绘上一次撤销的路径
 */
- (void)forwardPath;

/**
 保存图片
 */
- (void)saveDrawingAsPicture;

/**
 分享图片
 */
- (UIImage *)shareImage;

/**
 画笔
 */
- (void)drawWithPenColor:(NSString *)color Width:(CGFloat)width;

/**
 橡皮
 */
- (void)drawWithEraserWidth:(CGFloat)width;

/**
 设置路径宽度

 @param pathWidth 宽度值
 */
- (void)changePathWidth:(CGFloat)pathWidth;

/**
 设置路径颜色

 @param color 十六进制颜色
 */
- (void)changePathColor:(NSString *)color;

@end
