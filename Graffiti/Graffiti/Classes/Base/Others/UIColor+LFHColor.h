//
//  UIColor+LFHColor.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/20.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  可以用用十六进制颜色值创建 UIColor

#import <UIKit/UIKit.h>

@interface UIColor (LFHColor)

/**
 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
