//
//  LFHGFBottomToolsView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHGFBottomToolsView.h"
#import <Masonry.h>

@interface LFHGFBottomToolsView ()

/* 当前选中按钮 */
@property (nonatomic, weak) UIButton *selectedBtn;

/* 画笔按钮 */
@property (nonatomic, weak) UIButton *penBtn;

/* 橡皮按钮 */
@property (nonatomic, weak) UIButton *eraserBtn;

@end

@implementation LFHGFBottomToolsView

#pragma mark - getter / setter
- (UIButton *)selectedBtn {
    if (_selectedBtn == nil) {
        _selectedBtn = self.penBtn;
    }
    return _selectedBtn;
}

#pragma mark - View
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

/**
 布局子控件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 添加约束
    __weak __typeof(self)weakSelf = self;
    [self.penBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
        make.width.equalTo(weakSelf.eraserBtn);
    }];
    [self.eraserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf.penBtn.mas_right);
    }];
}

#pragma mark - setup
/**
 添加子控件
 */
- (void)setupSubviews {
    /* 画笔按钮 */
    UIButton *penBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.penBtn = penBtn;
    [self addSubview:penBtn];
    [penBtn setTitle:@"画笔" forState:UIControlStateNormal];
    [penBtn setTitle:@"已选画笔" forState:UIControlStateSelected];
    [penBtn addTarget:self action:@selector(penBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    /* 橡皮按钮 */
    UIButton *eraserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.eraserBtn = eraserBtn;
    [self addSubview:eraserBtn];
    [eraserBtn setTitle:@"橡皮" forState:UIControlStateNormal];
    [eraserBtn setTitle:@"已选橡皮" forState:UIControlStateSelected];
    [eraserBtn addTarget:self action:@selector(eraserBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button Click
- (void)penBtnClick:(UIButton *)sender {
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    self.selectedBtn.selected = YES;
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:ClickPenBtn:)]) {
        [self.delegate bottomToolsView:self ClickPenBtn:sender];
    }
}

- (void)eraserBtnClick:(UIButton *)sender {
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    if ([self.delegate respondsToSelector:@selector(bottomToolsView:ClickEraserBtn:)]) {
        [self.delegate bottomToolsView:self ClickEraserBtn:sender];
    }
}
@end
