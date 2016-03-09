//
//  ViewController.m
//  JustForMyWife
//
//  Created by geng lei on 16/3/9.
//  Copyright © 2016年 com.fengche.cn. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <GPUImage/GPUImage.h>

#import "ViewController.h"

@interface ViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *choiceBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"主页";
    [self.view addSubview:self.choiceBtn];
}

- (void)viewWillLayoutSubviews {
    [self.choiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
     [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Method

- (void)showActionSheet {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancleAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"打开照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self TakePhoto];
    }];
    UIAlertAction *destroyAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self LocalPhoto];
    }];
    [actionSheet addAction:cancleAlert];
    [actionSheet addAction:otherAction];
    [actionSheet addAction:destroyAction];
    [self presentViewController:actionSheet animated:YES completion:^{
        
    } ];
}

- (void)TakePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.delegate = self;
        pickerController.allowsEditing = YES;
        pickerController.sourceType = sourceType;
        [self presentViewController:pickerController animated:YES completion:^{
            
        }];
    }
                                                     
}

- (void)LocalPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Button Event

- (void)touchChoice:(UIButton *)sender {
    [self showActionSheet];
}

#pragma mark - Setter - Getter

- (UIButton *)choiceBtn {
    if (_choiceBtn == nil) {
        _choiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_choiceBtn setTitle:@"选择图片" forState:UIControlStateNormal];
        [_choiceBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_choiceBtn addTarget:self action:@selector(touchChoice:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _choiceBtn;
}

@end
