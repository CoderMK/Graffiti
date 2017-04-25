//
//  LFHHandleFontView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/21.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  文字编辑视图

#import "LFHHandleFontView.h"

@interface LFHHandleFontView ()

/**
 文字编辑视图
 */
//@property (weak, nonatomic) IBOutlet UITextView *textEditView;

@end

@implementation LFHHandleFontView

#pragma mark - Button Click
/**
 点击取消按钮后调用
 */
- (IBAction)cancelBtnClick:(UIButton *)sender {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(handleFontView:clickCancelBtn:)]) {
        [self.delegate handleFontView:self clickCancelBtn:sender];
        [self removeFromSuperview];
    }
    // 从父控件中移除
    [self removeFromSuperview];
}

/**
 点击完成按钮后调用
 */
- (IBAction)finishBtnClick:(UIButton *)sender {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(handleFontView:clickFinishedBtn:)]) {
//        NSString *textStr = self.textEditView.text;
        [self.delegate handleFontView:self clickFinishedBtn:sender];
    }
    // 从父控件中移除
    [self removeFromSuperview];
}

@end
