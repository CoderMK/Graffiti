//
//  LFHGraffitiBoardViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//  涂鸦画板控制器

#define BOTTOMTOOLSVIEW_HEIGHT 49

#import "LFHGraffitiBoardViewController.h"
#import "LFHImagePickerViewController.h"
#import "LFHGFDrawingBoardView.h"
#import "LFHBottomToolsView.h"
#import "LFHHandleImageView.h"
#import "LFHTextEditView.h"
#import "LFHHandleFontView.h"
#import "LFHPenAttributeView.h"
#import "LFHEraserAttributeView.h"
#import <Masonry.h>
#import <UMSocialCore/UMSocialCore.h>

@interface LFHGraffitiBoardViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, LFHBottomToolsViewDelegate, LFHHandleImageViewDelegate, LFHTextEditViewDelegate>

/* 画板视图 */
@property (nonatomic, weak) LFHGFDrawingBoardView *drawingBoardView;

/* 画笔属性视图 */
@property (nonatomic, weak) LFHPenAttributeView *penAttributeView;

/* 橡皮属性视图 */
@property (nonatomic, weak) LFHEraserAttributeView *eraserAttributeView;

/* 底部工具栏 */
@property (nonatomic, weak) UIView *bottomToolsView;

@end

@implementation LFHGraffitiBoardViewController

#pragma mark - View Controller
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
/**
 初始化导航条
 */
- (void)setupNavigationBar {
    // 添加 BarButtonItem
    // 撤销按钮
    UIBarButtonItem *backwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backward"] style:UIBarButtonItemStylePlain target:self action:@selector(backwardBtnClick)];
    backwardBtn.width = 20;
    // 前进按钮
    UIBarButtonItem *forwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardBtnClick)];
    forwardBtn.width = 20;
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
    // 画板视图
    LFHGFDrawingBoardView *drawingBoardView = [[LFHGFDrawingBoardView alloc] init];
    self.drawingBoardView = drawingBoardView;
    drawingBoardView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawingBoardView];
    
    // 底部工具视图
    LFHBottomToolsView *bottomToolsView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LFHBottomToolsView class]) owner:nil options:nil] firstObject];
    self.bottomToolsView = bottomToolsView;
    bottomToolsView.backgroundColor = [UIColor darkGrayColor];
    bottomToolsView.delegate = self;
    [self.view addSubview:bottomToolsView];

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
    // 创建并 Modal 出 ImagePickerController
    LFHImagePickerViewController *imagePickerVC = [[LFHImagePickerViewController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerVC.delegate = self;
    
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
    // 创建并显示 AlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存到系统相册/分享到微信" message:@"目前仅开放微信平台" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    __weak __typeof(self)weakSelf = self;
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.drawingBoardView saveDrawingAsPicture];
    }];
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImage *image = [weakSelf.drawingBoardView shareImage];
        [weakSelf shareImage:image toPlatformType:UMSocialPlatformType_WechatSession];
    }];
    UIAlertAction *saveAndShareAction = [UIAlertAction actionWithTitle:@"保存并分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.drawingBoardView saveDrawingAsPicture];
        UIImage *image = [weakSelf.drawingBoardView shareImage];
        [weakSelf shareImage:image toPlatformType:UMSocialPlatformType_WechatSession];
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    [alertController addAction:shareAction];
    [alertController addAction:saveAndShareAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 ImagePickerController 中点击图片后调用
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 取出图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 创建 Handle Image View
    LFHHandleImageView *handleImageView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LFHHandleImageView class]) owner:nil options:nil] firstObject];
    handleImageView.drawingImage = image;
    handleImageView.delegate = self;
    [self.view addSubview:handleImageView];
    
    // 添加约束
    __weak __typeof(self)weakSelf = self;
    [handleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.drawingBoardView);
    }];
    // Handle Image View 开启时隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    // 关闭图片选择器
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - LFHBottomToolsViewDelegate
/**
 点击画笔按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickPenBtn:(UIButton *)sender {
    // 如果橡皮属性视图已显示，将其隐藏
    if (self.eraserAttributeView.hidden == NO) {
        self.eraserAttributeView.hidden = YES;
    }
    if (self.penAttributeView == nil) { // 第一次点击画笔按钮时创建画笔属性视图
        // 创建画笔属性视图
        LFHPenAttributeView *penAttributeView = [[LFHPenAttributeView alloc] init];
        self.penAttributeView = penAttributeView;
        penAttributeView.backgroundColor = [UIColor grayColor];
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
    } else { // 画笔属性视图显示时
        self.penAttributeView.hidden = YES;
    }
}

/**
 点击橡皮按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickEraserBtn:(UIButton *)sender {
    // 如果画笔属性视图已显示，将其隐藏
    if (self.penAttributeView.hidden == NO) {
        self.penAttributeView.hidden = YES;
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
    } else { // 橡皮属性视图显示时
        // 隐藏橡皮属性视图
        self.eraserAttributeView.hidden = YES;
    }
}

/**
 点击字体按钮后调用
 */
- (void)bottomToolsView:(LFHBottomToolsView *)view clickTextBtn:(UIButton *)sender {
    // 创建 Text Edit View
    LFHTextEditView *textEditView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LFHTextEditView class]) owner:nil options:nil] firstObject];
    textEditView.delegate = self;
    [self.view addSubview:textEditView];
    
    // 从底部动画推出并隐藏导航栏
    textEditView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        textEditView.frame = self.view.bounds;
        self.navigationController.navigationBar.hidden = YES;
    }];
}

#pragma mark - LFHHandleImageViewDelegate
/**
 Handle Image View 点击取消按钮后调用
 */
- (void)handleImageView:(LFHHandleImageView *)view clickCancelBtn:(UIButton *)sender {
    self.navigationController.navigationBar.hidden = NO;
}

/**
 Handle Image View 点击完成按钮后调用
 */
- (void)handleImageView:(LFHHandleImageView *)view clickFinishedBtn:(UIButton *)sender drawingImage:(UIImage *)image {
    self.navigationController.navigationBar.hidden = NO;
    // 将图片画到涂鸦板上
    self.drawingBoardView.image = image;
}

#pragma mark - LFHTextEditView
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
    self.navigationController.navigationBar.hidden = NO;
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
    [text drawAtPoint:CGPointMake(100, 100) withAttributes:dict];
}

#pragma mark - UShare
/**
 分享图片

 @param image 要分享的图片
 @param platformType 分享平台
 */
- (void)shareImage:(UIImage *)image toPlatformType:(UMSocialPlatformType )platformType {
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
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - 设置导航条
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
