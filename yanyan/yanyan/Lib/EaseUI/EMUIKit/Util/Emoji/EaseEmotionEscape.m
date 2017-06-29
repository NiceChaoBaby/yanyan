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

#import "EaseEmotionEscape.h"
#import "NSAttributedString+YYText.h"
#import "UIImage+GIF.h"
#import "YYAnimatedImageView.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kEmotionTopMargin -3.0f

@implementation EMTextAttachment
//I want my emoticon has the same size with line's height
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex NS_AVAILABLE_IOS(7_0)
{
    return CGRectMake( 0, kEmotionTopMargin, lineFrag.size.height, lineFrag.size.height);
}

@end

@interface EaseEmotionEscape ()
{
    NSString *_urlPattern;
    NSDictionary *_dict;
}

@end

@implementation EaseEmotionEscape

static EaseEmotionEscape *_sharedInstance = nil;

+ (EaseEmotionEscape *)sharedInstance
{
    if (_sharedInstance == nil)
    {
        @synchronized(self) {
            _sharedInstance = [[EaseEmotionEscape alloc] init];
        }
    }
    return _sharedInstance;
}

+ (NSMutableAttributedString *) attributtedStringFromText:(NSString *) aInputText
{
    return nil;
}

+ (NSAttributedString *) attStringFromTextForChatting:(NSString *) aInputText
{
    return nil;
}

+ (NSAttributedString *) attStringFromTextForInputView:(NSString *) aInputText
{
    return nil;
}






/**
 *  输入框
 *
 *  @param aInputText <#aInputText description#>
 *
 *  @return <#return value description#>
 */

- (NSMutableAttributedString *) attributtedStringFromText:(NSString *) aInputText
{
    _urlPattern = @"(\\[[\\s\\S]*?\\])";
    //    _urlPattern = @"(?<=\\[).*(?=\\])";
    if (aInputText == nil || aInputText.length == 0) {
        aInputText=@"";
        NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:aInputText attributes:nil ];
        return string;
    }
    NSString *urlPattern = _urlPattern;
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlPattern options:NSRegularExpressionCaseInsensitive error:&error ];
    
    NSArray* matches = [regex matchesInString:aInputText options:NSMatchingReportCompletion range:NSMakeRange(0, [aInputText length])];
    NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:aInputText attributes:nil ];
    
    int delNum = 0;
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        NSString *subStr = [aInputText substringWithRange:matchRange];
        
        //        EMTextAttachment * textAttachment = [[EMTextAttachment alloc ] initWithData:nil ofType:nil];
        EMTextAttachment* textAttachment = [[EMTextAttachment alloc] init];
        textAttachment.bounds = CGRectMake(0, 0, 16, 16);
        UIImage * emojiImage;
        NSString *emojiName = [EaseConvertToCommonEmoticonsHelper convertToSystemEmoticons:subStr];
        textAttachment.imageName = emojiName;
       
        
        emojiImage = [UIImage imageNamed:emojiName];
        
        
        NSAttributedString * textAttachmentString;
        if (emojiImage) {
            textAttachment.image = emojiImage ;
            textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        }else{
            NSString *str = [self getEmojiTextByKey:subStr];
            if (str != nil) {
                str = [NSString stringWithFormat:@"[%@]", str];
                textAttachmentString = [[NSAttributedString alloc] initWithString:str];
            }else {
                //                textAttachmentString = [[NSAttributedString alloc] initWithString:@"[表情]"];
                textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            }
        }
        
        
        if (textAttachment != nil) {
            //            [string replaceCharactersInRange:matchRange withAttributedString:textAttachmentString];
            long cha = matchRange.length-[textAttachmentString length];
            matchRange.location -= delNum;
            //            [string deleteCharactersInRange:matchRange];
            //            [string insertAttributedString:textAttachmentString atIndex:matchRange.location];
            [string replaceCharactersInRange:matchRange withAttributedString:textAttachmentString];
            delNum += cha;
        }
    }
    
    return string;
}

/**
 *
 *  聊天框
 *
 *  @param aInputText <#aInputText description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableAttributedString *) attributtedStringFromText2:(NSString *) aInputText
{
    _urlPattern = @"(\\[[\\s\\S]*?\\])";
    //    _urlPattern = @"(?<=\\[).*(?=\\])";
    if (aInputText == nil || aInputText.length == 0) {
        aInputText=@"";
        NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:aInputText attributes:nil ];
        return string;
    }
    NSString *urlPattern = _urlPattern;
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlPattern options:NSRegularExpressionCaseInsensitive error:&error ];
    
    NSArray* matches = [regex matchesInString:aInputText options:NSMatchingReportCompletion range:NSMakeRange(0, [aInputText length])];
    NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:aInputText attributes:nil ];
    string.yy_lineSpacing = 5;
    int delNum = 0;
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        NSString *subStr = [aInputText substringWithRange:matchRange];
        
       
        EMTextAttachment* textAttachment = [[EMTextAttachment alloc] init];
        textAttachment.bounds = CGRectMake(0, 0,20,20);
        FLAnimatedImage * emojiImage;
        NSString *emojiName = [EaseConvertToCommonEmoticonsHelperD convertToSystemEmoticons:subStr];
        textAttachment.imageName = emojiName;
      
        emojiImage = [FLAnimatedImage animatedImageWithGIFData:[DTools xsd_dataGIFNamed:emojiName]];
     
        FLAnimatedImageView * imag = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 28)];
        imag.animatedImage = emojiImage;
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:[UIImage sd_animatedGIFNamed:emojiName]];
//        imageView.backgroundColor=[UIColor redColor];
        NSMutableAttributedString * textAttachmentString;
        NSAttributedString * textAttachmentString2;
        if (emojiImage) {
            
            textAttachmentString= [NSMutableAttributedString yy_attachmentStringWithContent:imag contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(28, 28) alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentCenter];
        }else{
            NSString *str = [self getEmojiTextByKey:subStr];
            if (str != nil) {
                str = [NSString stringWithFormat:@"[%@]", str];
                textAttachmentString2 = [[NSAttributedString alloc] initWithString:str];
            }else {
               
                textAttachmentString= [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(28, 28) alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentCenter];
            }
        }
        
        if (textAttachment != nil) {
           
            long cha = matchRange.length-[textAttachmentString length];
            matchRange.location -= delNum;
           
            [string replaceCharactersInRange:matchRange withAttributedString:textAttachmentString];
            delNum += cha;
        }
    }
    
    return string;
}
/**
 *
 *  聊天框
 *
 *  @param aInputText <#aInputText description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableAttributedString *) attributtedStringFromText3:(NSString *) aInputText
{
    _urlPattern = @"(\\[[\\s\\S]*?\\])";
    //    _urlPattern = @"(?<=\\[).*(?=\\])";
    if (aInputText == nil || aInputText.length == 0) {
        aInputText=@"";
        NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:aInputText attributes:nil ];
        return string;
    }
    NSString *urlPattern = _urlPattern;
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlPattern options:NSRegularExpressionCaseInsensitive error:&error ];
    
    NSArray* matches = [regex matchesInString:aInputText options:NSMatchingReportCompletion range:NSMakeRange(0, [aInputText length])];
    NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:aInputText attributes:nil ];
    
    int delNum = 0;
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        NSString *subStr = [aInputText substringWithRange:matchRange];
        NSArray *arr=[[NSMutableArray alloc] initWithObjects:@"[):]",
                      @"[:D]",
                      @"[;)]",
                      @"[:-o]",
                      @"[:p]",
                      @"[(H)]",
                      @"[:@]",
                      @"[:s]",
                      @"[:$]",
                      @"[:(]",
                      @"[:'(]",
                      @"[:|]",
                      @"[(a)]",
                      @"[8o|]",
                      @"[8-|]",
                      @"[+o(]",
                      @"[<o)]",
                      @"[|-)]",
                      @"[*-)]",
                      @"[:-#]",
                      @"[:-*]",
                      @"[^o)]",
                      @"[8-)]",
                      @"[(/|)]",
                      @"[(/u)]",
                      @"[(/S)]",
                      @"[(/*)]",
                      @"[(/#)]",
                      @"[(/R)]",
                      @"[(/{)]",
                      @"[(/})]",
                      @"[(/k)]",
                      @"[(/F)]",
                      @"[(/W)]",
                      @"[(/D)]",
                      @"[(/SH)]",
                      @"[(/88)]",
                      @"[(/JY)]",
                      @"[(/BX)]",
                      @"[(/AW)]",
                      @"[(/KL)]",
                      @"[(/QF)]",
                      @"[(/:X)]",
                      @"[(/FW)]",
                      @"[(/ZT)]",
                      @"[(/pen)]",
                      @"[(/KULOU)]",
                      @"[(/GL)]",
                      @"[(/JS)]",
                      @"[(/qs)]",
                      @"[(/BP)]",
                      @"[(/qiang)]",
                      @"[(/ruo)]",
                      @"[(/hd)]",
                      @"[(/shl)]",
                      @"[(/gy)]",
                      @"[(/qidao)]",
                      @"[(/yao)]",
                      @"[(/feizao)]",
                      @"[(/yl)]",
                      @"[(/ty)]",
                      @"[(/ws)]",
                      @"[(/xin)]",
                      @"[(/xs)]",
                      @"[(/mg)]",
                      @"[(/lw)]",
                      @"[(/ch)]",
                      @"[(/aini)]",
                      @"[(/dabian)]",
                      @"[(/kf)]",
                      @"[(/yinyue)]",
                      @"[(/dg)]",
                      @"[(/huashu)]",
                      @"[(/dao)]",
                      @"[(/5mao)]", nil];
        if (! [arr containsObject:subStr])
        {
            continue;
        }
        //        EMTextAttachment * textAttachment = [[EMTextAttachment alloc ] initWithData:nil ofType:nil];
        EMTextAttachment* textAttachment = [[EMTextAttachment alloc] init];
        textAttachment.bounds = CGRectMake(0, 0,20,20);
        UIImage * emojiImage;
        NSString *emojiName = [EaseConvertToCommonEmoticonsHelperD convertToSystemEmoticons:subStr];
        textAttachment.imageName = emojiName;
  
                emojiImage = [UIImage sd_animatedGIFNamed:emojiName];
        
                NSAttributedString * textAttachmentString;
                if (emojiImage) {
                    textAttachment.image = emojiImage ;
                    textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
                }else{
                    
                    
                    
                    NSString *str = [self getEmojiTextByKey:subStr];
                    if (str != nil) {
                        str = [NSString stringWithFormat:@"[%@]", str];
                        textAttachmentString = [[NSAttributedString alloc] initWithString:str];
                    }else {
   
                        textAttachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
                    }
                }
        

        
        if (textAttachment != nil) {
      
            long cha = matchRange.length-[textAttachmentString length];
            matchRange.location -= delNum;
            
            [string replaceCharactersInRange:matchRange withAttributedString:textAttachmentString];
            delNum += cha;
        }
    }
    
    return string;
}

/**
 *  聊天框
 *
 *  @param aInputText <#aInputText description#>
 *  @param font       <#font description#>
 *
 *  @return <#return value description#>
 */
- (NSAttributedString *) attStringFromTextForChatting:(NSString *) aInputText textFont:(UIFont*)font
{
    
    NSMutableAttributedString * string = [self attributtedStringFromText2:aInputText];
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 0.0;
//    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    if (font) {
        [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    }
    return string;
}
/**
 *  聊天框
 *
 *  @param aInputText <#aInputText description#>
 *  @param font       <#font description#>
 *
 *  @return <#return value description#>
 */
- (NSAttributedString *) attStringFromTextForChatting3:(NSString *) aInputText textFont:(UIFont*)font
{
    NSMutableAttributedString * string = [self attributtedStringFromText3:aInputText];
    //    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragraphStyle.lineSpacing = 0.0;
    //    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    if (font) {
        [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    }
    return string;
}
/**
 *  输入框
 *
 *  @param aInputText <#aInputText description#>
 *  @param font       <#font description#>
 *
 *  @return <#return value description#>
 */
- (NSAttributedString *) attStringFromTextForInputView:(NSString *) aInputText textFont:(UIFont*)font
{
    NSMutableAttributedString * string = [self attributtedStringFromText:aInputText];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 0.0;
//    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    if (font) {
        [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    }
    return string;
}

- (NSString*) getEmojiTextByKey:(NSString*) aKey
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPaht = [paths objectAtIndex:0];
    NSString *fileName = [plistPaht stringByAppendingPathComponent:@"EmotionTextMapList.plist"];
    NSMutableDictionary *emojiKeyValue = [[NSMutableDictionary alloc] initWithContentsOfFile: fileName];
    return [emojiKeyValue objectForKey:aKey];
    //    NSLog(@"write data is :%@",writeData);
}

- (NSString*) getEmojiImageNameByKey:(NSString*) aKey
{
    return nil;
}

- (void) setEaseEmotionEscapePattern:(NSString *)pattern
{
    _urlPattern = pattern;
}

- (void) setEaseEmotionEscapeDictionary:(NSDictionary*)dict
{
    _dict = dict;
}

@end
