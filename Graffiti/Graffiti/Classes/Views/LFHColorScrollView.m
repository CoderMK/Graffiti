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
@property (nonatomic, strong) NSMutableArray *colorBtnArray;

/* 按钮模型数组 */
@property (nonatomic, strong) NSArray *colorBtnItems;

/* 当前选中按钮 */
@property (nonatomic, weak) LFHColorBtn *selectedBtn;

@end

@implementation LFHColorScrollView

#pragma mark - getter / setter
- (NSMutableArray *)colorBtnArray {
    if (_colorBtnArray == nil) {
        _colorBtnArray = [NSMutableArray array];
    }
    return _colorBtnArray;
}

-(NSArray *)colorBtnItems {
    if (_colorBtnItems == nil) {
        _colorBtnItems = [LFHColorBtnItem mj_objectArrayWithFilename:@"ColorBtn.plist"];
    }
    return _colorBtnItems;
}

#pragma mark - View
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化设置
        [self setup];
        // 添加子控件
        [self setupSubviews];
    }
    return self;
}

/**
 布局子控件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 布局按钮
    for (int i = 0; i < self.colorBtnArray.count; i++) {
        UIButton *btn = self.colorBtnArray[i];
        btn.frame = CGRectMake(i * BUTTON_WIDTH, 0, BUTTON_WIDTH, self.bounds.size.height);
    }
}

#pragma mark - Setup
/**
 初始化设置
 */
- (void)setup {
    // 设置 Scroll View 属性
    self.contentSize = CGSizeMake(self.colorBtnArray.count * BUTTON_WIDTH, 0);
    self.showsHorizontalScrollIndicator = NO;
}

/**
 添加子控件
 */
- (void)setupSubviews {
    // 添加按钮
    for (int i = 0; i < self.colorBtnItems.count; i++) {
        LFHColorBtn *btn = [LFHColorBtn colorBtnWithItem:self.colorBtnItems[i]];
        [self.colorBtnArray addObject:btn];
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
