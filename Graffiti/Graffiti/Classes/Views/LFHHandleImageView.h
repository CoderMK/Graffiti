//
//  LFHHandleImageView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/25.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  图片操作视图

#import <UIKit/UIKit.h>
@class LFHHandleImageView;

@protocol LFHHandleImageViewDelegate <NSObject>

@required
/**
 点击取消按钮后调用
 */
- (void)handleImageView:(LFHHandleImageView *)view clickCancelBtn:(UIButton *)sender;

/**
 点击完成按钮后调用
 
 @param image 根据 self.contentView 画成的 UIImgae
 */
- (void)handleImageView:(LFHHandleImageView *)view clickFinishedBtn:(UIButton *)sender drawingImage:(UIImage *)image;

@end

@interface LFHHandleImageView : UIView

/** 要绘制的图片 */
@property (nonatomic, strong) UIImage *drawingImage;

/* 代理属性 */
@property (nonatomic, weak) id <LFHHandleImageViewDelegate> delegate;

@end
