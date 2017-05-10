//
//  LFHExpressionScrollView.h
//  Graffiti
//
//  Created by lifuheng on 2017/5/7.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  表情选择滚动视图

#import <UIKit/UIKit.h>

typedef void(^ReturnImageNameBlock)(NSString *imageName);

@interface LFHExpressionScrollView : UIScrollView

/* 返回表情图片名称的 Block 属性 */
@property (nonatomic, copy) ReturnImageNameBlock returnImageNameBlock;

/**
 返回表情图片名称

 @param block 回调 Block
 */
- (void)returnImageName:(ReturnImageNameBlock)block;

@end
