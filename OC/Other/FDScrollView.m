//
//  FDScrollView.m
//  govlan
//
//  Created by Jvaeyhcd on 29/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

#import "FDScrollView.h"

@implementation FDScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.contentOffset.x <= 0) {
        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
            return YES;
        }
    }
    return NO;
}

@end
