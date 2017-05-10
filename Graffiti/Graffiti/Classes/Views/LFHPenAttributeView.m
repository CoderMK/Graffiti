//
//  LFHPenAttributeView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/21.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  画笔属性视图

#import "LFHPenAttributeView.h"
#import "LFHColorScrollView.h"
#import <Masonry.h>

@interface LFHPenAttributeView ()

/* 宽度滑块 */
@property (nonatomic, weak) UISlider *slider;

/* 颜色选择视图 */
@property (nonatomic, weak) LFHColorScrollView *colorScrollView;

/* 属性字典 */
@property (nonatomic, strong) NSMutableDictionary *attributeDict;

@end

@implementation LFHPenAttributeView

#pragma mark - getter / setter
- (NSMutableDictionary *)attributeDict {
    if (_attributeDict == nil) {
        _attributeDict = [NSMutableDictionary dictionary];
        // 设置初始值
        [self.attributeDict setObject:@"000000" forKey:@"color"];
        [self.attributeDict setObject:@"10" forKey:@"width"];
    }
    return _attributeDict;
}

#pragma mark - View
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setupSubviews];
        // 添加颜色按钮点击监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorBtnClickUsingNotifacation:) name:@"ColorBtnClicked" object:nil];
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
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf).offset(-10);
    }];
    [self.colorScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.slider.mas_bottom);
        make.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf).offset(-10);
        make.height.equalTo(weakSelf.slider);
    }];
}

#pragma mark - Setup
/**
 初始化设置
 */
- (void)setup {
    self.alpha = 0.8;
    self.backgroundColor = [UIColor grayColor];
}

/**
 添加子控件
 */
- (void)setupSubviews {
    // 画笔宽度滑块
    UISlider *slider = [[UISlider alloc] init];
    [slider setThumbImage:[UIImage imageNamed:@"sliderthumb"] forState:UIControlStateNormal];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"sliderline"] forState:UIControlStateNormal];
    self.slider = slider;
    [self addSubview:slider];
    slider.minimumValue = 1;
    slider.maximumValue = 30;
    slider.value = 10;
    [slider addTarget:self action:@selector(sliderSlide:) forControlEvents:UIControlEventValueChanged];
    
    // 画笔颜色选择视图
    LFHColorScrollView *colorScrollView = [[LFHColorScrollView alloc] init];
    self.colorScrollView = colorScrollView;
    [self addSubview:colorScrollView];
}

#pragma mark - Slider Slide
/**
 滑块滑动时调用
 */
- (void)sliderSlide:(UISlider *)sender {
    // 设置属性字典中的宽度属性
    NSString *widthStr = [NSString stringWithFormat:@"%f", sender.value];
    [self.attributeDict setObject:widthStr forKey:@"width"];
    
    // 传递字典信息
    [self transmitAttributeInfo];
}

#pragma mark - Notification Monitoring (Button Click)
- (void)colorBtnClickUsingNotifacation:(NSNotification *)notification {
    // 设置颜色属性
    [self.attributeDict setObject:notification.userInfo[@"color"] forKey:@"color"];
    // 传递字典信息
    [self transmitAttributeInfo];
}

#pragma mark - Custom
/**
 选择属性回调
 */
- (void)selectAttributeBlock:(AttributeBlock)block {
    self.attributeBlock = block;
    [self transmitAttributeInfo];
}

/**
 传递属性字典信息
 */
- (void)transmitAttributeInfo {

    // 传递属性字典
    if (self.attributeBlock != nil) {
        self.attributeBlock(self.attributeDict);
    }
}

#pragma mark - dealloc
- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
