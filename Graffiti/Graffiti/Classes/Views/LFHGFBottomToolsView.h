//
//  LFHGFBottomToolsView.h
//  Graffiti
//
//  Created by lifuheng on 2017/4/17.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFHGFBottomToolsView;

@protocol LFHGFBottomToolsViewDelegate <NSObject>

@required
/********** 监听按钮点击 **********/
- (void)bottomToolsView:(LFHGFBottomToolsView *)view ClickPenBtn:(UIButton *)sender;

- (void)bottomToolsView:(LFHGFBottomToolsView *)view ClickEraserBtn:(UIButton *)sender;
/******************************/

@end

@interface LFHGFBottomToolsView : UIView

/* 代理属性 */
@property (nonatomic, assign) id <LFHGFBottomToolsViewDelegate> delegate;

@end
