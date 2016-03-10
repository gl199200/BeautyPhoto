//
//  Camera.m
//  JustForMyWife
//
//  Created by geng lei on 16/3/10.
//  Copyright © 2016年 com.fengche.cn. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>

#import "Camera.h"

@interface Camera () <AVCaptureMetadataOutputObjectsDelegate>
/**
 *  管理输入(AVCaptureInput)和输出(AVCaptureOutput)流，包含开启和停止会话方法。
 */
@property (nonatomic, strong) AVCaptureSession *captureSession;
/**
 *  设备输入类。这个类用来表示输入数据的硬件设备，配置抽象设备的port
 */
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
/**
 *  CALayer的一个子类，显示捕获到的相机输出流。
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
/**
 *   输出类。这个支持二维码、条形码等图像数据的识别
 */
@property (nonatomic, strong) AVCaptureMetadataOutput *metadataOutput;

@end

@implementation Camera

+ (instancetype)createScanViewInController:(UIViewController *)controller scanBounds:(CGRect)rect {
    if (!controller) {
        return nil;
    }
    Camera *camera = [[Camera alloc]initWithFrame:rect];
    if ([controller conformsToProtocol:@protocol(CameraDelegate)] ) {
        camera.delegate = (UIViewController<CameraDelegate> *)controller;
    }
    return camera;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2f];
        [self.layer addSublayer:self.previewLayer];
         [self.captureSession startRunning];
    }
    return self;
    
}



#pragma mark - Private Method

- (void)setupIODevice {
    if ([self.captureSession canAddInput:self.deviceInput]) {
        [self.captureSession addInput:self.deviceInput];
    }
    if ([self.captureSession canAddOutput:self.metadataOutput]) {
        [self.captureSession addOutput:self.metadataOutput];
          self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
}


#pragma mark - Setter - Getter 

- (AVCaptureSession *)captureSession {
    if (_captureSession == nil) {
        _captureSession = [[AVCaptureSession alloc]init];
        [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
        [self setupIODevice];
    }
    return _captureSession;
}

- (AVCaptureDeviceInput *)deviceInput {
    if (_deviceInput == nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error) {
            NSLog(@"警告：该设备是模拟器，并没有摄像头！");
            return nil;
        }
    }
    return _deviceInput;
}

- (AVCaptureMetadataOutput *)metadataOutput {
    if (!_metadataOutput) {
        _metadataOutput = [AVCaptureMetadataOutput new];
        [_metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _metadataOutput;
}

- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = self.bounds;
    }
    return _previewLayer;
}

@end
