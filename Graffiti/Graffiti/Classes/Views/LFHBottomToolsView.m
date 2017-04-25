//
//  LFHBottomToolsView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/25.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  涂鸦画板底部工具栏视图

#import "LFHBottomToolsView.h"

@interface LFHBottomToolsView ()

/* 当前选中按钮 */
@property (nonatomic, weak) UIButton *selectedBtn;

/* 画笔按钮 */
@property (weak, nonatomic) IBOutlet UIButton *penBtn;

@end

@implementation LFHBottomToolsView

#pragma mark - getter / setter
- (UIButton *)selectedBtn {
    if (_selectedBtn == nil) {
        _selectedBtn = self.penBtn;
    }
    return _selectedBtn;
}


#pragma mark - Button Click
- (IBAction)penBtnClick:(UIButton *)sender {
    // 设为选中按钮
    sender.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = sender;
    self.selectedBtn.selected = YES;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:clickPenBtn:)]) {
        [self.delegate bottomToolsView:self clickPenBtn:sender];
    }
}

- (IBAction)eraserBtnClick:(UIButton *)sender {
    // 设为选中按钮
    sender.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = sender;
    self.selectedBtn.selected = YES;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:clickEraserBtn:)]) {
        [self.delegate bottomToolsView:self clickEraserBtn:sender];
    }
}

- (IBAction)textBtnClick:(UIButton *)sender {
    // 设为选中按钮
    sender.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = sender;
    self.selectedBtn.selected = YES;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:clickTextBtn:)]) {
        [self.delegate bottomToolsView:self clickTextBtn:sender];
    }
}

@end
