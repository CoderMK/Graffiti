//
//  LFHColorScrollView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/19.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  选择颜色视图

#define BUTTON_WIDTH 30

#import "LFHColorScrollView.h"
#import "LFHColorBtn.h"
#import "LFHColorBtnItem.h"
#import <MJExtension.h>

@interface LFHColorScrollView ()

/* 颜色按钮数组 */
@property (nonatomic, strong) NSMutableArray *btnArray;

/* 按钮模型数组 */
@property (nonatomic, strong) NSArray *btnItems;

/* 当前选中按钮 */
@property (nonatomic, weak) LFHColorBtn *selectedBtn;

@end

@implementation LFHColorScrollView

#pragma mark - getter / setter
- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(NSArray *)btnItems {
    if (!_btnItems) {
        _btnItems = [LFHColorBtnItem mj_objectArrayWithFilename:@"ColorBtn.plist"];
    }
    return _btnItems;
}

#pragma mark - View
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加子控件
        [self setupSubviews];
        // 设置 Scroll View 属性
        self.contentSize = CGSizeMake(self.btnArray.count * BUTTON_WIDTH, 0);
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

/**
 布局子控件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // Button
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton *btn = self.btnArray[i];
        btn.frame = CGRectMake(i * BUTTON_WIDTH, 0, BUTTON_WIDTH, self.bounds.size.height);
    }
}

#pragma mark - Setup
/**
 添加子控件
 */
- (void)setupSubviews {
    // 添加按钮
    for (int i = 0; i < self.btnItems.count; i++) {
        LFHColorBtn *btn = [LFHColorBtn colorBtnWithItem:self.btnItems[i]];
        [self.btnArray addObject:btn];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 默认第一个按钮为选中状态
        if (i == 0) {
            self.selectedBtn = btn;
            btn.selected = YES;
        }
    }
}

#pragma mark - Button Click
/**
 颜色按钮点击
 */
- (void)btnClick:(LFHColorBtn *)sender {
    // 设为选中状态
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    
    // 将颜色信息打包进字典并通过通知发送出去
    NSDictionary *dict = @{@"color" : sender.colorBtnItem.color};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ColorBtnClicked" object:self userInfo:dict];
}

@end
