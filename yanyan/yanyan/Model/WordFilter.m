//
//  WordFilter.m
//  chat
//
//  Created by 熊申东 on 2016/12/15.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "WordFilter.h"
#define EXIST @"isExists"

@interface WordFilter()

@property (nonatomic,strong) NSMutableDictionary *root;

@property (nonatomic,assign) BOOL isFilterClose;

@end
@implementation WordFilter
static WordFilter *instance;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)initFilter:(NSString *)filepath{
    
    self.root = [NSMutableDictionary dictionary];
    char word[1024];
    FILE *fp;
    char *p;
    
    //打开文件
//    fp = fopen([filepath UTF8String], "r");
    if ((fp = fopen([filepath UTF8String], "r")) == NULL) {
        NSLog(@"Fail to read t9 data.");
    }
    //按行读取内容
    while (fgets(word, sizeof(word), fp))
    {
        p = word;
        
        while (*p != 0) {
            if (*p == '\r' || *p == '\n' || *p == ' ') {
                *p = 0;
                break;
            }
            p++;
        }
        
        //插入字符，构造节点
        [self insertWords:[NSString stringWithUTF8String:word]];
    }
}

-(void)insertWords:(NSString *)words{
    NSMutableDictionary *node = self.root;
    
    for (int i = 0; i < words.length; i ++) {
        NSString *word = [words substringWithRange:NSMakeRange(i, 1)];
        
        if (node[word] == nil) {
            node[word] = [NSMutableDictionary dictionary];
        }
        
        node = node[word];
    }
    
    //敏感词最后一个字符标识
    node[EXIST] = [NSNumber numberWithInt:1];
}

/**
  检测敏感字  替换它为****

 @param str 字符串
 @return 替换后的字符串
 */
- (NSString *)wordSensitivefilter:(NSString *)str{
    
    if (self.isFilterClose || !self.root) {
        return str;
    }
    
    NSMutableString *result = result = [str mutableCopy];
    
    for (int i = 0; i < str.length; i ++) {
        NSString *subString = [str substringFromIndex:i];
        NSMutableDictionary *node = [self.root mutableCopy] ;
        int num = 0;
        
        for (int j = 0; j < subString.length; j ++) {
            NSString *word = [subString substringWithRange:NSMakeRange(j, 1)];
            
            if (node[word] == nil) {
                break;
            }else{
                num ++;
                node = node[word];
            }
            
            //敏感词匹配成功
            if ([node[EXIST]integerValue] == 1) {
                
                NSMutableString *symbolStr = [NSMutableString string];
                for (int k = 0; k < num; k ++) {
                    [symbolStr appendString:@"*"];
                }
                
                [result replaceCharactersInRange:NSMakeRange(i, num) withString:symbolStr];
                
                i += j;
                break;
            }
        }
    }
    
    return result;
}

/**
 检测是否包含敏感字

 @param str 字符串
 @return bool
 */
- (BOOL)iswordSensitivefilter:(NSString *)str{
    
    if (self.isFilterClose || !self.root) {
        return str;
    }
    
    NSMutableString *result = result = [str mutableCopy];
    
    for (int i = 0; i < str.length; i ++) {
        NSString *subString = [str substringFromIndex:i];
        NSMutableDictionary *node = [self.root mutableCopy] ;
        int num = 0;
        
        for (int j = 0; j < subString.length; j ++) {
            NSString *word = [subString substringWithRange:NSMakeRange(j, 1)];
            
            if (node[word] == nil) {
                break;
            }else{
                num ++;
                node = node[word];
            }
            
            //敏感词匹配成功
            if ([node[EXIST]integerValue] == 1) {
                
//                NSMutableString *symbolStr = [NSMutableString string];
//                for (int k = 0; k < num; k ++) {
//                    [symbolStr appendString:@"*"];
//                }
//                
//                [result replaceCharactersInRange:NSMakeRange(i, num) withString:symbolStr];
//                
//                i += j;
                
                
                return YES;
            }
        }
    }
    
    return NO;
}
//释放
- (void)freeFilter{
    self.root = nil;
    [self stopFilter:YES];
}

- (void)stopFilter:(BOOL)b{
    self.isFilterClose = b;
}

@end
