//
//  NSObject+Polesapp.h
//  qiangtoubao
//
//  Created by polesapp-hcd on 16/7/23.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Polesapp)

- (void)showHudTipStr:(NSString *)tipStr inView:(UIView *)view;
- (void)showHudTipStr:(NSString *)tipStr;
- (void)showHudLoadingTipStr:(NSString *)tipStr;
- (void)hideHud;
- (void)hideHudInView:(UIView *)view;
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName;
//创建缓存文件夹
+ (BOOL)createDirInCache:(NSString *)dirName;

- (UIImage *)screenShot;

@end
