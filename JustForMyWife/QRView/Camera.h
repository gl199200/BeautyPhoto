//
//  Camera.h
//  JustForMyWife
//
//  Created by geng lei on 16/3/10.
//  Copyright © 2016年 com.fengche.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraDelegate <NSObject>

@optional
/**
 *  传递扫描信息
 */
- (void)didFishedRedingQRCode:(NSString *)QRMessage;
/**
 *  返回事件
 */
- (void)actionBack;

@end

@interface Camera : UIView
/**
 *  在controller中实例化MYScanView
 *
 *  @param controller <#controller description#>
 *
 *  @return MYScanView
 */
+ (instancetype)createScanViewInController:(UIViewController *)controller scanBounds:(CGRect)rect;

/**
 *
 */
@property (nonatomic, weak) id<CameraDelegate>delegate;


@end
