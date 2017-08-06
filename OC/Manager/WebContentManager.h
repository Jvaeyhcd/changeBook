//
//  WebContentManager.h
//  govlan
//
//  Created by Jvaeyhcd on 2016/11/28.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebContentManager : NSObject

+ (instancetype)sharedManager;
+ (NSString *)articlePatternedWithContent:(NSString *)content;

@end
