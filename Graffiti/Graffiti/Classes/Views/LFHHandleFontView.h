//
//  LFHHandleFontView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/21.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  文字编辑视图

#import <UIKit/UIKit.h>
@class LFHHandleFontView;

@protocol LFHHandleFontViewDelegate <NSObject>

@required

/**
 点击取消按钮后调用
 */
- (void)handleFontView:(LFHHandleFontView *)view clickCancelBtn:(UIButton *)sender;

/**
 点击完成按钮后调用
 */
- (void)handleFontView:(LFHHandleFontView *)view clickFinishedBtn:(UIButton *)sender;

@end

@interface LFHHandleFontView : UIView

/* 代理属性 */
@property (nonatomic, weak) id <LFHHandleFontViewDelegate> delegate;

@end
