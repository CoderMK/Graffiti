//
//  LFHGFHandleImageView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFHGFHandleImageView;

@protocol LFHGFHandleImageViewDelegate <NSObject>

@required

/* 监听取消按钮点击 */
- (void)handleImageView:(LFHGFHandleImageView *)view clickCancelBtn:(UIButton *)sender;


/* 监听完成按钮点击 */
- (void)handleImageView:(LFHGFHandleImageView *)view clickFinishedBtnWithNewImage:(UIImage *)image;

@end

@interface LFHGFHandleImageView : UIView

/** 要显示的图片 */
@property (nonatomic, strong) UIImage *image;

/* 代理属性 */
@property (nonatomic, assign) id <LFHGFHandleImageViewDelegate> delegate;

@end
