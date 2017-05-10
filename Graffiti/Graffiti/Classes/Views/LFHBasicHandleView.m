//
//  LFHBasicHandleView.m
//  Graffiti
//
//  Created by lifuheng on 2017/5/9.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHBasicHandleView.h"
#import "LFHCustomTool.h"

@interface LFHBasicHandleView () <UIGestureRecognizerDelegate>

/* 内容视图 */
@property (weak, nonatomic) IBOutlet UIView *contentView;

/* 操作视图 */
@property (nonatomic, weak) UIView *handleView;

@end

@implementation LFHBasicHandleView

#pragma mark - Setup
/**
 自定义工厂方法创建 Basic Handle View
 
 @return Basic Handle View
 */
+ (instancetype)handleView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

/**
 添加手势
 */
- (void)setupGesture {
    // 打开 Handle Label 的交互开关
    self.handleView.userInteractionEnabled = YES;
    
    /********** 添加手势 **********/
    // 拖拽
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.handleView addGestureRecognizer:pan];
    pan.delegate = self;
    
    // 旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.handleView addGestureRecognizer:rotation];
    rotation.delegate = self;
    
    // 捏合
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.handleView addGestureRecognizer:pinch];
    pinch.delegate = self;
    /******************************/
}

/**
 设置操作视图
 
 @param handleView Handle View
 @param handleViewDisplayPosition Handle View 显示位置
 */
- (void)setupHandleView:(UIView *)handleView displayPosition:(LFHHandleViewDisplayPosition)handleViewDisplayPosition {
    self.handleView = handleView;
    handleView.backgroundColor = [UIColor clearColor];
    if (handleViewDisplayPosition == LFHHandleViewDisplayPositionCenter) {
        handleView.center = self.contentView.center;
    } else {
        handleView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    }
    [self.contentView addSubview:handleView];
    [self setupGesture];
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
    if ([self.delegate respondsToSelector:@selector(handleViewDidCancel:)]) {
        [self.delegate handleViewDidCancel:self];
    }
}

/**
 点击完成按钮后调用
 */
- (IBAction)finishBtnClick:(UIButton *)sender {
    // 将 Content View 绘制成 UIImage
    UIImage *image = [LFHCustomTool createImageWithView:self.contentView];
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(handleView:didFinishWithDrawingImage:)]) {
        [self.delegate handleView:self didFinishWithDrawingImage:image];
    }
}

#pragma mark - UIGestureRecognizerDelegate
/**
 设置多手势事件同时存在
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
