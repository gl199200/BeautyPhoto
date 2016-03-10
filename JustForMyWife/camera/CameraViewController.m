//
//  CameraViewController.m
//  JustForMyWife
//
//  Created by geng lei on 16/3/10.
//  Copyright © 2016年 com.fengche.cn. All rights reserved.
//

#import <GPUImage/GPUImage.h>

#import "CameraViewController.h"
#import "Camera.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface CameraViewController ()

@property (nonatomic, strong) Camera *cameraView;

@end

@implementation CameraViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"刘之璐";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.cameraView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter - Getter

- (Camera *)cameraView {
    if (_cameraView == nil) {
        _cameraView = [Camera createScanViewInController:self scanBounds:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
//        _cameraView = [Camera createScanViewInController:self scanBounds:[UIScreen mainScreen].bounds];
    }
    return _cameraView;
}


@end
