//
//  UITapImageView.h
//  timeLine
//
//  Created by llbt on 16/3/3.
//  Copyright © 2016年 llbt. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface UITapImageView : UIImageView

- (void)addTapBlock:(void(^)(id obj))tapAction;

@end
