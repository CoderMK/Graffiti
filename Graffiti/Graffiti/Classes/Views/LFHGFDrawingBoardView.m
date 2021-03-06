//
//  LFHGFDrawingBoardView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  涂鸦画板视图

#import "LFHGFDrawingBoardView.h"
#import "LFHBezierPath.h"
#import "LFHCustomTool.h"
#import "UIColor+LFHColor.h"
#import <MBProgressHUD.h>

@interface LFHGFDrawingBoardView ()

/** 当前绘制路径 */
@property (nonatomic, strong) LFHBezierPath *path;

/** 所有绘制路径 */
@property (nonatomic, strong) NSMutableArray *pathArray;

/** 撤销绘制路径 */
@property (nonatomic, strong) NSMutableArray *delPathArray;

/** 当前路径颜色 */
@property (nonatomic, strong) UIColor *pathColor;

/** 当前路径宽度 */
@property (nonatomic, assign) CGFloat pathWidth;

@end

@implementation LFHGFDrawingBoardView

#pragma mark - getter/ setter
- (NSMutableArray *)pathArray {
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

- (NSMutableArray *)delPathArray {
    if (_delPathArray == nil) {
        _delPathArray = [NSMutableArray array];
    }
    return _delPathArray;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    // 将 image 添加到 pathArray 并重绘
    [self.pathArray addObject:image];
    [self setNeedsDisplay];
}

#pragma mark - UIView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    for (LFHBezierPath *path in self.pathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        } else {
            [path.color set];
            [path stroke];
        }
    }
}

#pragma mark - Setup
/**
 初始化涂鸦板颜色
 */
- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Drawing Event
/**
 清除所有路径
 */
- (void)clearDrawing {
    if (self.pathArray != nil) {
        [self.pathArray removeAllObjects];
        [self.delPathArray removeAllObjects];
        [self setNeedsDisplay];
    }
}

/**
 撤销上一次绘制的路径
 */
- (void)backwardPath {
    if (self.pathArray.count > 0) {
        // 添加最新路径到 delPathArray
        [self.delPathArray addObject:self.pathArray.lastObject];
        [self.pathArray removeLastObject];
        // 重绘
        [self setNeedsDisplay];
    }
}

/**
 重绘上一次撤销的路径
 */
- (void)forwardPath {
    if (self.delPathArray.count > 0) {
        [self.pathArray addObject:self.delPathArray.lastObject];
        [self.delPathArray removeLastObject];
        [self setNeedsDisplay];
    }
}

/**
 保存图片
 */
- (void)saveDrawingAsPicture {
    if (self.pathArray != nil) {
        // 将 self 绘制成 UIImage
        UIImage *image = [LFHCustomTool createImageWithView:self];
        // 将图片保存到系统相册
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

/**
 分享图片
 */
- (UIImage *)shareImage {
    // 将 self 绘制成 UIImage
    UIImage *image = [LFHCustomTool createImageWithView:self];
    return image;
}

/**
 保存图片到系统相册回调函数
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    // 弹窗提示保存成功信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"保存成功";
    
    // 一秒后隐藏
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
    });
}

/**
 画笔
 */
- (void)drawWithPenColor:(NSString *)color Width:(CGFloat)width
{
    // 设置默认颜色
    if (color == nil) {
        color = @"000000";
    }
    // 设置默认宽度
    if (width == 0) {
        width = 10;
    }
    self.pathColor = [UIColor colorWithHexString:color];
    self.pathWidth = width;
    
    // 添加手势
    if (self.gestureRecognizers == nil) {
        // 点击
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        
        // 拖拽
        UIGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    } 
}

/**
 擦除内容
 */
- (void)drawWithEraserWidth:(CGFloat)width {
    self.pathColor = [UIColor whiteColor];
    self.pathWidth = width;
}

/**
 设置路径宽度
 */
- (void)changePathWidth:(CGFloat)pathWidth {
    self.pathWidth = pathWidth;
}

/**
 设置路径颜色
 */
- (void)changePathColor:(NSString *)color {
    self.pathColor = [UIColor colorWithHexString:color];
}

#pragma mark - Gesture Event
/**
 点击手势
 */
- (void)tap:(UITapGestureRecognizer *)tap {
    // 当手指点击时，删除 delPathArray 数组中的全部 path
    [self.delPathArray removeAllObjects];
    // 获取当前手势点
    CGPoint curPoint = [tap locationInView:self];
    // 创建路径
    LFHBezierPath *path = [[LFHBezierPath alloc] init];
    self.path = path;
    // 设置路径宽度和颜色
    path.lineWidth = self.pathWidth;
    path.color = self.pathColor;
    
    // 设置起点
    [path moveToPoint:curPoint];
    // 设置终点
    [path addLineToPoint:curPoint];
    // 保存当前路径
    [self.pathArray addObject:path];
    // 重绘
    [self setNeedsDisplay];
}

/**
 拖拽手势
 */
- (void)pan:(UIPanGestureRecognizer *)pan {
    // 当手指点开始移动时，删除 delPathArray 数组中的全部 path
    [self.delPathArray removeAllObjects];
    // 获取当前手势点
    CGPoint curPoint = [pan locationInView:self];
    // 判断手势状态
    if (pan.state == UIGestureRecognizerStateBegan) { // 开始状态
        // 创建路径,并赋值给成员属性 self.path
        LFHBezierPath *path = [[LFHBezierPath alloc] init];
        self.path = path;
        // 设置起点
        [path moveToPoint:curPoint];
        // 设置路径宽度和颜色
        path.lineWidth = self.pathWidth;
        path.color = self.pathColor;
        
        // 保存当前路径
        [self.pathArray addObject:path];
    } else if (pan.state == UIGestureRecognizerStateChanged) { // 移动状态
        // 添加线到当前手势点
        [self.path addLineToPoint:curPoint];
        // 重绘
        [self setNeedsDisplay];
    }
}

@end
