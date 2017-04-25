//
//  LFHEraserAttributeView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/21.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  橡皮属性视图

#import "LFHEraserAttributeView.h"
#import <Masonry.h>

@interface LFHEraserAttributeView ()

/* 滑块控件 */
@property (nonatomic, weak) UISlider *slider;

@end

@implementation LFHEraserAttributeView

#pragma mark - View
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.8;
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
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf).offset(-10);
    }];
}

#pragma mark - Setup
/**
 添加子控件
 */
- (void)setupSubviews {
    // 添加滑块
    UISlider *slider = [[UISlider alloc] init];
    [slider setThumbImage:[UIImage imageNamed:@"sliderthumb"] forState:UIControlStateNormal];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"sliderline"] forState:UIControlStateNormal];
    self.slider = slider;
    [self addSubview:slider];
    slider.minimumValue = 1;
    slider.maximumValue = 30;
    slider.value = 10;
    [slider addTarget:self action:@selector(sliderSlide:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Slider Slide

/**
 滑块滑动后调用
 */
- (void)sliderSlide:(UISlider *)sender {
    [self transmitSliderValueInfo];
}

#pragma mark - Custom
/**
 选取滑块值回调
 */
- (void)selectSliderValueBlock:(SliderValueBlock)block {
    self.sliderValueBlock = block;
    [self transmitSliderValueInfo];
}

/**
 传递滑块值
 */
- (void)transmitSliderValueInfo {
    if (self.sliderValueBlock != nil) {
        self.sliderValueBlock(self.slider.value);
    }
}

@end
