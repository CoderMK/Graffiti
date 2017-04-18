//
//  LFHGFDrawingBoardView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DrawBoardViewSaveType) {
    DrawBoardViewSaveTypeOnlySave = 0,
    DrawBoardViewSaveTypeOnlyShare,
    DrawBoardViewSaveTypeSaveAndShare
} NS_ENUM_AVAILABLE_IOS(8_0);

@interface LFHGFDrawingBoardView : UIView

/** 操作后的图片 */
@property (nonatomic, strong) UIImage *image;

/**
 清屏
 */
- (void)clearDrawing;

/**
 撤销
 */
- (void)backwardPath;

/**
 前进
 */
- (void)forwardPath;

/**
 保存图片
 */
- (void)saveDrawingAsPicture;

/**
 分享图片
 
 @return 要分享出去的图片
 */
- (UIImage *)shareImage;

/**
 画笔
 */
- (void)drawWithPen;

/**
 文字
 */
- (void)drawWithFont;

/**
 橡皮
 */
- (void)drawWithEraser;

/**
 改变线宽

 @param pathWidth 宽度值
 */
- (void)changePathWidth:(CGFloat)pathWidth;

/**
 改变颜色

 @param color 颜色
 */
- (void)changePathColor:(UIColor *)color;

@end
