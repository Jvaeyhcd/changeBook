//
//  PersistentBackgroundLabel.m
//  govlan
//
//  Created by Jvaeyhcd on 14/12/2016.
//  Copyright © 2016 Polesapp. All rights reserved.
//

#import "PersistentBackgroundLabel.h"

@implementation PersistentBackgroundLabel

- (void)setPersistentBackgroundColor:(UIColor*)color {
    super.backgroundColor = color;
}

- (void)setBackgroundColor:(UIColor *)color {
    // do nothing - background color never changes
}

@end
