//
//  LFHGFBottomToolsView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  涂鸦画板底部工具栏

#import <UIKit/UIKit.h>
@class LFHGFBottomToolsView;

@protocol LFHGFBottomToolsViewDelegate <NSObject>

@required
/**
 画笔按钮点击后调用

 @param view self
 @param sender penBtn
 */
- (void)bottomToolsView:(LFHGFBottomToolsView *)view ClickPenBtn:(UIButton *)sender;

/**
 橡皮按钮点击后调用

 @param view self
 @param sender eraserBtn
 */
- (void)bottomToolsView:(LFHGFBottomToolsView *)view ClickEraserBtn:(UIButton *)sender;

@end

@interface LFHGFBottomToolsView : UIView

/* 代理属性 */
@property (nonatomic, assign) id <LFHGFBottomToolsViewDelegate> delegate;

@end
