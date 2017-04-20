//
//  LFHToolAttributeView.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/20.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import "LFHToolAttributeView.h"
#import "LFHColorScrollView.h"
#import <Masonry.h>

@interface LFHToolAttributeView ()

/* 宽度滑块 */
@property (nonatomic, weak) UISlider *slider;

/* 颜色选择视图 */
@property (nonatomic, weak) LFHColorScrollView *colorScrollView;

/* 接收的消息 */
@property (nonatomic, strong) NSString *messageStr;

/* 属性字典 */
@property (nonatomic, strong) NSMutableDictionary *attributeDict;

@end

@implementation LFHToolAttributeView

#pragma mark - getter / setter
- (NSMutableDictionary *)attributeDict {
    if (_attributeDict == nil) {
        _attributeDict = [NSMutableDictionary dictionary];
    }
    return _attributeDict;
}

#pragma mark - Factory Init
+ (instancetype)toolAttributeViewWithMessage:(NSString *)messageStr {
    LFHToolAttributeView *toolAttribute = [[self alloc] initWithMessageStr:messageStr];
    return toolAttribute;
}

#pragma mark - View
- (instancetype)initWithMessageStr:(NSString *)messageStr
{
    self = [super init];
    if (self) {
        self.messageStr = messageStr;
        // 初始化子控件
        [self setupSubviews];
        // 设置属性字典信息
        [self setAttributeInfo];
        // 添加监听
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
        make.left.right.bottom.equalTo(weakSelf);
        make.height.equalTo(weakSelf.slider);
    }];
}

#pragma mark - Setup
/**
 添加子控件
 */
- (void)setupSubviews {
    if ([self.messageStr isEqualToString:@"PenAttribute"]) {
        // 画笔宽度滑块
        UISlider *slider = [[UISlider alloc] init];
        self.slider = slider;
        [self addSubview:slider];
        slider.value = 10;
        slider.minimumValue = 1;
        slider.maximumValue = 30;
        [slider addTarget:self action:@selector(sliderSlide:) forControlEvents:UIControlEventValueChanged];
        
        // 画笔颜色选择视图
        LFHColorScrollView *colorScrollView = [[LFHColorScrollView alloc] init];
        self.colorScrollView = colorScrollView;
        [self addSubview:colorScrollView];
    }
}

#pragma mark - Slider Slide
/**
 滑块滑动时调用
 */
- (void)sliderSlide:(UISlider *)sender {
    // 设置属性字典中的宽度属性
    NSString *widthStr = [NSString stringWithFormat:@"%f", sender.value];
    [self.attributeDict setObject:widthStr forKey:@"width"];
    
    // 设置字典信息
    [self setAttributeInfo];
}

#pragma mark - Notification Monitoring (Button Click)
- (void)colorBtnClickUsingNotifacation:(NSNotification *)notification {
    // 设置颜色属性
    [self.attributeDict setObject:notification.userInfo[@"color"] forKey:@"color"];
    // 设置字典信息
    [self setAttributeInfo];
}

#pragma mark - Custom
/**
 选择属性回调
 */
- (void)selectAttribute:(AttributeBlock)block {
    self.attributeBlock = block;
    [self setAttributeInfo];
}

/**
 设置属性字典信息
 */
- (void)setAttributeInfo {
    // 默认值
    if (self.attributeDict.count == 0) {
        [self.attributeDict setObject:@"000000" forKey:@"color"];
        [self.attributeDict setObject:@"1" forKey:@"width"];
    }
    
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
