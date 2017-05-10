//
//  LFHGraffitiBoardViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  涂鸦画板控制器

#define BOTTOMTOOLSVIEW_HEIGHT 49
#define EXPRESSIONSCROLLVIEW_HEIGHT 128

#import "LFHGraffitiBoardViewController.h"
#import "LFHImagePickerViewController.h"
#import "LFHGFDrawingBoardView.h"
#import "LFHBottomToolsView.h"
#import "LFHTextEditView.h"
#import "LFHPenAttributeView.h"
#import "LFHEraserAttributeView.h"
#import "LFHExpressionScrollView.h"
#import "LFHBasicHandleView.h"
#import "LFHCustomTool.h"
#import <Masonry.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import <MBProgressHUD.h>

@interface LFHGraffitiBoardViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, LFHBottomToolsViewDelegate, LFHTextEditViewDelegate,  LFHBasicHandleViewDelegate>

/* 画板视图 */
@property (nonatomic, weak) LFHGFDrawingBoardView *drawingBoardView;

/* 底部工具栏 */
@property (nonatomic, weak) UIView *bottomToolsView;

/* 画笔属性视图 */
@property (nonatomic, weak) LFHPenAttributeView *penAttributeView;

/* 橡皮属性视图 */
@property (nonatomic, weak) LFHEraserAttributeView *eraserAttributeView;

/* 表情选择视图 */
@property (nonatomic, weak) LFHExpressionScrollView *expressionScrollView;

@end

@implementation LFHGraffitiBoardViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    [self setupUI];
}

#pragma mark - Setup
/**
 初始化导航条
 */
- (void)setupNavigationBar {
    self.edgesForExtendedLayout = UIRectEdgeAll;
    /* 添加 BarButtonItem */
    // 撤销按钮
    UIBarButtonItem *backwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backward"] style:UIBarButtonItemStylePlain target:self action:@selector(backwardBtnClick)];
    
    // 前进按钮
    UIBarButtonItem *forwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardBtnClick)];
    
    // 相册按钮
    UIBarButtonItem *photoLibraryBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"photolibrary"] style:UIBarButtonItemStylePlain target:self action:@selector(photoLibraryBtnClick)];
    
    // 清屏按钮
    UIBarButtonItem *clearBtn = [[UIBarButtonItem alloc] initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(clearBtnClick)];
    
    // 保存/分享按钮
    UIBarButtonItem *saveOrShareBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存/分享" style:UIBarButtonItemStylePlain target:self action:@selector(saveOrShareBtnClick)];
    
    // 将按钮打包添加到 NavigationItem
    NSArray *barButtonItemArray = @[saveOrShareBtn, clearBtn, photoLibraryBtn, forwardBtn, backwardBtn];
    self.navigationItem.rightBarButtonItems = barButtonItemArray;
}

/**
 初始化UI布局
 */
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加画板视图
    LFHGFDrawingBoardView *drawingBoardView = [[LFHGFDrawingBoardView alloc] init];
    self.drawingBoardView = drawingBoardView;
    [self.view addSubview:drawingBoardView];
    
    // 添加底部工具视图
    LFHBottomToolsView *bottomToolsView = [LFHBottomToolsView bottomToolsView];
    self.bottomToolsView = bottomToolsView;
    [self.view addSubview:bottomToolsView];
    bottomToolsView.delegate = self;

    // 添加约束
    __weak __typeof(self)weakSelf = self;
    [drawingBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.navigationController.navigationBar.bounds.size.height);
        make.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(self.view).offset(-BOTTOMTOOLSVIEW_HEIGHT);
    }];
    [bottomToolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.height.mas_equalTo(BOTTOMTOOLSVIEW_HEIGHT);
    }];
}

#pragma mark - Button Click
/**
 点击撤销按钮后调用
 */
- (void)backwardBtnClick {
    [self.drawingBoardView backwardPath];
}

/**
 点击前进按钮后调用
 */
- (void)forwardBtnClick {
    [self.drawingBoardView forwardPath];
}

/**
 点击相册按钮后调用
 */
- (void)photoLibraryBtnClick {
    // 创建 ImagePickerController
    LFHImagePickerViewController *imagePickerVC = [[LFHImagePickerViewController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerVC.delegate = self;
    
    // Modal 方式显示
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

/**
 点击清屏按钮后调用
 */
- (void)clearBtnClick {
    [self.drawingBoardView clearDrawing];
}

/**
 点击保存/分享按钮后调用
 */
- (void)saveOrShareBtnClick {
    /* 创建并显示 AlertController */
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存到系统相册/分享到微信" message:@"目前仅开放微信平台" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    __weak __typeof(self)weakSelf = self;
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.drawingBoardView saveDrawingAsPicture];
    }];
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImage *image = [weakSelf.drawingBoardView shareImage];
        [weakSelf shareImage:image];
    }];
    UIAlertAction *saveAndShareAction = [UIAlertAction actionWithTitle:@"保存并分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.drawingBoardView saveDrawingAsPicture];
        UIImage *image = [weakSelf.drawingBoardView shareImage];
        [weakSelf shareImage:image];
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    [alertController addAction:shareAction];
    [alertController addAction:saveAndShareAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 ImagePickerController 点击图片后调用
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 取出选中图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 创建 Handle Image View
    LFHBasicHandleView *handleImageView = [LFHBasicHandleView handleView];
    [self.view addSubview:handleImageView];
    handleImageView.delegate = self;
    
    // Handle Image View 开启时隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    // Handle Image View 开启期间禁止底部工具栏按钮点击
    self.bottomToolsView.userInteractionEnabled = NO;
    // 设置 Handle Image View 的 Handle View
    UIImageView *handleView = [[UIImageView alloc] initWithImage:image];
    handleView.contentMode = UIViewContentModeScaleAspectFit;
    [handleImageView setupHandleView:handleView displayPosition:LFHHandleViewDisplayPositionEqualContentView];
    
    // 添加约束
    __weak __typeof(self)weakSelf = self;
    [handleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.drawingBoardView);
    }];
    
    // 关闭图片选择器
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - LFHBottomToolsViewDelegate
/**
 点击画笔按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickPenBtn:(UIButton *)sender {
    if (self.eraserAttributeView.hidden == NO) { // 如果橡皮属性视图已显示，将其隐藏
        self.eraserAttributeView.hidden = YES;
    } else if (self.expressionScrollView.hidden == NO) { // 如果表情选择视图已显示，将其隐藏
        self.expressionScrollView.hidden = YES;
    }
    if (self.penAttributeView == nil) { // 第一次点击画笔按钮时创建画笔属性视图
        // 创建画笔属性视图
        LFHPenAttributeView *penAttributeView = [[LFHPenAttributeView alloc] init];
        self.penAttributeView = penAttributeView;
        [self.view addSubview:penAttributeView];
        
        // 添加约束
        __weak __typeof(self)weakSelf = self;
        [penAttributeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf.drawingBoardView);
            make.height.mas_equalTo(60);
        }];
        // 开启涂鸦板画笔功能
        [penAttributeView selectAttributeBlock:^(NSDictionary *attributeDict) {
            [weakSelf.drawingBoardView drawWithPenColor:attributeDict[@"color"] Width:[attributeDict[@"width"] floatValue]];
        }];
    } else if (self.penAttributeView.hidden == YES) { // 画笔属性视图隐藏时
        // 显示画笔属性视图
        self.penAttributeView.hidden = NO;
        // 开启涂鸦板画笔功能
        __weak __typeof(self)weakSelf = self;
        [self.penAttributeView selectAttributeBlock:^(NSDictionary *attributeDict) {
            [weakSelf.drawingBoardView drawWithPenColor:attributeDict[@"color"] Width:[attributeDict[@"width"] floatValue]];
        }];
    } else { // 画笔属性视图正在显示时
        self.penAttributeView.hidden = YES;
    }
}

/**
 点击橡皮按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickEraserBtn:(UIButton *)sender {
    if (self.penAttributeView.hidden == NO) { // 如果画笔属性视图已显示，将其隐藏
        self.penAttributeView.hidden = YES;
    } else if (self.expressionScrollView.hidden == NO) { // 如果表情选择视图已显示，将其隐藏
        self.expressionScrollView.hidden = YES;
    }
    if (self.eraserAttributeView == nil) { // 第一次点击橡皮按钮时创建橡皮属性视图
        // 创建橡皮属性视图
        LFHEraserAttributeView *eraserAttributeView = [[LFHEraserAttributeView alloc] init];
        eraserAttributeView.backgroundColor = [UIColor grayColor];
        self.eraserAttributeView = eraserAttributeView;
        [self.view addSubview:eraserAttributeView];
        
        // 添加约束
        __weak __typeof(self)weakSelf = self;
        [eraserAttributeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf.drawingBoardView);
            make.height.mas_equalTo(30);
        }];
        // 开启涂鸦画板橡皮功能
        [eraserAttributeView selectSliderValueBlock:^(CGFloat sliderValue) {
            [weakSelf.drawingBoardView drawWithEraserWidth:sliderValue];
        }];
        
    } else if (self.eraserAttributeView.hidden == YES) { // 橡皮属性视图隐藏时
        // 显示橡皮属性视图
        self.eraserAttributeView.hidden = NO;
        // 开启涂鸦画板橡皮功能
        __weak __typeof(self)weakSelf = self;
        [self.eraserAttributeView selectSliderValueBlock:^(CGFloat sliderValue) {
            [weakSelf.drawingBoardView drawWithEraserWidth:sliderValue];
        }];
    } else { // 橡皮属性视图正在显示时
        // 隐藏橡皮属性视图
        self.eraserAttributeView.hidden = YES;
    }
}

/**
 点击表情按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickExpressionBtn:(UIButton *)sender {
    if (self.penAttributeView.hidden == NO) { // 如果画笔属性视图已显示，将其隐藏
        self.penAttributeView.hidden = YES;
    } else if (self.eraserAttributeView.hidden == NO) { // 如果橡皮属性视图已显示，将其隐藏
        self.eraserAttributeView.hidden = YES;
    }
    if (self.expressionScrollView == nil) { // 第一次点击表情选择视图
        // 创建表情选择视图
        LFHExpressionScrollView *expressionScrollView = [[LFHExpressionScrollView alloc] init];
        self.expressionScrollView = expressionScrollView;
        [self.view addSubview:expressionScrollView];
        
        // 添加约束
        __weak __typeof(self)weakSelf = self;
        [expressionScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf.drawingBoardView);
            make.height.mas_equalTo(EXPRESSIONSCROLLVIEW_HEIGHT);
        }];
        // 点击表情图片后调用
        [expressionScrollView returnImageName:^(NSString *imageName) {
            // 隐藏表情选择视图
            expressionScrollView.hidden = YES;
            // 创建 Handle Epression View
            LFHBasicHandleView *handleExpressionView = [LFHBasicHandleView handleView];
            [weakSelf.view addSubview:handleExpressionView];
            handleExpressionView.delegate = weakSelf;
            
            // Handle Expression View 开启时隐藏导航条
            weakSelf.navigationController.navigationBar.hidden = YES;
            // Handle Expression Veiw 开启期间禁止底部工具栏按钮点击
            weakSelf.bottomToolsView.userInteractionEnabled = NO;
            // 设置 Handle Expression View 的 Handle View
            UIImageView *handleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            [handleExpressionView setupHandleView:handleView displayPosition:LFHHandleViewDisplayPositionCenter];
            
            // 添加约束
            [handleExpressionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.drawingBoardView);
            }];
        }];
    } else if (self.expressionScrollView.hidden == YES) { // 表情选择视图隐藏时
        self.expressionScrollView.hidden = NO;
    } else { // 表情选择视图正在显示时
        self.expressionScrollView.hidden = YES;
    }
}

/**
 点击字体按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickTextBtn:(UIButton *)sender {
    // 创建 Text Edit View
    LFHTextEditView *textEditView = [LFHTextEditView textEditView];
    [self.view addSubview:textEditView];
    textEditView.delegate = self;
    
    // 从底部动画推出并隐藏导航栏
    textEditView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        textEditView.frame = self.view.bounds;
        self.navigationController.navigationBar.hidden = YES;
    }];
}

/**
 点击帮助按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickHelpBtn:(UIButton *)sender {
    // 弹窗提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"敬请期待";
    
    // 一秒后隐藏
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    });
}

#pragma mark - LFHTextEditViewDelegate
/**
 Text Edit View 点击取消按钮后调用
 */
- (void)textEditView:(LFHTextEditView *)view clickCancelBtn:(UIButton *)btn {
    self.navigationController.navigationBar.hidden = NO;
}

/**
 Text Edit View 点击完成按钮后调用
 */
- (void)textEditView:(LFHTextEditView *)view clickFinishBtn:(UIButton *)btn Text:(NSString *)text {
    // 创建 Handle Label View
    LFHBasicHandleView *handleLabelView = [LFHBasicHandleView handleView];
    [self.view addSubview:handleLabelView];
    handleLabelView.delegate = self;
    
    // Handle Label View 开启时隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    // Handle Label Veiw 开启期间禁止底部工具栏按钮点击
    self.bottomToolsView.userInteractionEnabled = NO;
    // 设置 Handle Label View 的 Handle View
    NSDictionary *attrDict = @{NSFontAttributeName :[UIFont systemFontOfSize:30]};
    UILabel *handleView = [LFHCustomTool createLabelWithString:text attribute:attrDict];
    [handleLabelView setupHandleView:handleView displayPosition:LFHHandleViewDisplayPositionCenter];
    
    // 添加约束
    __weak __typeof(self)weakSelf = self;
    [handleLabelView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.drawingBoardView);
    }];
}

#pragma mark - LFHBasicHandleViewDelegate
/**
 点击取消按钮后调用

 @param view Basic Hanle View
 */
- (void)handleViewDidCancel:(LFHBasicHandleView *)view {
    // 从父控件中移除
    [view removeFromSuperview];
    // 恢复导航栏显示状态和底部工具栏按钮点击
    self.navigationController.navigationBar.hidden = NO;
    self.bottomToolsView.userInteractionEnabled = YES;
}

/**
 点击完成按钮后调用

 @param view Basic Handle View
 @param image 要绘制到画板上的图片
 */
- (void)handleView:(LFHBasicHandleView *)view didFinishWithDrawingImage:(UIImage *)image {
    // 从父控件中移除
    [view removeFromSuperview];
    // 恢复导航栏显示状态和底部工具栏按钮点击
    self.navigationController.navigationBar.hidden = NO;
    self.bottomToolsView.userInteractionEnabled = YES;
    // 将图片绘制到涂鸦画板上
    self.drawingBoardView.image = image;
}


#pragma mark - UShare
/**
 分享图片

 @param image 要分享的图片
 */
- (void)shareImage:(UIImage *)image {
    // 设置分享面板分享平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatFavorite)]];
    // 点击相应分享平台后调用
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        // 创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        // 如果有缩略图，则设置缩略图
        //    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
        [shareObject setShareImage:image];
        // 分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        // 调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//            if (error) {
//                NSLog(@"************Share fail with error %@*********",error);
//            }else{
//                NSLog(@"response data is %@",data);
//            }
        }];
    }];
}

#pragma mark - 设置导航条
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
