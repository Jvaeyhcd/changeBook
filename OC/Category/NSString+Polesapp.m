//
//  NSString+Polesapp.m
//  govlan
//
//  Created by polesapp-hcd on 2016/9/26.
//  Copyright © 2016年 Polesapp. All rights reserved.
//

#import "NSString+Polesapp.h"

@implementation NSString (Polesapp)

- (BOOL)isUrl
{
    NSString *		regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        resultSize = [self boundingRectWithSize:size
                                        options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                     attributes:@{NSFontAttributeName: font}
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        //        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
        //
        //        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //        [paragraphStyle setLineSpacing:2.0];
        //
        //        [attributedStr addAttribute:NSParagraphStyleAttributeName
        //                              value:paragraphStyle
        //                              range:NSMakeRange(0, [self length])];
        //        resultSize = [attributedStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
#endif
    }
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    //    if ([self containsEmoji]) {
    //        resultSize.height += 10;
    //    }
    return resultSize;
}

- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}

- (NSString *)MD5Encode{
    const char * pointer = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(pointer, (CC_LONG)strlen(pointer), md5Buffer);
    
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [string appendFormat:@"%02x",md5Buffer[i]];
    
    return string;
}

- (BOOL)isBlankString {
    if (self == nil) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
    }
    return NO;
}

/**
 * 移除字符串中所有的空白、换行和Tab
 */
- (NSString *)removeAllSpaceAndNewline {
    
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
    
}

/**
 * 移除字符串前后的空白、换行和Tab
 *
 */
- (NSString *)removeBothSideSpaceAndNewline {
    
    NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return text;
}

/**
 * 将十个以上的空格替换成十个
 *
 */
- (NSString *)replaceMoreThan10SpaceTo10Space {
    
    NSMutableString *result = [NSMutableString string];
    
    // 连续空格的个数
    NSInteger seriesSpaceNumber = 0;
    
    NSInteger i = 0, len = self.length;
    
    for (; i < len; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *s = [self substringWithRange:range];
        if ([s  isEqual: @" "] || [s  isEqual: @"\t"]) {
            if (seriesSpaceNumber < 10) {
                [result appendString:s];
                seriesSpaceNumber += 1;
            }
        } else {
            [result appendString:s];
            seriesSpaceNumber = 0;
        }
//        if (c == ' ' || c == '\t') {
//            if (seriesSpaceNumber < 10) {
//                [result appendFormat:@"%02x", c];
//                seriesSpaceNumber += 1;
//            }
//        } else {
//            [result appendFormat:@"%02x", c];
//            seriesSpaceNumber = 0;
//        }
    }
    
    return result;
}

/**
 * 发表评论按规则格式化后的字符串
 */
- (NSString *)commentRuledString {
    // 去掉头尾的空格、换行和Tab
    NSString *content = [self removeBothSideSpaceAndNewline];
    // 将换行替换成空格
    content = [content stringByReplacingOccurrencesOfString: @"\n" withString: @" "];
    // 将中间连续十个以上的空格替换成十个
    content = [content replaceMoreThan10SpaceTo10Space];
    
    return content;
}

@end
