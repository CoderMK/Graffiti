//
//  LFHGFHandleImageView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  图片操作视图

#import <UIKit/UIKit.h>
@class LFHGFHandleImageView;

@protocol LFHGFHandleImageViewDelegate <NSObject>

@required
/**
 点击取消按钮后调用

 @param view self
 @param sender cancelBtn
 */
- (void)handleImageView:(LFHGFHandleImageView *)view clickCancelBtn:(UIButton *)sender;

/**
 点击完成按钮后调用

 @param view self
 @param image 根据 self.contentView 画成的 UIImgae 
 */
- (void)handleImageView:(LFHGFHandleImageView *)view clickFinishedBtnWithNewImage:(UIImage *)image;

@end

@interface LFHGFHandleImageView : UIView

/** 要操作的图片 */
@property (nonatomic, strong) UIImage *image;

/* 代理属性 */
@property (nonatomic, weak) id <LFHGFHandleImageViewDelegate> delegate;

@end
