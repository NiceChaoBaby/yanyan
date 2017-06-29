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
        //1
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_001"
                                 withString:@"[):]"
                                    options:NSLiteralSearch
                                      range:range];
        //2
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_002"
                                 withString:@"[:D]"
                                    options:NSLiteralSearch
                                      range:range];
        //3
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_003"
                                 withString:@"[;)]"
                                    options:NSLiteralSearch
                                      range:range];
        //4
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_004"
                                 withString:@"[:-o]"
                                    options:NSLiteralSearch
                                      range:range];
        //5
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_005"
                                 withString:@"[:p]"
                                    options:NSLiteralSearch
                                      range:range];
        //6
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_006"
                                 withString:@"[(H)]"
                                    options:NSLiteralSearch
                                      range:range];
        //7
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_007"
                                 withString:@"[:@]"
                                    options:NSLiteralSearch
                                      range:range];
        //8
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_008"
                                 withString:@"[:s]"
                                    options:NSLiteralSearch
                                      range:range];
        //9
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_009"
                                 withString:@"[:$]"
                                    options:NSLiteralSearch
                                      range:range];
        //10
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_010"
                                 withString:@"[:(]"
                                    options:NSLiteralSearch
                                      range:range];
        //11
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_011"
                                 withString:@"[:'(]"
                                    options:NSLiteralSearch
                                      range:range];
        //12
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_012"
                                 withString:@"[:|]"
                                    options:NSLiteralSearch
                                      range:range];
        //13
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_013"
                                 withString:@"[(a)]"
                                    options:NSLiteralSearch
                                      range:range];
        //14
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_014"
                                 withString:@"[8o|]"
                                    options:NSLiteralSearch
                                      range:range];
        //15
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_015"
                                 withString:@"[8-|]"
                                    options:NSLiteralSearch
                                      range:range];
        //16
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_016"
                                 withString:@"[+o(]"
                                    options:NSLiteralSearch
                                      range:range];
        //17
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_017"
                                 withString:@"[<o)]"
                                    options:NSLiteralSearch
                                      range:range];
        //18
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_018"
                                 withString:@"[|-)]"
                                    options:NSLiteralSearch
                                      range:range];
        //19
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_019"
                                 withString:@"[*-)]"
                                    options:NSLiteralSearch
                                      range:range];
        //20
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_020"
                                 withString:@"[:-#]"
                                    options:NSLiteralSearch
                                      range:range];
        //21
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_021"
                                 withString:@"[:-*]"
                                    options:NSLiteralSearch
                                      range:range];
        //22
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_022"
                                 withString:@"[^o)]"
                                    options:NSLiteralSearch
                                      range:range];
        //23
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_023"
                                 withString:@"[8-)]"
                                    options:NSLiteralSearch
                                      range:range];
        //24
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_024"
                                 withString:@"[(/|)]"
                                    options:NSLiteralSearch
                                      range:range];
        //25
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_025"
                                 withString:@"[(/u)]"
                                    options:NSLiteralSearch
                                      range:range];
        //26
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_026"
                                 withString:@"[(/S)]"
                                    options:NSLiteralSearch
                                      range:range];
        //27
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_027"
                                 withString:@"[(/*)]"
                                    options:NSLiteralSearch
                                      range:range];
        //28
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_028"
                                 withString:@"[(/#)]"
                                    options:NSLiteralSearch
                                      range:range];
        //29
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_029"
                                 withString:@"[(/R)]"
                                    options:NSLiteralSearch
                                      range:range];
        //30
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"f_static_030"
                                 withString:@"[(/{)]"
                                    options:NSLiteralSearch
                                      range:range];
        //31
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"f_static_031"
                                 withString:@"[(/})]"
                                    options:NSLiteralSearch
                                      range:range];

        //32
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_032"
                                 withString:@"[(/k)]"
                                    options:NSLiteralSearch
                                      range:range];
        //33
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_033"
                                 withString:@"[(/F)]"
                                    options:NSLiteralSearch
                                      range:range];
        //34
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_034"
                                 withString:@"[(/W)]"
                                    options:NSLiteralSearch
                                      range:range];
        //35
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_035"
                                 withString:@"[(/D)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        //36
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_036"
                                 withString:@"[(/SH)]"
                                    options:NSLiteralSearch
                                      range:range];
        //37
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_037"
                                 withString:@"[(/88)]"
                                    options:NSLiteralSearch
                                      range:range];
        //38
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_038"
                                 withString:@"[(/JY)]"
                                    options:NSLiteralSearch
                                      range:range];
        
        //39
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_039"
                                 withString:@"[(/BX)]"
                                    options:NSLiteralSearch
                                      range:range];
        //40
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_040"
                                 withString:@"[(/AW)]"
                                    options:NSLiteralSearch
                                      range:range];
        //41
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_041"
                                 withString:@"[(/KL)]"
                                    options:NSLiteralSearch
                                      range:range];
        //42
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_042"
                                 withString:@"[(/QF)]"
                                    options:NSLiteralSearch
                                      range:range];
        //43
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_043"
                                 withString:@"[(/:X)]"
                                    options:NSLiteralSearch
                                      range:range];
        //44
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_044"
                                 withString:@"[(/FW)]"
                                    options:NSLiteralSearch
                                      range:range];
        //45
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_045"
                                 withString:@"[(/ZT)]"
                                    options:NSLiteralSearch
                                      range:range];
        //46
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_046"
                                 withString:@"[(/pen)]"
                                    options:NSLiteralSearch
                                      range:range];
        //47
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_047"
                                 withString:@"[(/KULOU)]"
                                    options:NSLiteralSearch
                                      range:range];
        //48
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_048"
                                 withString:@"[(/GL)]"
                                    options:NSLiteralSearch
                                      range:range];
        //49
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_049"
                                 withString:@"[(/JS)]"
                                    options:NSLiteralSearch
                                      range:range];
        //50
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_050"
                                 withString:@"[(/qs)]"
                                    options:NSLiteralSearch
                                      range:range];
        //51
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_051"
                                 withString:@"[(/BP)]"
                                    options:NSLiteralSearch
                                      range:range];
        //52
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_052"
                                 withString:@"[(/qiang)]"
                                    options:NSLiteralSearch
                                      range:range];
        //53
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_053"
                                 withString:@"[(/ruo)]"
                                    options:NSLiteralSearch
                                      range:range];
        //54
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_054"
                                 withString:@"[(/hd)]"
                                    options:NSLiteralSearch
                                      range:range];
        //55
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_055"
                                 withString:@"[(/shl)]"
                                    options:NSLiteralSearch
                                      range:range];
        //56
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_056"
                                 withString:@"[(/gy)]"
                                    options:NSLiteralSearch
                                      range:range];
        //57
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_057"
                                 withString:@"[(/qidao)]"
                                    options:NSLiteralSearch
                                      range:range];
        //58
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_058"
                                 withString:@"[(/yao)]"
                                    options:NSLiteralSearch
                                      range:range];
        //59
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_059"
                                 withString:@"[(/feizao)]"
                                    options:NSLiteralSearch
                                      range:range];
        //60
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_060"
                                 withString:@"[(/yl)]"
                                    options:NSLiteralSearch
                                      range:range];
        //61
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_061"
                                 withString:@"[(/ty)]"
                                    options:NSLiteralSearch
                                      range:range];
        //62
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_062"
                                 withString:@"[(/ws)]"
                                    options:NSLiteralSearch
                                      range:range];
        //63
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_063"
                                 withString:@"[(/xin)]"
                                    options:NSLiteralSearch
                                      range:range];
        //64
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_064"
                                 withString:@"[(/xs)]"
                                    options:NSLiteralSearch
                                      range:range];
        //65
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_065"
                                 withString:@"[(/mg)]"
                                    options:NSLiteralSearch
                                      range:range];
        //66
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_066"
                                 withString:@"[(/lw)]"
                                    options:NSLiteralSearch
                                      range:range];
        //67
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_067"
                                 withString:@"[(/ch)]"
                                    options:NSLiteralSearch
                                      range:range];
        //68
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_068"
                                 withString:@"[(/aini)]"
                                    options:NSLiteralSearch
                                      range:range];
        //69
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_069"
                                 withString:@"[(/dabian)]"
                                    options:NSLiteralSearch
                                      range:range];
        //70
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_070"
                                 withString:@"[(/kf)]"
                                    options:NSLiteralSearch
                                      range:range];
        //71
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_071"
                                 withString:@"[(/yinyue)]"
                                    options:NSLiteralSearch
                                      range:range];
        //72
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_072"
                                 withString:@"[(/dg)]"
                                    options:NSLiteralSearch
                                      range:range];
        //73
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_073"
                                 withString:@"[(/huashu)]"
                                    options:NSLiteralSearch
                                      range:range];
        //74
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_074"
                                 withString:@"[(/dao)]"
                                    options:NSLiteralSearch
                                      range:range];
        //75
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"f_static_075"
                                 withString:@"[(/5mao)]"
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
        //1
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[):]"
                                 withString:@"f_static_001"
                                    options:NSLiteralSearch
                                      range:range];
        //2
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:D]"
                                 withString:@"f_static_002"
                                    options:NSLiteralSearch
                                      range:range];
        //3
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[;)]"
                                 withString:@"f_static_003"
                                    options:NSLiteralSearch
                                      range:range];
        //4
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-o]"
                                 withString:@"f_static_004"
                                    options:NSLiteralSearch
                                      range:range];
        //5
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:p]"
                                 withString:@"f_static_005"
                                    options:NSLiteralSearch
                                      range:range];
        //6
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(H)]"
                                 withString:@"f_static_006"
                                    options:NSLiteralSearch
                                      range:range];
        //7
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:@]"
                                 withString:@"f_static_007"
                                    options:NSLiteralSearch
                                      range:range];
        //8
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:s]"
                                 withString:@"f_static_008"
                                    options:NSLiteralSearch
                                      range:range];
        //9
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:$]"
                                 withString:@"f_static_009"
                                    options:NSLiteralSearch
                                      range:range];
        //10
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:(]"
                                 withString:@"f_static_010"
                                    options:NSLiteralSearch
                                      range:range];
        //11
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:'(]"
                                 withString:@"f_static_011"
                                    options:NSLiteralSearch
                                      range:range];
        //12
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:|]"
                                 withString:@"f_static_012"
                                    options:NSLiteralSearch
                                      range:range];
        //13
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(a)]"
                                 withString:@"f_static_013"
                                    options:NSLiteralSearch
                                      range:range];
        //14
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8o|]"
                                 withString:@"f_static_014"
                                    options:NSLiteralSearch
                                      range:range];
        //15
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8-|]"
                                 withString:@"f_static_015"
                                    options:NSLiteralSearch
                                      range:range];
        //16
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[+o(]"
                                 withString:@"f_static_016"
                                    options:NSLiteralSearch
                                      range:range];
        //17
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[<o)]"
                                 withString:@"f_static_017"
                                    options:NSLiteralSearch
                                      range:range];
        //18
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[|-)]"
                                 withString:@"f_static_018"
                                    options:NSLiteralSearch
                                      range:range];
        //19
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[*-)]"
                                 withString:@"f_static_019"
                                    options:NSLiteralSearch
                                      range:range];
        //20
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-#]"
                                 withString:@"f_static_020"
                                    options:NSLiteralSearch
                                      range:range];
        //21
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[:-*]"
                                 withString:@"f_static_021"
                                    options:NSLiteralSearch
                                      range:range];
        //22
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[^o)]"
                                 withString:@"f_static_022"
                                    options:NSLiteralSearch
                                      range:range];
        //23
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[8-)]"
                                 withString:@"f_static_023"
                                    options:NSLiteralSearch
                                      range:range];
        //24
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/|)]"
                                 withString:@"f_static_024"
                                    options:NSLiteralSearch
                                      range:range];
        //25
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/u)]"
                                 withString:@"f_static_025"
                                    options:NSLiteralSearch
                                      range:range];
        //26
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/S)]"
                                 withString:@"f_static_026"
                                    options:NSLiteralSearch
                                      range:range];
        //27
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/*)]"
                                 withString:@"f_static_027"
                                    options:NSLiteralSearch
                                      range:range];
        //28
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/#)]"
                                 withString:@"f_static_028"
                                    options:NSLiteralSearch
                                      range:range];
        //29
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/R)]"
                                 withString:@"f_static_029"
                                    options:NSLiteralSearch
                                      range:range];
        //30
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"[(/{)]"
                                 withString:@"f_static_030"
                                    options:NSLiteralSearch
                                      range:range];
        //31
        range.location = 0;
        range.length = retText.length;
        
        [retText replaceOccurrencesOfString:@"[(/})]"
                                 withString:@"f_static_031"
                                    options:NSLiteralSearch
                                      range:range];

        
        //32
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/k)]"
                                 withString:@"f_static_032"
                                    options:NSLiteralSearch
                                      range:range];
        //33
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/F)]"
                                 withString:@"f_static_033"
                                    options:NSLiteralSearch
                                      range:range];
        //34
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/W)]"
                                 withString:@"f_static_034"
                                    options:NSLiteralSearch
                                      range:range];
        //35
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/D)]"
                                 withString:@"f_static_035"
                                    options:NSLiteralSearch
                                      range:range];
        //36
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/SH)]"
                                 withString:@"f_static_036"
                                    options:NSLiteralSearch
                                      range:range];
        //37
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/88)]"
                                 withString:@"f_static_037"
                                    options:NSLiteralSearch
                                      range:range];
        //38
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/JY)]"
                                 withString:@"f_static_038"
                                    options:NSLiteralSearch
                                      range:range];
        //39
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/BX)]"
                                 withString:@"f_static_039"
                                    options:NSLiteralSearch
                                      range:range];
        //40
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/AW)]"
                                 withString:@"f_static_040"
                                    options:NSLiteralSearch
                                      range:range];
        //41
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/KL)]"
                                 withString:@"f_static_041"
                                    options:NSLiteralSearch
                                      range:range];
        //42
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/QF)]"
                                 withString:@"f_static_042"
                                    options:NSLiteralSearch
                                      range:range];
        //43
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/:X)]"
                                 withString:@"f_static_043"
                                    options:NSLiteralSearch
                                      range:range];
        //44
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/FW)]"
                                 withString:@"f_static_044"
                                    options:NSLiteralSearch
                                      range:range];
        //45
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/ZT)]"
                                 withString:@"f_static_045"
                                    options:NSLiteralSearch
                                      range:range];
        //46
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/pen)]"
                                 withString:@"f_static_046"
                                    options:NSLiteralSearch
                                      range:range];
        //47
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/KULOU)]"
                                 withString:@"f_static_047"
                                    options:NSLiteralSearch
                                      range:range];
        //48
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/GL)]"
                                 withString:@"f_static_048"
                                    options:NSLiteralSearch
                                      range:range];
        //49
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/JS)]"
                                 withString:@"f_static_049"
                                    options:NSLiteralSearch
                                      range:range];
        //50
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/qs)]"
                                 withString:@"f_static_050"
                                    options:NSLiteralSearch
                                      range:range];
        //51
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/BP)]"
                                 withString:@"f_static_051"
                                    options:NSLiteralSearch
                                      range:range];
        //52
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/qiang)]"
                                 withString:@"f_static_052"
                                    options:NSLiteralSearch
                                      range:range];
        //53
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/ruo)]"
                                 withString:@"f_static_053"
                                    options:NSLiteralSearch
                                      range:range];
        //54
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/hd)]"
                                 withString:@"f_static_054"
                                    options:NSLiteralSearch
                                      range:range];
        //55
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/shl)]"
                                 withString:@"f_static_055"
                                    options:NSLiteralSearch
                                      range:range];
        //56
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/gy)]"
                                 withString:@"f_static_056"
                                    options:NSLiteralSearch
                                      range:range];
        //57
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/qidao)]"
                                 withString:@"f_static_057"
                                    options:NSLiteralSearch
                                      range:range];
        //58
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/yao)]"
                                 withString:@"f_static_058"
                                    options:NSLiteralSearch
                                      range:range];
        //59
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/feizao)]"
                                 withString:@"f_static_059"
                                    options:NSLiteralSearch
                                      range:range];
        //60
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/yl)]"
                                 withString:@"f_static_060"
                                    options:NSLiteralSearch
                                      range:range];
        //61
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/ty)]"
                                 withString:@"f_static_061"
                                    options:NSLiteralSearch
                                      range:range];
        //62
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/ws)]"
                                 withString:@"f_static_062"
                                    options:NSLiteralSearch
                                      range:range];
        //63
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/xin)]"
                                 withString:@"f_static_063"
                                    options:NSLiteralSearch
                                      range:range];
        //64
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/xs)]"
                                 withString:@"f_static_064"
                                    options:NSLiteralSearch
                                      range:range];
        //65
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/mg)]"
                                 withString:@"f_static_065"
                                    options:NSLiteralSearch
                                      range:range];
        //66
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/lw)]"
                                 withString:@"f_static_066"
                                    options:NSLiteralSearch
                                      range:range];
        //67
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/ch)]"
                                 withString:@"f_static_067"
                                    options:NSLiteralSearch
                                      range:range];
        //68
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/aini)]"
                                 withString:@"f_static_068"
                                    options:NSLiteralSearch
                                      range:range];
        //69
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/dabian)]"
                                 withString:@"f_static_069"
                                    options:NSLiteralSearch
                                      range:range];
        //70
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/kf)]"
                                 withString:@"f_static_070"
                                    options:NSLiteralSearch
                                      range:range];
        //71
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/yinyue)]"
                                 withString:@"f_static_071"
                                    options:NSLiteralSearch
                                      range:range];
        //72
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/dg)]"
                                 withString:@"f_static_072"
                                    options:NSLiteralSearch
                                      range:range];
        //73
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/huashu)]"
                                 withString:@"f_static_073"
                                    options:NSLiteralSearch
                                      range:range];
        //74
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/dao)]"
                                 withString:@"f_static_074"
                                    options:NSLiteralSearch
                                      range:range];
        //75
        range.location = 0;
        range.length = retText.length;
        [retText replaceOccurrencesOfString:@"[(/5mao)]"
                                 withString:@"f_static_075"
                                    options:NSLiteralSearch
                                      range:range];
    }
    
    return retText;
}

@end
