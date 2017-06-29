//
//  NSData+Image.h
//  chatdong
//
//  Created by 熊申东 on 2016/12/6.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Image)
//压缩图片到指定文件大小
- (NSData *)compressToMaxDataSizeKBytes:(CGFloat)size;
@end
