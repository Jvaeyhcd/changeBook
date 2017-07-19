//
//  HcdReplyView.h
//  govlan
//
//  Created by polesapp-hcd on 2016/11/17.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

typedef void(^CommitReplyBlock)(NSString *content, NSString *score);

@interface HcdReplyView : UIView

@property (nonatomic, weak  ) NSString * placeHolder;
@property (nonatomic, strong) CommitReplyBlock commitReplyBlock;

- (void)showReplyInView:(UIView *)view;
- (void)hideReplayView;

- (instancetype)initWithFrame:(CGRect)frame showRateStar:(BOOL)showRateStar;

@end
