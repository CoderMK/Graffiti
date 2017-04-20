//
//  LFHToolAttributeView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/20.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AttributeBlock)(NSDictionary *attributeDict);

@interface LFHToolAttributeView : UIView

/**
 工厂方法：根据传递的不同参数信息，分别创建不同的属性视图
 */
+ (instancetype)toolAttributeViewWithMessage:(NSString *)messageStr;

/* 传递属性信息 Block */
@property (nonatomic, copy) AttributeBlock attributeBlock;

// 选择属性回调
- (void)selectAttribute:(AttributeBlock)block;

@end
