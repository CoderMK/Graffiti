//
//  LFHBottomToolsView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/25.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  涂鸦画板底部工具栏视图

#define SELECTED_FLAG_VIEW_HEIGHT 1
#define SELECTED_FLAG_VIEW_MOVE_TIME 0.1

#import "LFHBottomToolsView.h"

@interface LFHBottomToolsView ()

/* 画笔按钮 */
@property (weak, nonatomic) IBOutlet UIButton *penBtn;

/* 按钮选中标记视图 */
@property (nonatomic, weak) UIView *selectedFlagView;

@end

@implementation LFHBottomToolsView

#pragma mark - Setup

/**
 窗厂方法创建实例对象
 */
+ (instancetype)bottomToolsView {
    LFHBottomToolsView *bottomToolsView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    [bottomToolsView setup];
    return bottomToolsView;
}

/**
 初始化设置
 */
- (void)setup {
    // 添加选中标记 View
    UIView *selectedFlagView = [[UIView alloc] init];
    self.selectedFlagView = selectedFlagView;
    selectedFlagView.backgroundColor = [UIColor darkGrayColor];
    selectedFlagView.frame = CGRectMake(0, 0, self.penBtn.bounds.size.width, SELECTED_FLAG_VIEW_HEIGHT);
    [self addSubview:selectedFlagView];
}

#pragma mark - Button Click
/**
 点击画笔按钮后调用
 */
- (IBAction)penBtnClick:(UIButton *)sender {
    // 移动选中按钮标记视图
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:SELECTED_FLAG_VIEW_MOVE_TIME animations:^{
        weakSelf.selectedFlagView.frame = CGRectMake(sender.frame.origin.x, 0, sender.bounds.size.width, SELECTED_FLAG_VIEW_HEIGHT);
    }];
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:clickPenBtn:)]) {
        [self.delegate bottomToolsView:self clickPenBtn:sender];
    }
}

/**
 点击橡皮按钮后调用
 */
- (IBAction)eraserBtnClick:(UIButton *)sender {
    // 移动选中按钮标记视图
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:SELECTED_FLAG_VIEW_MOVE_TIME animations:^{
        weakSelf.selectedFlagView.frame = CGRectMake(sender.frame.origin.x, 0, sender.bounds.size.width, SELECTED_FLAG_VIEW_HEIGHT);
    }];
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:clickEraserBtn:)]) {
        [self.delegate bottomToolsView:self clickEraserBtn:sender];
    }
}

/**
 点击表情按钮后调用
 */
- (IBAction)expressionBtnClick:(UIButton *)sender {
    // 移动选中按钮标记视图
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:SELECTED_FLAG_VIEW_MOVE_TIME animations:^{
        weakSelf.selectedFlagView.frame = CGRectMake(sender.frame.origin.x, 0, sender.bounds.size.width, SELECTED_FLAG_VIEW_HEIGHT);
    }];
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:clickExpressionBtn:)]) {
        [self.delegate bottomToolsView:self clickExpressionBtn:sender];
    }
}

/**
 点击字体按钮后调用
 */
- (IBAction)textBtnClick:(UIButton *)sender {
    // 移动选中按钮标记视图
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:SELECTED_FLAG_VIEW_MOVE_TIME animations:^{
        weakSelf.selectedFlagView.frame = CGRectMake(sender.frame.origin.x, 0, sender.bounds.size.width, SELECTED_FLAG_VIEW_HEIGHT);
    }];
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:clickTextBtn:)]) {
        [self.delegate bottomToolsView:self clickTextBtn:sender];
    }
}

/**
 点击帮助按钮后调用
 */
- (IBAction)helpBtnClick:(UIButton *)sender {
    // 移动选中按钮标记视图
    __weak __typeof(self)weakSelf = self;
    [UIView animateWithDuration:SELECTED_FLAG_VIEW_MOVE_TIME animations:^{
        weakSelf.selectedFlagView.frame = CGRectMake(sender.frame.origin.x, 0, sender.bounds.size.width, SELECTED_FLAG_VIEW_HEIGHT);
    }];
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:clickHelpBtn:)]) {
        [self.delegate bottomToolsView:self clickHelpBtn:sender];
    }
}

@end
