//
//  LFHGFHandleImageView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHGFHandleImageView.h"
#import "LFHCustomTool.h"
#import <Masonry.h>

@interface LFHGFHandleImageView () <UIGestureRecognizerDelegate>

/* 头部工具栏 */
@property (nonatomic, weak) UIView *topToolsView;

/* 内容视图 */
@property (nonatomic, weak) UIView *contentView;

/* 图片视图 */
@property (nonatomic, weak) UIImageView *imageView;

/* 取消按钮 */
@property (nonatomic, weak) UIButton *cancelBtn;

/* 完成按钮 */
@property (nonatomic, weak) UIButton *finishedBtn;

@end

@implementation LFHGFHandleImageView

#pragma mark - getter/ setter
- (void)setImage:(UIImage *)image {
    _image = image;
    // 设置 self.imageView 的图片显示模式
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = image;
}

#pragma mark - View
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
        [self setupGesture];
    }
    return self;
}

/**
 布局子控件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 添加约束
    __weak __typeof(self)weakSelf = self;
    [self.topToolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.mas_equalTo(44);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf.topToolsView);
        make.width.equalTo(weakSelf.finishedBtn);
    }];
    [self.finishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(weakSelf.topToolsView);
        make.left.equalTo(weakSelf.cancelBtn.mas_right);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf);
        make.top.equalTo(weakSelf.topToolsView.mas_bottom);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(weakSelf.contentView);
    }];
}

#pragma mark - setup
/**
 添加子控件
 */
- (void)setupSubviews {
    // 头部工具栏
    UIView *topToolsView = [[UIView alloc] init];
    topToolsView.backgroundColor = [UIColor darkGrayColor];
    self.topToolsView = topToolsView;
    [self addSubview:topToolsView];
    
    // 取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.tintColor = [UIColor blackColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn = cancelBtn;
    [topToolsView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 完成按钮
    UIButton *finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishedBtn.tintColor = [UIColor greenColor];
    [finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.finishedBtn = finishedBtn;
    [topToolsView addSubview:finishedBtn];
    [finishedBtn addTarget:self action:@selector(finishedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 内容视图
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    self.contentView = contentView;
    [self addSubview:contentView];
    
    // 图片视图
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [contentView addSubview:imageView];
}

/**
 添加手势
 */
- (void)setupGesture {
    // 打开imageView的交互
    self.imageView.userInteractionEnabled = YES;
    
    /********** 添加手势 **********/
    /* 拖拽 */
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
    pan.delegate = self;
    
    /* 旋转 */
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.imageView addGestureRecognizer:rotation];
    rotation.delegate = self;
    
    /* 捏合 */
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
- (void)cancelBtnClick:(UIButton *)sender {
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
- (void)finishedBtnClick:(UIButton *)sender {
    // 将 Content View 绘制成 Image
    UIImage *image = [LFHCustomTool createImageWithView:self.contentView];
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(handleImageView:clickFinishedBtnWithNewImage:)]) {
        [self.delegate handleImageView:self clickFinishedBtnWithNewImage:image];
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
