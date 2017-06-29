//
//  ALAssetsLibrary+MyCustomPhotoAlbum.h
//  storm
//
//  Created by dong on 15/9/8.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//相册
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
typedef void(^SavesImageCompletion)(NSError* error);

@interface ALAssetsLibrary (MyCustomPhotoAlbum)
/**
 *  保存照片到指定的相册
 *
 *  @param image           照片
 *  @param albumName       相册
 *  @param completionBlock
 */
-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SavesImageCompletion)completionBlock;
/**
 *  保存照片到指定的相册
 *
 *  @param assetURL        url
 *  @param albumName       相册
 *  @param completionBlock
 */
-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SavesImageCompletion)completionBlock;
@end
