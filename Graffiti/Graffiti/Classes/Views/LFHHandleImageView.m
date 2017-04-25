//
//  LFHHandleImageView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/25.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  图片操作视图

#import "LFHHandleImageView.h"
#import "LFHCustomTool.h"

@interface LFHHandleImageView () <UIGestureRecognizerDelegate>

/* 内容视图 */
@property (weak, nonatomic) IBOutlet UIView *contentView;

/* 图片视图 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation LFHHandleImageView

#pragma mark - getter/ setter
- (void)setDrawingImage:(UIImage *)drawingImage {
    _drawingImage = drawingImage;
    // 设置 self.imageView 的图片显示模式
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = drawingImage;
}

#pragma mark - View
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupGesture];
}

/**
 添加手势
 */
- (void)setupGesture {
    // 打开imageView的交互
    self.imageView.userInteractionEnabled = YES;
    
    /********** 添加手势 **********/
    // 拖拽
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
    pan.delegate = self;
    
    // 旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.imageView addGestureRecognizer:rotation];
    rotation.delegate = self;
    
    // 捏合
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.imageView addGestureRecognizer:pinch];
    pinch.delegate = self;
    /******************************/
}

#pragma mark - Gesture Event
/**
 拖拽
 */
- (void)pan:(UIPanGestureRecognizer *)pan {
    // 设置transform
    CGPoint transP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y);
    // 复位
    [pan setTranslation:CGPointZero inView:pan.view];
}

/**
 旋转
 */
- (void)rotation:(UIRotationGestureRecognizer *)rotation {
    // 设置transform
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    // 复位
    [rotation setRotation:0];
}

/**
 缩放
 */
- (void)pinch:(UIPinchGestureRecognizer *)pinch {
    // 设置transform
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    // 复位
    [pinch setScale:1];
}

#pragma mark - Button Click
/**
 点击取消按钮后调用
 */
- (IBAction)cancelBtnClick:(UIButton *)sender {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(handleImageView:clickCancelBtn:)]) {
        [self.delegate handleImageView:self clickCancelBtn:sender];
    }
    // 从父控件中移除
    [self removeFromSuperview];
}

/**
 点击完成按钮后调用
 */
- (IBAction)finishBtnClick:(UIButton *)sender {
    // 将 Content View 绘制成 Image
    UIImage *drawingImage = [LFHCustomTool createImageWithView:self.contentView];
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(handleImageView:clickFinishedBtn:drawingImage:)]) {
        [self.delegate handleImageView:self clickFinishedBtn:sender drawingImage:drawingImage];
    }
    // 从父控件中移除
    [self removeFromSuperview];
}

#pragma mark - UIGestureRecognizerDelegate
/**
 同时支持多手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
