//
//  LFHBasicHandleView.h
//  Graffiti
//
//  Created by lifuheng on 2017/5/9.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFHBasicHandleView;

typedef NS_ENUM(NSInteger, LFHHandleViewDisplayPosition) {
    LFHHandleViewDisplayPositionCenter = 0, // 原始尺寸，在 Content View 中心显示
    LFHHandleViewDisplayPositionEqualContentView // 尺寸等同于 Content View
} NS_ENUM_AVAILABLE_IOS(8_0);

@protocol LFHBasicHandleViewDelegate <NSObject>

@optional
/**
 点击取消按钮后调用

 @param view Handle View
 */
- (void)handleViewDidCancel:(LFHBasicHandleView *)view;

/**
 点击完成按钮后调用
 
 @param view Handle View
 @param image 操作后重新绘制的图片
 */
- (void)handleView:(LFHBasicHandleView *)view didFinishWithDrawingImage:(UIImage *)image;

@end

@interface LFHBasicHandleView : UIView

/* 需要操作的图片 */
@property (nonatomic, weak) UIImage *handleImage;

/* 需要操作的文字 */
@property (nonatomic, weak) NSString *handleStr;

/* 代理属性 */
@property (nonatomic, weak) id <LFHBasicHandleViewDelegate> delegate;

/**
 自定义工厂方法创建实例对象
 */
+ (instancetype)handleView;

/**
 设置操作视图

 @param handleView Handle View
 @param handleViewDisplayPosition Handle View 显示位置
 */
- (void)setupHandleView:(UIView *)handleView displayPosition:(LFHHandleViewDisplayPosition)handleViewDisplayPosition;

@end
