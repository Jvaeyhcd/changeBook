//
//  UIViewController+HcdSideMenu.m
//  changeBook
//
//  Created by Jvaeyhcd on 28/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

#import "UIViewController+HcdSideMenu.h"
#import "HcdSideMenu.h"

@implementation UIViewController (HcdSideMenu)

- (HcdSideMenu *)hcd_sideMenu {
    UIViewController *sideMenu = self.parentViewController;
    while (sideMenu) {
        if ([sideMenu isKindOfClass:[HcdSideMenu class]]) {
            return (HcdSideMenu *)sideMenu;
        } else if (sideMenu.parentViewController && sideMenu.parentViewController != sideMenu) {
            sideMenu = sideMenu.parentViewController;
        } else {
            sideMenu = nil;
        }
    }
    return nil;
}

@end
