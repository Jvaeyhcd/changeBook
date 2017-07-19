//
//  NSString+Polesapp.h
//  govlan
//
//  Created by polesapp-hcd on 2016/9/26.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Polesapp)

- (BOOL)isUrl;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (NSString *)MD5Encode;
- (BOOL)isBlankString;
- (NSString *)removeAllSpaceAndNewline;
- (NSString *)removeBothSideSpaceAndNewline;
- (NSString *)replaceMoreThan10SpaceTo10Space;

- (NSString *)commentRuledString;
@end
