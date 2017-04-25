//
//  LFHTextEditView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/25.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHTextEditView.h"

@interface LFHTextEditView ()

/**
 文本编辑框
 */
@property (weak, nonatomic) IBOutlet UITextView *textEditView;

@end

@implementation LFHTextEditView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

#pragma mark - Setup
/**
 初始化设置
 */
- (void)setup {
    [self.textEditView becomeFirstResponder];
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
