//
//  HcdSideMenu.h
//  changeBook
//
//  Created by Jvaeyhcd on 28/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+HcdSideMenu.h"

@interface HcdSideMenu : UIViewController

//主视图
@property (nonatomic, strong) UIViewController *rootViewController;
//左侧视图
@property (nonatomic, strong) UIViewController *leftViewController;
//右侧视图
@property (nonatomic, strong) UIViewController *rightViewController;
//菜单宽度
@property (nonatomic, assign, readonly) CGFloat menuWidth;
//留白宽度
@property (nonatomic, assign, readonly) CGFloat emptyWidth;
//是否允许滚动
@property (nonatomic ,assign) BOOL slideEnabled;
//是否支持手势
@property (assign, readwrite, nonatomic) BOOL panGestureEnabled;
//创建方法
-(instancetype)initWithRootViewController:(UIViewController*)rootViewController;
//显示主视图
-(void)showRootViewControllerAnimated:(BOOL)animated;
//显示左侧菜单
-(void)showLeftViewControllerAnimated:(BOOL)animated;
//显示右侧菜单
-(void)showRightViewControllerAnimated:(BOOL)animated;

@end
