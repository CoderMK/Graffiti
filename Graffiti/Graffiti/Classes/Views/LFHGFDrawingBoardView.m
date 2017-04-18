//
//  LFHGFDrawingBoardView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHGFDrawingBoardView.h"
#import "LFHBezierPath.h"
#import "LFHToolDrawViewToImage.h"
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

#pragma mark - 绘制事件
/**
 清屏
 */
- (void)clearDrawing {
    if (self.pathArray != nil) {
        [self.pathArray removeAllObjects];
        [self.delPathArray removeAllObjects];
        [self setNeedsDisplay];
    }
}

/**
 撤销
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
 前进
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
        // 将 self 绘制成 Image
        UIImage *newImage = [[LFHToolDrawViewToImage shareToolDrawViewToImage] createImageWithView:self];
        // 将图片保存到系统相册
        UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (UIImage *)shareImage {
    // 将 self 绘制成 Image
    UIImage *image = [[LFHToolDrawViewToImage shareToolDrawViewToImage] createImageWithView:self];
    return image;
}


/**
 保存图片到系统相册回调函数
 
 @param image 图片
 @param error 错误信息
 @param contextInfo contextInfo
 */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"保存成功";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}

/**
 画笔
 */
- (void)drawWithPen {
    // 添加手势
    UIGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    // 设置默认线宽和颜色
    self.pathWidth = 1;
    self.pathColor = [UIColor blackColor];
}

/**
 文字
 */
- (void)drawWithFont {
    
}

/**
 擦除内容
 */
- (void)drawWithEraser {
    self.pathColor = [UIColor whiteColor];
}

/**
 设置线宽
 */
- (void)changePathWidth:(CGFloat)pathWidth {
    self.pathWidth = pathWidth;
}

/**
 设置线颜色
 */
- (void)changePathColor:(UIColor *)color {
    self.pathColor = color;
}

#pragma mark - 手势
- (void)pan:(UIPanGestureRecognizer *)pan {
    // 当手指点开始移动时，删除 delPathArray数组中的全部 path
    [self.delPathArray removeAllObjects];
    // 获取当前手势点
    CGPoint curPoint = [pan locationInView:self];
    // 判断手势状态
    if (pan.state == UIGestureRecognizerStateBegan) { // 开始状态
        // 创建路径,并赋值给成员属性self.path
        LFHBezierPath *path = [[LFHBezierPath alloc] init];
        self.path = path;
        // 设置起点
        [path moveToPoint:curPoint];
        // 设置路径宽度和颜色
        path.lineWidth = self.pathWidth;
        path.color = self.pathColor;
        
        // 设置路径链接方式为圆角
        path.lineJoinStyle = kCGLineJoinRound;
        // 保存当前路径
        [self.pathArray addObject:path];
    } else if (pan.state == UIGestureRecognizerStateChanged) { // 移动状态
        // 添加线到当前手势点
        [self.path addLineToPoint:curPoint];
        // 重绘
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
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

@end