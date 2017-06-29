//
//  NSData+Image.m
//  chatdong
//
//  Created by 熊申东 on 2016/12/6.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "NSData+Image.h"
#define KM 1024*1024
@implementation NSData (Image)


+(NSData *)imageData:(UIImage *)myimage

{
    
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    
    if (data.length>KM*4) {//4M以上
        data=UIImageJPEGRepresentation(myimage, 0.015);
    }
    
    
    if (data.length>100*1024) {
        
        if (data.length>1024*1024) {//1M以及以上
            
            data=UIImageJPEGRepresentation(myimage, 0.1);
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(myimage, 0.5);
            
        }else if (data.length>200*1024) {//0.25M-0.5M
            
            data=UIImageJPEGRepresentation(myimage, 0.9);
            
        }
        
    }
    
    return data;
    
}







/**
 *  压缩图片到指定文件大小
 *
 *  @param size  目标大小（最大值）K
 *

 *  @return 返回的图片文件
 */
- (NSData *)compressToMaxDataSizeKBytes:(CGFloat)size{
    UIImage *image=  [UIImage imageWithData:self];
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.05f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
//        if (lastData <= size) {
//            break;
//        }else{
            lastData = dataKBytes;
//        }
    }
    //
    return data;
}
@end
