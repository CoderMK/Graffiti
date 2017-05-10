//
//  LFHTextEditView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/25.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  文字编辑视图

#import <UIKit/UIKit.h>
@class LFHTextEditView;

@protocol LFHTextEditViewDelegate <NSObject>

/**
 点击取消按钮后调用
 */
- (void)textEditView:(LFHTextEditView *)view clickCancelBtn:(UIButton *)btn;

/**
 点击完成按钮后调用
 */
- (void)textEditView:(LFHTextEditView *)view clickFinishBtn:(UIButton *)btn Text:(NSString *)text;

@end


@interface LFHTextEditView : UIView

/* 代理属性 */
@property (nonatomic, weak) id <LFHTextEditViewDelegate> delegate;

+ (instancetype)textEditView;

@end
