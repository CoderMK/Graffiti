//
//  LFHPenAttributeView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/21.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  画笔属性视图

#import <UIKit/UIKit.h>

typedef void(^AttributeBlock)(NSDictionary *attributeDict);

@interface LFHPenAttributeView : UIView

/* 传递属性信息 Block */
@property (nonatomic, copy) AttributeBlock attributeBlock;

// 选择属性回调
- (void)selectAttributeBlock:(AttributeBlock)block;

@end
