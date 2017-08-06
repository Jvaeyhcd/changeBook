//
//  WebContentManager.m
//  govlan
//
//  Created by Jvaeyhcd on 2016/11/28.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import "WebContentManager.h"

@interface WebContentManager ()
@property (strong, nonatomic) NSString *article_pattern_htmlStr;
@end

@implementation WebContentManager
+ (instancetype)sharedManager {
    static WebContentManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"html.bundle/article" ofType:@"html"];
        NSError *error = nil;
        shared_manager.article_pattern_htmlStr = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"article_pattern_htmlStr fail: %@", error.description);
        }
    });
    return shared_manager;
}

+ (NSString *)articlePatternedWithContent:(NSString *)content{
    return [[self sharedManager] articlePatternedWithContent:content];
}

- (NSString *)articlePatternedWithContent:(NSString *)content{
    if (!content) {
        return @"";
    }
    NSString *patternedStr = [self.article_pattern_htmlStr stringByReplacingOccurrencesOfString:@"${webview_content}" withString:content];
    return patternedStr;
}

@end
