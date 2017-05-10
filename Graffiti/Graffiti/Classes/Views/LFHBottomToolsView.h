//
//  LFHBottomToolsView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/25.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  涂鸦画板底部工具栏视图

#import <UIKit/UIKit.h>

@class LFHBottomToolsView;

@protocol LFHBottomToolsViewDelegate <NSObject>

/**
 点击画笔按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickPenBtn:(UIButton *)sender;

/**
 点击橡皮按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickEraserBtn:(UIButton *)sender;

/**
 点击表情按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickExpressionBtn:(UIButton *)sender;

/**
 点击字体按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickTextBtn:(UIButton *)sender;

/**
 点击帮助按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickHelpBtn:(UIButton *)sender;
@end

@interface LFHBottomToolsView : UIView

/* 代理属性 */
@property (nonatomic, assign) id <LFHBottomToolsViewDelegate> delegate;

/**
 工厂方法创建实例对象
 */
+ (instancetype)bottomToolsView;

@end
