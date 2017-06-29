//
//  AFHTTPClient.m
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//

#import "AFHTTPClient.h"
#import "XSDTimeCalibration.h"
@interface AFHTTPClient()
@property(nonatomic,strong)NSUserDefaults *m_accountDefaults;

@end
@implementation AFHTTPClient

+ (AFHTTPClient *)share
{
    static AFHTTPClient     *shareClient = nil;
    if(!shareClient)
    {
        shareClient = [[AFHTTPClient alloc] init];
    }
    return shareClient;
}

- (id)init
{
    self = [super init];
    if(self)
    {


        NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest =10;
        self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       
    }
    return self;
}

- (NSURLSessionDataTask *)getMethod:(NSString *)url param:(NSDictionary *)param success:(void(^)(NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock
{
    
    
    //是否无网络
    if (![AFNetworkReachabilityManager sharedManager].isReachable)
    {
        failedBlock(K_ErrorMsg);
        return nil;
    }
   
   
        
    
    
    
    NSURLSessionDataTask *op =[ self.manager GET:url parameters:[self structureParam:param] progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if(successBlock)
                {
                    
                    [self setXSDCurrentTime:task];
                    NSDictionary *responseObjects=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                    //            if (!responseObjects)
                    //            {
                    //                responseObjects=[[NSDictionary alloc] init];
                    //            }
                    successBlock(responseObjects);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failedBlock)
                {
                    
                  
                    NSString *errorMsg = [error localizedDescription];
                    failedBlock(errorMsg);
                }
            }
          ];
            
        
   
    

    return op;
    
    
  

}


- (NSURLSessionDataTask *)postMethodImage:(NSString *)url param:(NSDictionary *)param imageData:(NSData*)data success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock
{
    if (![AFNetworkReachabilityManager sharedManager].isReachable)
    {
        failedBlock(K_ErrorMsg);
        return nil;
    }
    NSURLSessionDataTask *op = [self.manager POST:url parameters:[self structureParam:param] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
         [formData appendPartWithFileData:data name:@"avatar" fileName:@"avatar.jpg" mimeType:@"image/JPEG"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(successBlock)
        {
            [self setXSDCurrentTime:task];
            NSDictionary *responseObjects=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(responseObjects);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failedBlock)
        {
          
            NSString *errorMsg = [error localizedDescription];
            failedBlock(errorMsg);
        }
        
    }];
    
   
    
    return op;
}
//上传背景图片
- (NSURLSessionDataTask *)postBgimageImage:(NSString *)url param:(NSDictionary *)param imageData:(NSData*)data success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock
{

    //是否无网络
    BOOL isNoNet=[[self.m_accountDefaults objectForKey:K_IntentNet] boolValue];
    if(isNoNet)
    {
        failedBlock(K_ErrorMsg);
        return nil;
    }
    NSURLSessionDataTask *op = [self.manager POST:url parameters:[self structureParam:param] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
                                {
                                    [formData appendPartWithFileData:data name:@"bgimage" fileName:@"bgimage.jpg" mimeType:@"image/JPEG"];
                                } progress:^(NSProgress * _Nonnull uploadProgress) {
                                    
                                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    if(successBlock)
                                    {
                                        [self setXSDCurrentTime:task];
                                        NSDictionary *responseObjects=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                                        successBlock(responseObjects);
                                        
                                    }
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    if(failedBlock)
                                    {
                                       
                                        NSString *errorMsg = [error localizedDescription];
                                        failedBlock(errorMsg);
                                    }
                                    
                                }];

    
    return op;
}
- (NSURLSessionDataTask *)postMethod:(NSString *)url param:(NSDictionary *)param success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock
{
    if (![AFNetworkReachabilityManager sharedManager].isReachable)
    {
        failedBlock(K_ErrorMsg);
        return nil;
    }
    NSURLSessionDataTask *op = [self.manager POST:url parameters:[self structureParam:param] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(successBlock)
        {

           [self setXSDCurrentTime:task];
            NSDictionary *responseObjects=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            successBlock(responseObjects);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failedBlock)
        {
           
           
            NSString *errorMsg = [error localizedDescription];
            failedBlock(errorMsg);
        }
    }];
    
        
       
  
        
    return op;
    
}

/**
 上传多张图片
 
 @param url <#url description#>
 @param param <#param description#>
 @param avatarData <#avatarData description#>
 @param cameraImgArr <#cameraImgArr description#>
 @param successBlock <#successBlock description#>
 @param failedBlock <#failedBlock description#>
 @return <#return value description#>
 */
- (NSURLSessionDataTask *)postMethodImag:(NSString *)url param:(NSDictionary *)param cameraImgArr:(NSMutableArray *)cameraImgArr dataIsImage:(BOOL)is success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock
{
    //是否无网络
    if (![AFNetworkReachabilityManager sharedManager].isReachable)
    {
        failedBlock(K_ErrorMsg);
        return nil;
    }
    NSURLSessionDataTask *op = [self.manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
                                {
                                    
                                    for (int i=1; i<=cameraImgArr.count; i++)
                                    {
                                        NSData * imageData; UIImage *image;
                                        
                                        if (is) {
                                            
                                            imageData =[cameraImgArr objectAtIndex:(i-1)];
                                            
                                          
                                            
                                        }else{
                                            
                                            image=[cameraImgArr objectAtIndex:(i-1)];
                                            UIImage *im=[DTools scaleToSize:image];
                                            if (UIImagePNGRepresentation(im)==nil) {
                                                imageData = UIImageJPEGRepresentation(im, 1.0);
                                            }else{
                                                imageData = UIImagePNGRepresentation(im);
                                            }  

                                           
                                           
                                        }
                                        
                                        if (imageData) {
                                            
                                            //压缩照片为1024KB
                                            NSData * imageData1 = [imageData compressToMaxDataSizeKBytes:500];
                                            
                                            
                                            NSString *name=[NSString stringWithFormat:@"pic_%i",i];
                                            [formData appendPartWithFileData:imageData1 name:name fileName:@"pic.jpg" mimeType:@"image/JPEG"];
                                            
                                        }
                                        
                                    }
                                    
                                } progress:^(NSProgress * _Nonnull uploadProgress)
                                {
                                    
                                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    if(successBlock)
                                    {
                                        NSDictionary *responseObjects=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                                        successBlock(responseObjects);
                                        
                                    }
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    if(failedBlock)
                                    {
                                        NSString *errorMsg = [error localizedDescription];
                                        failedBlock(errorMsg);
                                    }
                                    
                                }];
    
    
    return op;
}

/**
 *  视频上传方法 AFN 方法
 *
 *  @param url          上传视频的地址
 *  @param param        信息数组
 *  @param videodata    视频NSData格式数据
 *  @param imagedata    图片NSData格式数据
 *  @param successBlock <#successBlock description#>
 *  @param failedBlock  <#failedBlock description#>
 *
 *  @return <#return value description#>
 */
- (NSURLSessionDataTask *)postMethodVideo:(NSString *)url param:(NSDictionary *)param VideoData:(NSData*)videodata ImageData:(NSData *)imagedata success:(void(^)( NSDictionary *respostData))successBlock failed:(void(^)(NSString *errorMsg))failedBlock
{
 
    if (![AFNetworkReachabilityManager sharedManager].isReachable)
    {
        failedBlock(K_ErrorMsg);
        return nil;
    }
    
    NSURLSessionDataTask *op = [self.manager POST:url parameters:[self structureParam:param] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
                                {
                                    [formData appendPartWithFileData:imagedata name:@"thumbfile" fileName:@"avatar.jpg" mimeType:@"image/JPEG"];
                                    
                                    [formData appendPartWithFileData:videodata name:@"upfile"fileName:@"video1.mp4" mimeType:@"video/quicktime"];
                                    
                                    
                                } progress:^(NSProgress * _Nonnull uploadProgress)
                                {
                                    
                                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    if(successBlock)
                                    {
                                       [self setXSDCurrentTime:task];
                                        NSDictionary *responseObjects=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                                        successBlock(responseObjects);
                                        
                                    }
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    if(failedBlock)
                                    {
                                        
                                        NSString *errorMsg = [error localizedDescription];
                                        failedBlock(errorMsg);
                                    }
                                    
                                }];
    
    return op;
}

-(NSMutableDictionary *)structureParam:(NSDictionary *)param
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithCapacity:0];
for (NSString *name in [param allKeys])
{
        
        id m_id=[param objectForKey:name];
        if ([m_id isKindOfClass:[NSNumber class]])
        {
            [dic setObject:m_id forKey:name];
        }
        else if([m_id isKindOfClass:[NSString class]])
        {
            NSString *text=(NSString*)m_id;
            //           text= [m_id stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)text, NULL, (CFStringRef)@"!*'();:@&=+$/?%#[]",kCFStringEncodingUTF8);
            NSString *outq = [NSString stringWithString:(NSString *)CFBridgingRelease(escaped)];
            //
            [dic safeSetObject:outq forKey:name];
            //            [dic safeSetObject:text forKey:name];
        }else
        {
            [dic safeSetObject:m_id forKey:name];
        }
}
    
    return dic;
    
}
-(void)setXSDCurrentTime:(NSURLSessionDataTask * ) task
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    if (response) {
        
        NSDictionary *allHeaders = response.allHeaderFields;
        //DLog(@"allHeaders===%@",allHeaders);
        [[XSDTimeCalibration share] setOriginTime:[allHeaders objectForKey:K_date]];
    
}
   
}



@end
