//
//  ShareView.h
//  chat
//
//  Created by 高超 on 16/5/24.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatShareModel.h"
//#import "WXApi.h"
//#import <TencentOpenAPI/TencentOAuth.h>
@interface ShareView : UIWindow
@property(nonatomic,strong)UIView * m_view;
@property(nonatomic,assign)NSInteger m_btnMaxX;//按钮最大X
@property(nonatomic,strong)ChatShareModel * m_model;
@property(nonatomic,strong)UIImage * m_image;//新闻封面图图片
@property(nonatomic,strong)NSString  * m_shareUrl;//请求下来分享的URL

@property(nonatomic,strong) UILabel * titlelabel;
+(ShareView *)shareInstance;
-(void)ShareViewWindowModel:(ChatShareModel *)model image:(UIImage *)image;
@end
