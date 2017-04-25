//
//  LFHEraserAttributeView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/21.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  橡皮属性视图

#import <UIKit/UIKit.h>

typedef void(^SliderValueBlock)(CGFloat sliderValue);

@interface LFHEraserAttributeView : UIView

/* 传递滑块值 Block */
@property (nonatomic, copy) SliderValueBlock sliderValueBlock;

// 选取滑块值回调
- (void)selectSliderValueBlock:(SliderValueBlock)block;

@end
