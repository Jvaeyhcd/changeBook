/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseConvertToCommonEmoticonsHelper.h"
#import "EaseEmoji.h"

@implementation EaseConvertToCommonEmoticonsHelper

#pragma mark - emotics

+ (NSString *)convertToCommonEmoticons:(NSString *)text
{
    int allEmoticsCount = (int)[EaseEmoji allEmoji].count;
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😊"
                                 withString:@":blush:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😃"
                                 withString:@":smiley:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😉"
                                 withString:@":wink:"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😮"
//                                 withString:@"[:-o]"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😋"
//                                 withString:@"[:p]"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😎"
//                                 withString:@"[(H)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😡"
                                 withString:@":rage:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😖"
                                 withString:@":confounded:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😳"
                                 withString:@":flushed:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😞"
                                 withString:@":disappointed:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😭"
                                 withString:@":sob:"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😐"
//                                 withString:@"[:|]"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😇"
//                                 withString:@"[(a)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😬"
//                                 withString:@"[8o|]"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😆"
//                                 withString:@"[8-|]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😱"
                                 withString:@":scream:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🎅"
                                 withString:@":santa:"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😴"
//                                 withString:@"[|-)]"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😕"
//                                 withString:@"[*-)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😷"
                                 withString:@":mask:"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😯"
//                                 withString:@"[:-*]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😏"
                                 withString:@":smirk:"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"😑"
//                                 withString:@"[8-)]"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"💖"
//                                 withString:@"[(|)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💔"
                                 withString:@":broken_heart:"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"🌙"
//                                 withString:@"[(S)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌟"
                                 withString:@":star2:"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"🌞"
//                                 withString:@"[(#)]"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"🌈"
//                                 withString:@"[(R)]"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        
//        [retText replaceOccurrencesOfString:@"😚"
//                                 withString:@"[(})]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"😍"
                                 withString:@":heart_eyes:"
                                    options:NSLiteralSearch
                                      range:range];

        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"💋"
//                                 withString:@"[(k)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌹"
                                 withString:@":rose:"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"🍂"
//                                 withString:@"[(W)]"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👍"
                                 withString:@":+1:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😔"
                                 withString:@":pensive:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😁"
                                 withString:@":grin:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😘"
                                 withString:@":kissing_heart:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😠"
                                 withString:@":angry:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😥"
                                 withString:@":disappointed_relieved:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😝"
                                 withString:@":stuck_out_tongue_closed_eyes:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😣"
                                 withString:@":persevere:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😒"
                                 withString:@":unamused:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😄"
                                 withString:@":smile:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😓"
                                 withString:@":sweat:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😂"
                                 withString:@":joy:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😢"
                                 withString:@":cry:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😜"
                                 withString:@":stuck_out_tongue_winking_eye:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😨"
                                 withString:@":fearful:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😰"
                                 withString:@":cold_sweat:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😵"
                                 withString:@":dizzy_face:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😪"
                                 withString:@":sleepy:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😌"
                                 withString:@":relieved:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"😈"
                                 withString:@":smiling_imp:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👻"
                                 withString:@":ghost:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🐶"
                                 withString:@":dog:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🐷"
                                 withString:@":pig:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🐱"
                                 withString:@":cat:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👎"
                                 withString:@":thumbsdown:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👊"
                                 withString:@":facepunch:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"✊"
                                 withString:@":fist:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"✌"
                                 withString:@":v:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💪"
                                 withString:@":muscle:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👏"
                                 withString:@":clap:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👈"
                                 withString:@":point_left:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👆"
                                 withString:@":point_up_2:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👉"
                                 withString:@":point_right:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👇"
                                 withString:@":point_down:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👌"
                                 withString:@":ok_hand:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"❤"
                                 withString:@":heart:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"☀"
                                 withString:@":sunny:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🌔"
                                 withString:@":waxing_gibbous_moon:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"⚡"
                                 withString:@":zap:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"☁"
                                 withString:@":cloud:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👄"
                                 withString:@":lips:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"☕"
                                 withString:@":coffee:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🎂"
                                 withString:@":birthday:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🕙"
                                 withString:@":birthday:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🍺"
                                 withString:@":beer:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🔍"
                                 withString:@":mag:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"📱"
                                 withString:@":iphone:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🏠"
                                 withString:@":house:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🚗"
                                 withString:@":car:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🎁"
                                 withString:@":gift:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"⚽"
                                 withString:@":soccer:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💣"
                                 withString:@":bomb:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💎"
                                 withString:@":gem:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"👽"
                                 withString:@":alien:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💯"
                                 withString:@":100:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💸"
                                 withString:@":money_with_wings:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🎮"
                                 withString:@":video_game:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💩"
                                 withString:@":poop:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🆘"
                                 withString:@":sos:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"💤"
                                 withString:@":zzz:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🎤"
                                 withString:@":microphone:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"☔"
                                 withString:@":umbrella:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"📖"
                                 withString:@":open_book:"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"🙏"
                                 withString:@":pray:"
                                    options:NSLiteralSearch
                                      range:range];
    }
    
    return retText;
}

+ (NSString *)convertToSystemEmoticons:(NSString *)text
{
    if (![text isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    if ([text length] == 0) {
        return @"";
    }
    int allEmoticsCount = (int)[[EaseEmoji allEmoji] count];
    NSMutableString *retText = [[NSMutableString alloc] initWithString:text];
    for(int i=0; i<allEmoticsCount; ++i) {
        NSRange range;
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":blush:"
                                 withString:@"😊"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":smiley:"
                                 withString:@"😃"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":wink:"
                                 withString:@"😉"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[:-o]"
//                                 withString:@"😮"
//                                    options:NSLiteralSearch
//                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[:p]"
//                                 withString:@"😋"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(H)]"
//                                 withString:@"😎"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":rage:"
                                 withString:@"😡"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":confounded:"
                                 withString:@"😖"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":flushed:"
                                 withString:@"😳"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":disappointed:"
                                 withString:@"😞"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":sob:"
                                 withString:@"😭"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[:|]"
//                                 withString:@"😐"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(a)]"
//                                 withString:@"😇"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[8o|]"
//                                 withString:@"😬"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[8-|]"
//                                 withString:@"😆"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":scream:"
                                 withString:@"😱"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":santa:"
                                 withString:@"🎅"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[|-)]"
//                                 withString:@"😴"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[*-)]"
//                                 withString:@"😕"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":mask:"
                                 withString:@"😷"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[:-*]"
//                                 withString:@"😯"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":smirk:"
                                 withString:@"😏"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[8-)]"
//                                 withString:@"😑"
//                                    options:NSLiteralSearch
//                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(|)]"
//                                 withString:@"💖"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":broken_heart:"
                                 withString:@"💔"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(S)]"
//                                 withString:@"🌙"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":star2:"
                                 withString:@"🌟"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(#)]"
//                                 withString:@"🌞"
//                                    options:NSLiteralSearch
//                                      range:range];
//        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(R)]"
//                                 withString:@"🌈"
//                                    options:NSLiteralSearch
//                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        
//        [retText replaceOccurrencesOfString:@"[(})]"
//                                 withString:@"😚"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@":heart_eyes:"
                                 withString:@"😍"
                                    options:NSLiteralSearch
                                      range:range];

        
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(k)]"
//                                 withString:@"💋"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":rose:"
                                 withString:@"🌹"
                                    options:NSLiteralSearch
                                      range:range];
        
//        range.location = 0;
//        range.length = retText.length;
//        [retText replaceOccurrencesOfString:@"[(W)]"
//                                 withString:@"🍂"
//                                    options:NSLiteralSearch
//                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":+1:"
                                 withString:@"👍"
                                    options:NSLiteralSearch
                                      range:range];
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":pensive:"
                                 withString:@"😔"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":grin:"
                                 withString:@"😁"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":kissing_heart:"
                                 withString:@"😘"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":angry:"
                                 withString:@"😠"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":disappointed_relieved:"
                                 withString:@"😥"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":stuck_out_tongue_closed_eyes:"
                                 withString:@"😝"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":persevere:"
                                 withString:@"😣"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":unamused:"
                                 withString:@"😒"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":smile:"
                                 withString:@"😄"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":sweat:"
                                 withString:@"😓"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":joy:"
                                 withString:@"😂"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":cry:"
                                 withString:@"😢"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":stuck_out_tongue_winking_eye:"
                                 withString:@"😜"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":fearful:"
                                 withString:@"😨"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":cold_sweat:"
                                 withString:@"😰"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":dizzy_face:"
                                 withString:@"😵"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":sleepy:"
                                 withString:@"😪"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":relieved:"
                                 withString:@"😌"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":smiling_imp:"
                                 withString:@"😈"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":ghost:"
                                 withString:@"👻"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":dog:"
                                 withString:@"🐶"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":pig:"
                                 withString:@"🐷"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":cat:"
                                 withString:@"🐱"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":thumbsdown:"
                                 withString:@"👎"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":facepunch:"
                                 withString:@"👊"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":fist:"
                                 withString:@"✊"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":v:"
                                 withString:@"✌"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":muscle:"
                                 withString:@"💪"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":clap:"
                                 withString:@"👏"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":point_left:"
                                 withString:@"👈"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":point_up_2:"
                                 withString:@"👆"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":point_right:"
                                 withString:@"👉"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":point_down:"
                                 withString:@"👇"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":ok_hand:"
                                 withString:@"👌"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":heart:"
                                 withString:@"❤"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":sunny:"
                                 withString:@"☀"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":waxing_gibbous_moon:"
                                 withString:@"🌔"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":zap:"
                                 withString:@"⚡"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":cloud:"
                                 withString:@"☁"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":lips:"
                                 withString:@"👄"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":coffee:"
                                 withString:@"☕"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":birthday:"
                                 withString:@"🎂"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":clock10:"
                                 withString:@"🕙"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":beer:"
                                 withString:@"🍺"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":mag:"
                                 withString:@"🔍"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":iphone:"
                                 withString:@"📱"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":house:"
                                 withString:@"🏠"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":car:"
                                 withString:@"🚗"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":gift:"
                                 withString:@"🎁"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":soccer:"
                                 withString:@"⚽"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":bomb:"
                                 withString:@"💣"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":gem:"
                                 withString:@"💎"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":alien:"
                                 withString:@"👽"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":100:"
                                 withString:@"💯"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":money_with_wings:"
                                 withString:@"💸"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":video_game:"
                                 withString:@"🎮"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":poop:"
                                 withString:@"💩"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":sos:"
                                 withString:@"🆘"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":zzz:"
                                 withString:@"💤"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":microphone:"
                                 withString:@"🎤"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":umbrella:"
                                 withString:@"☔"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":open_book:"
                                 withString:@"📖"
                                    options:NSLiteralSearch
                                      range:range];
        
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@":pray:"
                                 withString:@"🙏"
                                    options:NSLiteralSearch
                                      range:range];
    }
    
    return retText;
}

@end
