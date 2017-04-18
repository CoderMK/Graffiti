//
//  LFHToolDrawViewToImage.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/18.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LFHToolDrawViewToImage : NSObject

/* 单例创建实例对象 */
+ (instancetype)shareToolDrawViewToImage;

/* 将图层绘制成图像 */
- (UIImage *)createImageWithView:(UIView *)view;

@end
