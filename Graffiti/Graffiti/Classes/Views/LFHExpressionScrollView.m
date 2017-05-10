//
//  LFHExpressionScrollView.m
//  Graffiti
//
//  Created by lifuheng on 2017/5/7.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  表情选择滚动视图

#define SELF_HEIGHT 128
#define SELF_WIDTH [UIScreen mainScreen].bounds.size.width
#define EXPRESSION_COUNT 14
#define PERPAGE_EXPRESSION_ROW_COUNT 2
#define PERPAGE_EXPRESSION_COLUMN_COUNT 4

#import "LFHExpressionScrollView.h"
#import "LFHExpressionBtn.h"
#import "LFHExpressionBtnItem.h"
#import <MJExtension.h>

@interface LFHExpressionScrollView ()

/* 表情按钮数组 */
@property (nonatomic, strong) NSMutableArray *expressionBtnArray;

/* 表情按钮模型数组 */
@property (nonatomic, strong) NSArray *expressionBtnItems;

@end

@implementation LFHExpressionScrollView

#pragma mark - getter / setter
- (NSMutableArray *)expressionBtnArray {
    if (_expressionBtnArray == nil) {
        _expressionBtnArray = [NSMutableArray array];
    }
    return _expressionBtnArray;
}

- (NSArray *)expressionBtnItems {
    if (_expressionBtnItems == nil) {
        _expressionBtnItems = [LFHExpressionBtnItem mj_objectArrayWithFilename:@"ExpressionBtn.plist"];
    }
    return _expressionBtnItems;
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
    // 计算每个按钮的 frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = SELF_WIDTH / PERPAGE_EXPRESSION_COLUMN_COUNT;
    CGFloat height = SELF_HEIGHT / PERPAGE_EXPRESSION_ROW_COUNT;
    for (int i = 0; i < EXPRESSION_COUNT; i++) {
        x = (SELF_WIDTH * (i / (PERPAGE_EXPRESSION_ROW_COUNT * PERPAGE_EXPRESSION_COLUMN_COUNT))) + (width * ((i % 8) % 4));
        y =  height * ((i % 8) / 4);
        UIButton *btn = self.expressionBtnArray[i];
        btn.frame = CGRectMake(x, y, width, height);
    }
}

#pragma mark - Setup
/**
 初始化设置
 */
- (void)setup {
    self.alpha = 0.8;
    self.backgroundColor = [UIColor grayColor];
    self.contentSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width * (EXPRESSION_COUNT / (PERPAGE_EXPRESSION_ROW_COUNT * PERPAGE_EXPRESSION_COLUMN_COUNT) + 1)), 0);
    self.pagingEnabled = YES;
     
}

/**
 添加子控件
 */
- (void)setupSubviews {
    // 添加表情按钮
    for (int i = 0; i < EXPRESSION_COUNT; i++) {
        LFHExpressionBtn *btn = [LFHExpressionBtn expressionBtnWithItem:self.expressionBtnItems[i]];
        [self addSubview:btn];
        [self.expressionBtnArray addObject:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - Button Click
/**
 表情按钮点击
 */
- (void)btnClick:(LFHExpressionBtn *)sender {
    // Block 传值
    if (self.returnImageNameBlock != nil) {
        self.returnImageNameBlock(sender.expressionBtnItem.imageName);
    }
}

#pragma mark - Custom
/**
 返回表情图片名称
 
 @param block 回调 Block
 */
- (void)returnImageName:(ReturnImageNameBlock)block {
    self.returnImageNameBlock = block;
}

@end
