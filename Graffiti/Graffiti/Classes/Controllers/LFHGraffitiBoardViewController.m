//
//  LFHGraffitiBoardViewController.m
//  Graffiti
//
//  Created by lifuheng on 2017/4/16.
//  Copyright © 2017年 LiFuheng. All rights reserved.
//
#define BOTTOMTOOLSVIEW_HEIGHT 49

#import "LFHGraffitiBoardViewController.h"
#import "LFHGFDrawingBoardView.h"
#import "LFHGFBottomToolsView.h"
#import "LFHGFHandleImageView.h"
#import "LFHImagePickerViewController.h"
#import <Masonry.h>
#import <UMSocialCore/UMSocialCore.h>

@interface LFHGraffitiBoardViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, LFHGFBottomToolsViewDelegate, LFHGFHandleImageViewDelegate>

/* Drawing Board View */
@property (nonatomic, weak) LFHGFDrawingBoardView *drawingBoardView;

/* Bottom Tools View */
@property (nonatomic, weak) UIView *bottomToolsView;

@end

@implementation LFHGraffitiBoardViewController

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
    // 前进按钮
    UIBarButtonItem *forwardBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward"] style:UIBarButtonItemStylePlain target:self action:@selector(forwardBtnClick)];
    // 相册按钮
    UIBarButtonItem *photoLibraryBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"photolibrary"] style:UIBarButtonItemStylePlain target:self action:@selector(photoLibraryBtnClick)];
    // 清屏按钮
    UIBarButtonItem *clearBtn = [[UIBarButtonItem alloc] initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(clearBtnClick)];
    // 保存/分享按钮
    UIBarButtonItem *saveOrShareBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存/分享" style:UIBarButtonItemStylePlain target:self action:@selector(saveOrShareBtnClick)];
    
    // 打包添加到 NavigationItem
    NSArray *barButtonItemArray = @[saveOrShareBtn, clearBtn, photoLibraryBtn, forwardBtn, backwardBtn];
    self.navigationItem.rightBarButtonItems = barButtonItemArray;
}

/**
 初始化UI布局
 */
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    /* 画板视图 */
    LFHGFDrawingBoardView *drawingBoardView = [[LFHGFDrawingBoardView alloc] init];
    self.drawingBoardView = drawingBoardView;
    drawingBoardView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawingBoardView];
    
    /* 底部工具视图 */
    LFHGFBottomToolsView *bottomToolsView = [[LFHGFBottomToolsView alloc] init];
    self.bottomToolsView = bottomToolsView;
    bottomToolsView.backgroundColor = [UIColor darkGrayColor];
    bottomToolsView.delegate = self;
    [self.view addSubview:bottomToolsView];

    /********** 添加约束 **********/
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
    /******************************/
    
}

#pragma mark - Button Click
- (void)backwardBtnClick {
    [self.drawingBoardView backwardPath];
}
- (void)forwardBtnClick {
    [self.drawingBoardView forwardPath];
}
- (void)photoLibraryBtnClick {
    LFHImagePickerViewController *imagePickerVC = [[LFHImagePickerViewController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerVC.delegate = self;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (void)clearBtnClick {
    [self.drawingBoardView clearDrawing];
    
}
- (void)saveOrShareBtnClick {
    // 创建并显示 AlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存到系统相册/分享到微信、微博" message:@"lfhnb" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
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
 点击图片后调用
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 取出图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 创建 Handle Image View
    LFHGFHandleImageView *handleImageView = [[LFHGFHandleImageView alloc] init];
    handleImageView.image = image;
    handleImageView.delegate = self;
    [self.view addSubview:handleImageView];
    
    /* 添加约束 */
    __weak __typeof(self)weakSelf = self;
    [handleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.drawingBoardView);
    }];
    self.navigationController.navigationBar.hidden = YES;
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

#pragma mark - LFHGFBottomToolsViewDelegate
- (void)bottomToolsView:(LFHGFBottomToolsView *)view ClickPenBtn:(UIButton *)sender {
    [self.drawingBoardView drawWithPen];
}

- (void)bottomToolsView:(LFHGFBottomToolsView *)view ClickEraserBtn:(UIButton *)sender {
    [self.drawingBoardView drawWithEraser];
}

#pragma mark - LFHGFHandleImageViewDelegate
- (void)handleImageView:(LFHGFHandleImageView *)view clickCancelBtn:(UIButton *)sender {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)handleImageView:(LFHGFHandleImageView *)view clickFinishedBtnWithNewImage:(UIImage *)image {
    self.navigationController.navigationBar.hidden = NO;
    self.drawingBoardView.image = image;
}

#pragma mark - UShare
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

#pragma mark -
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
