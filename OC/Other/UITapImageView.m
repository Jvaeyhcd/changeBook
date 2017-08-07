//
//  UITapImageView.m
//  timeLine
//
//  Created by llbt on 16/3/3.
//  Copyright © 2016年 llbt. All rights reserved.
//

#import "UITapImageView.h"

@interface UITapImageView()
@property (nonatomic,copy)void (^tapAction)(id obj);
@end
@implementation UITapImageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //裁切成圆形
        [self clipperCircle];
    }
    return self;
}

- (void)clipperCircle {
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}
- (void)addTapBlock:(void (^)(id obj))tapAction {
    self.tapAction = tapAction;
    
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:tap];
    }
}

- (void)tapGesture {
    if (self.tapAction) {
        self.tapAction(self);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
