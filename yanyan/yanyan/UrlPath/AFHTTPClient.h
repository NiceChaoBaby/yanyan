//
//  AFHTTPClient.h
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface AFHTTPClient : NSObject

@property (nonatomic,strong) AFHTTPSessionManager                  *manager;

+ (AFHTTPClient *)share;

- (NSURLSessionDataTask *)getMethod:(NSString *)url param:(NSDictionary *)param success:(void(^)(NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock;

- (NSURLSessionDataTask *)postMethod:(NSString *)url param:(NSDictionary *)param success:(void(^)( NSDictionary * respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock;

/**
 上传多张图片
 
 @param url <#url description#>
 @param param <#param description#>
 @param cameraImgArr 图片数组
 @param dataIsImage  数组里是Data还是Image
 @param successBlock <#successBlock description#>
 @param failedBlock <#failedBlock description#>
 @return <#return value description#>
 */
- (NSURLSessionDataTask *)postMethodImag:(NSString *)url param:(NSDictionary *)param cameraImgArr:(NSMutableArray *)cameraImgArr dataIsImage:(BOOL)is success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock;

- (NSURLSessionDataTask *)postMethodImage:(NSString *)url param:(NSDictionary *)param imageData:(NSData*)data success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock;

//上传背景图片
- (NSURLSessionDataTask *)postBgimageImage:(NSString *)url param:(NSDictionary *)param imageData:(NSData*)data success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock;

- (NSURLSessionDataTask *)postMethodVideo:(NSString *)url param:(NSDictionary *)param VideoData:(NSData*)videodata ImageData:(NSData *)imagedata success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock;



@end
