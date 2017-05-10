//
//  LFHTextEditView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/25.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  文字编辑视图

#import "LFHTextEditView.h"

@interface LFHTextEditView () <UITextViewDelegate>

/* 文本编辑框 */
@property (weak, nonatomic) IBOutlet UITextView *textEditView;

@end

@implementation LFHTextEditView

#pragma mark - Setup
+ (instancetype)textEditView {
    LFHTextEditView *textEditView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    [textEditView setup];
    return textEditView;
}
/**
 初始化设置
 */
- (void)setup {
    [self.textEditView becomeFirstResponder];
    self.textEditView.delegate = self;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
}

#pragma mark - Button Click
/**
 点击取消按钮后调用
 */
- (IBAction)cancelBtnClick:(UIButton *)sender {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(textEditView:clickCancelBtn:)]) {
        [self.delegate textEditView:self clickCancelBtn:sender];
    }
    // 从父控件中移除
    [self removeFromSuperview];
}

/**
 点击完成按钮后调用
 */
- (IBAction)finishBtnClick:(UIButton *)sender {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(textEditView:clickFinishBtn:Text:)]) {
        [self.delegate textEditView:self clickFinishBtn:sender Text:self.textEditView.text];
    }
    // 从父控件中移除
    [self removeFromSuperview];
}

@end
