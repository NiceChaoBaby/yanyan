//
//  ShareView.m
//  chat
//
//  Created by 高超 on 16/5/24.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "ShareView.h"
//#import "TencentOpenAPI/QQApiInterface.h"
//#import "JXButton.h"
//#import "WeiboSDK.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation ShareView
+(ShareView *)shareInstance
{
    
    static id sharedInstance=nil;
    if(!sharedInstance)
    {
        sharedInstance = [[ShareView alloc] initWithFrame:CGRectMake(0,0, LCDW, LCDH+20)];
        
        
    }
    return sharedInstance;
}


//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    CGFloat titleX = 0;
//    CGFloat titleY = contentRect.size.height *0.75;
//    CGFloat titleW = contentRect.size.width;
//    CGFloat titleH = contentRect.size.height - titleY;
//    return CGRectMake(titleX, titleY, titleW, titleH);
//}
//
//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//    CGFloat imageW = CGRectGetWidth(contentRect);
//    CGFloat imageH = contentRect.size.height * 0.7;
//    return CGRectMake(0, 0, imageW, imageH);
//}
//-(UIButton *)btnAnimateWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray NameArray:(NSArray *)nameArray number:(int)i animateFrame:(CGRect)aniFrame delay:(CGFloat)delay
//{
//    UIButton * button =[[UIButton alloc]init];
//    button.frame =frame;
//    button.titleLabel.textAlignment = NSTextAlignmentCenter;
//    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    button.titleLabel.font = [UIFont systemFontOfSize:13];
//    [button setTitleColor:RGBAddAssistColor forState:UIControlStateNormal];
//
//    [button setBackgroundImage:[UIImage imageNamed:imageArray[i -1]] forState:UIControlStateNormal];
//    [button setTitle:nameArray[i -1] forState:UIControlStateNormal];
//   
//    
//    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
//                                       imageTitleSpace:190];
////    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
////    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height ,-button.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
////    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -button.titleLabel.bounds.size.width)];
//    
//    button.tag = 1000+i;
//    [button addTarget:self action:@selector(clickClickway:) forControlEvents:UIControlEventTouchUpInside];
//   
//    [self.m_view addSubview:button];
//    NSLog(@"哈哈哈哈哈哈   %f",delay);
//    [UIView animateWithDuration:1 delay:delay usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        
//        button.frame  = aniFrame;
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    return button;
//}
//
////-(UILabel *)labelAnimateWithFrame:(CGRect)frame NameArray:(NSArray *)nameArray number:(int)i animateFrame:(CGRect)aniFrame delay:(CGFloat)delay isGroupShar:(BOOL)group point:(CGPoint)point
////{
////    UILabel * label =[[UILabel alloc]init];
////    label.frame =frame;
////    
////    
////    if (!group) {
////        
////      label.text = nameArray[i -1];
////        
////    }else{
////         label.text = nameArray[i];
////        
////        
////    }
////    label.textColor = RGBAddAssistColor;
////    label.font = [UIFont systemFamilyFontOfSize:13];
////    label.textAlignment = NSTextAlignmentCenter;
////    label.center = point;
////    [self.m_view addSubview:label];
////    NSLog(@"哈哈哈哈哈哈   %f",delay);
////    [UIView animateWithDuration:1 delay:delay usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
////        
////        label.frame  = aniFrame;
////        
////    } completion:^(BOOL finished) {
////        
////    }];
////    return label;
////}
//-(void)ShareViewWindowModel:(ChatShareModel *)model image:(UIImage *)image isGroupShar:(BOOL)group
//{
//    
//    self.m_model = model;
//    self.m_image = image;
//    if (!self.m_image) {
//        self.m_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.m_model.m_img]]];
//    }
//    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmessView)];
//    [self addGestureRecognizer:tap];
//    
//    if (self.m_view) {
//        for (UIView *subviews in [self.m_view subviews]) {
//            
//            [subviews removeFromSuperview];
//        }
//    }
//    self.backgroundColor=RGBACOLOR(0, 0, 0, 0.3);
//    //这里20是状态栏高度
//    //    self.m_view = [[UIView alloc]initWithFrame:CGRectMake(0, LCDH, LCDW, 270)];
//    self.m_view = [[UIView alloc]initWithFrame:CGRectMake(0,LCDH, LCDW, 270)];
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.m_view.frame) - 49, LCDW, 49)];
//    [button addTarget:self action:@selector(dissmessView:) forControlEvents:UIControlEventTouchUpInside];
//    [button setTitleColor:RGBAddAssistColor forState:UIControlStateNormal];
//    [button setTitle:@"取消" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFamilyFontOfSize:18];
//    button.backgroundColor = [UIColor whiteColor];
//    [self.m_view addSubview:button];
//    //    int number;
//    int firstNumber;
//    int rules;
//    int rules2;
//    NSArray * array;
//    NSArray * array1;
//    NSInteger spacing = (LCDW - 220)/5;
//    
//    
//    if (!group) {
//        //         number = 6;
//        array = @[@"share_pyq",@"share_wx",@"share_qq",@"share_qzone",@"share_weibo",@"share_copy"];
//        array1 = @[@"朋友圈",@"微信好友",@"QQ",@"QQ空间",@"新浪微博",@"复制链接"];
//        rules = 5;
//        rules2 = 4;
//        firstNumber = 1;
//    }else{
//        //        number =7;
//        rules = 4;
//        rules2 = 3;
//        array = @[@"share_youhua",@"share_pyq",@"share_wx",@"share_qq",@"share_qzone",@"share_weibo",@"share_copy"];
//        array1 = @[@"言言群组",@"朋友圈",@"微信好友",@"QQ",@"QQ空间",@"新浪微博",@"复制链接"];
//        firstNumber = 0;
//    }
//    
//    self.m_view.backgroundColor = RGBShareColor;
//    [self addSubview:self.m_view];
//    
//    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        
//        self.m_view.frame = CGRectMake(0, LCDH - 270 +20, LCDW, 270);
//        [self layoutIfNeeded];
//        
//        
//        
//    } completion:^(BOOL finished) {
//    }];
//    CGFloat Y  = 0;
//    
//    for (int i = firstNumber; i < 7; i++) {
//        //        UIButton *button;
//        UIButton *button;
//        UILabel * label;
//        if (i == rules) {
//            self.m_btnMaxX = 0;
//        }
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        int a = i;
//        CGFloat time = ((float)a/10);
//        NSLog(@"aaaaaaaaa   %f",time);
//        if (i <rules) {
//            //            button  = [[UIButton alloc] initWithFrame:CGRectMake(self.m_btnMaxX + spacing, 15 , 50, 50)];
//            
//            //            button = [self btnAnimateWithFrame:CGRectMake(self.m_btnMaxX + spacing, 0 , 50, 50) imageName:array number:i animateFrame:CGRectMake(self.m_btnMaxX + spacing, 15 , 50, 50) delay:(i/10)isGroupShar:group];
//            
//            button = [self btnAnimateWithFrame:CGRectMake(self.m_btnMaxX + spacing, 15+40 , 55, 55) imageArray:array NameArray:array1 number:i animateFrame:CGRectMake(self.m_btnMaxX + spacing, 15 , 55, 55) delay:time];
//            NSLog(@"++__++  Btn Fream =X %f  Y %f  W %f G %f",button.frame.origin.x,button.frame.origin.y,button.frame.size.width,button.frame.size.height);
//            //            CGPoint point = button.center;
//            //                    point.y = label.center.y;
//            label  = [[UILabel alloc]initWithFrame:CGRectMake(self.m_btnMaxX + spacing -10 , CGRectGetMaxY(button.frame) + 10, 60, 20)];
//            //            label  = [self labelAnimateWithFrame:CGRectMake(self.m_btnMaxX + spacing -10 , CGRectGetMaxY(button.frame) + 10, 60, 20) NameArray:array1 number:i animateFrame:CGRectMake(self.m_btnMaxX + spacing -10 , CGRectGetMaxY(button.frame) + 10, 60, 20) delay:time isGroupShar:group point:point];
//        }else{
//            //            button  = [[UIButton alloc] initWithFrame:CGRectMake(self.m_btnMaxX + spacing,Y+ 15 , 50, 50)];
//            
//            button = [self btnAnimateWithFrame:CGRectMake(self.m_btnMaxX + spacing,Y+ 55 , 55, 55) imageArray:array NameArray:array1 number:i animateFrame:CGRectMake(self.m_btnMaxX + spacing,Y+ 15 , 55, 55) delay:(i/10) ];
//            //            CGPoint point = button.center;
//            //            point.y = label.center.y;
//            //            label  = [self labelAnimateWithFrame:CGRectMake(self.m_btnMaxX + spacing -10 , CGRectGetMaxY(button.frame) + 10, 60, 20) NameArray:array1 number:i animateFrame:CGRectMake(self.m_btnMaxX + spacing -10 , CGRectGetMaxY(button.frame) + 10, 60, 20) delay:time isGroupShar:group point:point];
//            label  = [[UILabel alloc]initWithFrame:CGRectMake(self.m_btnMaxX + spacing -10 , CGRectGetMaxY(button.frame) + 10, 60, 20)];
//            
//        }
//        
//        
//        if (!group) {
//            
//            //            [button setImage:ImageNamed(array[i -1]) forState:UIControlStateNormal];
//            //            label.text = array1[i -1];
//            
//            if (![WXApi isWXAppInstalled] && ([label.text isEqualToString:@"微信好友"]||[label.text isEqualToString:@"朋友圈"])) {
//                button.hidden = YES;
//                label.hidden = YES;
//            }
//        }else{
//            //            [button setImage:ImageNamed(array[i]) forState:UIControlStateNormal];
//            //            label.text = array1[i];
//            if (![WXApi isWXAppInstalled] && ([label.text isEqualToString:@"微信好友"]||[label.text isEqualToString:@"朋友圈"])) {
//                button.hidden = YES;
//                label.hidden = YES;
//            }
//            
//        }
//        
//        label.textColor = RGBAddAssistColor;
//        label.font = [UIFont systemFamilyFontOfSize:13];
//        label.textAlignment = NSTextAlignmentCenter;
//        CGPoint point = button.center;
//        point.y = label.center.y;
//        label.center = point;
//        label.hidden = YES;
//        //        label.text = @"lalalalla";
//        [self.m_view addSubview:label];
//        self.m_btnMaxX = CGRectGetMaxX(button.frame);
//        
//        if (i == rules2) {
//            UIView * aview = [[UIView alloc]initWithFrame:CGRectMake(spacing, CGRectGetMaxY(label.frame)+ 15, LCDW - (spacing * 2), 1)];
//            aview.backgroundColor = RGBLineColor;
//            aview.alpha = 0;
//            [self.m_view addSubview:aview];
//            Y =  CGRectGetMaxY(aview.frame);
//            [UIView animateWithDuration:0.4 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                aview.alpha = 1;
//            } completion:^(BOOL finished) {
//                
//            }];
//        }
//    }
//    
//    self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake((LCDW/2)-75,(LCDH_H - 120) , 150, 35)];
//    [DTools getAvaterCorner:self.titlelabel];
//    self.titlelabel.font = [UIFont systemFamilyFontOfSize:16];
//    self.titlelabel.backgroundColor = [UIColor blackColor];
//    self.titlelabel.textAlignment =  NSTextAlignmentCenter;
//    self.titlelabel.alpha = 0;
//    self.titlelabel.text = @" 复制成功 ";
//    self.titlelabel.textColor = [UIColor whiteColor];
//    //    CGPoint titlepoint;
//    //    self.titlelabel.center = titlepoint;
//    //    [self.titlelabel sizeToFit];
//    [self addSubview:self.titlelabel];
//    //    self.titlelabel.hidden = NO;
//    //    }];
//    //显示在界面上
//    [self makeKeyAndVisible];
//}
//
//
////显示复制成功
//-(void)titiView
//{
//    
//        [UIView animateWithDuration:0.5 animations:^{
//            self.titlelabel.alpha = 0.8;
//        } completion:^(BOOL finished) {
//           [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
//                self.titlelabel.alpha = 0;
//           } completion:^(BOOL finished) {
//               
//           }];
//            
//        }];
//
//    
//}
//-(void)clickClickway:(UIButton *)btn
//{
//    if (self.m_model.m_shareUrl!=nil && self.m_model.m_shareUrl.length > 0) {
//        
//        if ([self.m_model.m_img isNull])
//        {//有图片
//            switch (btn.tag) {
//                    
//                case 1000://分享到本软件
//                {
//                   
//                    
//                    
//                }
//                    break;
//                case 1001://微信朋友圈分享
//                {
//                    [self WXShareImage:YES type:SharingWXFriend];
//                }
//                    break;
//                case 1002://微信好友分享
//                {
//                    [self WXShareImage:YES type:SharingWX];
//                    
//                }
//                    break;
//                case 1003://QQ分享
//                {
//                    [self QQShareImage:YES type:SharingQQ];
//                }
//                    break;
//                case 1004://QQ空间分享
//                {
//                    [self QQShareImage:YES type:SharingQQZone];
//                }
//                    break;
//                case 1005://新浪微博分享
//                {
//                    [self WBShareImage:YES type:SharingWB];
//                    
//                }
//                    break;
//                case 1006://复制链接
//                {
//                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//                    pasteboard.string = self.m_model.m_shareUrl;
//                    [self titiView];
//                }
//                    break;
//                default:
//                    break;
//            }
//            
//        }else{
//            switch (btn.tag) {
//                case 1000://分享到本软件
//                {
////                    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Group" bundle:nil];
////                    ShareViewController * management = [storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
////                    management.m_groupInfoModel = self.m_groupInfoModel;
////                    [self dissmessView];
////                    [self.m_VC.navigationController pushViewController:management animated:YES];
//                    
//                }
//                    break;
//                case 1001://微信朋友圈分享
//                {
//                    [self WXShareImage:NO type:SharingWXFriend];
//                }
//                    break;
//                case 1002://微信好友分享
//                {
//                    [self WXShareImage:NO type:SharingWX];
//                }
//                    break;
//                case 1003://QQ分享
//                {
//                    [self QQShareImage:NO type:SharingQQ];
//                }
//                    break;
//                case 1004://QQ空间分享
//                {
//                    [self QQShareImage:NO type:SharingQQZone];
//                }
//                    break;
//                case 1005://新浪微博分享
//                {
//                    [self WBShareImage:NO type:SharingWB];
//                }
//                    break;
//                case 1006://复制链接
//                {
//                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//                    pasteboard.string = self.m_model.m_shareUrl;
//
//                    [self titiView];
//                    
//                }
//                    break;
//                default:
//                    break;
//            }
//        }
//        
//
//        
//        
//        
//    }else{
//    //这里分享出去的URL需要请求下来进行拼接，这样分享出去的URL网址上面才带自己APP的LOGO
//    NSDictionary * info = [URLPath getNetShareTheNewsUrlP:self.m_model.m_contentUrl];
//   [[AFHTTPClient share]postMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
//      
//       NSInteger rs = [[respostData safeObjectForKey:K_rs]integerValue];
//       
//       if (rs == 1) {
//           
//           self.m_model.m_shareUrl = [NSString  stringWithFormat:@"http://testchat.leiyu.tv/index.php?ac=share&op=get&id=%@",[respostData objectForKey:K_data]];
//           
//           
//           if ([self.m_model.m_img isNull])
//           {//有图片
//               switch (btn.tag) {
//                       
//                   case 1000://分享到本软件
//                   {
//                     
//                      
//                   }
//                       break;
//                   case 1001://微信朋友圈分享
//                   {
//                       [self WXShareImage:YES type:SharingWXFriend];
//                   }
//                       break;
//                   case 1002://微信好友分享
//                   {
//                       [self WXShareImage:YES type:SharingWX];
//                       
//                   }
//                       break;
//                   case 1003://QQ分享
//                   {
//                       [self QQShareImage:YES type:SharingQQ];
//                   }
//                       break;
//                   case 1004://QQ空间分享
//                   {
//                        [self QQShareImage:YES type:SharingQQZone];
//                   }
//                       break;
//                   case 1005://新浪微博分享
//                   {
//                       [self WBShareImage:YES type:SharingWB];
//                      
//                   }
//                       break;
//                    case 1006://复制链接
//                   {
//                       UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//                       pasteboard.string = self.m_model.m_shareUrl;
//                          [self titiView];
//                   }
//                       break;
//                   default:
//                       break;
//               }
//               
//           }else{
//               switch (btn.tag) {
//                   case 1000://分享到本软件
//                   {
//                      
//                   
//                   }
//                       break;
//                   case 1001://微信朋友圈分享
//                   {
//                       [self WXShareImage:NO type:SharingWXFriend];
//                   }
//                       break;
//                   case 1002://微信好友分享
//                   {
//                       [self WXShareImage:NO type:SharingWX];
//                   }
//                       break;
//                   case 1003://QQ分享
//                   {
//                       [self QQShareImage:NO type:SharingQQ];
//                   }
//                       break;
//                   case 1004://QQ空间分享
//                   {
//                       [self QQShareImage:NO type:SharingQQZone];
//                   }
//                       break;
//                   case 1005://新浪微博分享
//                   {
//                       [self WBShareImage:NO type:SharingWB];
//                   }
//                       break;
//                   case 1006://复制链接
//                   {
//                       UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//                       pasteboard.string = self.m_model.m_shareUrl;
//                      [self titiView];
//                   }
//                       break;
//                   default:
//                       break;
//               }
//           }
// 
//           
//           
//       }else{
//           
//           [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//       }
//       
//   } failed:^(NSString *errorMsg) {
//       
//       [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
//   }];
//    
//    }
//    
//}
//
//-(void)dissmessView
//{
//    [UIView animateWithDuration:0.1 animations:^{
//        
//        self.m_view.frame = CGRectMake(0, LCDH +20, LCDW, 286);
//    } completion:^(BOOL finished) {
//        
//        self.backgroundColor=RGBACOLOR(0, 0, 0, 0);
//        [self resignKeyWindow];
//        [self removeFromSuperview];
//        self.hidden = YES;
//        self.m_btnMaxX = 0;
//        
//    }];
//    
//    
//}
//
//-(void)dissmessView:(UIButton *)btn
//{
//    [UIView animateWithDuration:0.1 animations:^{
//        
//    self.m_view.frame = CGRectMake(0, LCDH +20, LCDW, 286);
//   } completion:^(BOOL finished) {
//       
//        self.backgroundColor=RGBACOLOR(0, 0, 0, 0);
//        [self resignKeyWindow];
//        [self removeFromSuperview];
//       self.hidden = YES;
//       self.m_btnMaxX = 0;
//       
//    }];
//    
//    
//    
//}
//-(void)WXShareImage:(BOOL)image type:(SharingType)type
//{
//    
//    //判断是否安装了微信客户端
//    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])
//    {
//        ShareAppDelegate.m_WXstark = YES;
//        WXMediaMessage * message = [WXMediaMessage message];
//        message.title = self.m_model.m_title;
//        message.description = self.m_model.m_summary;
//        if (image)
//        {//有图片
//                CGSize size = CGSizeMake(80, 80);
//                UIImage * iamgea = [self imageWithImage:self.m_image scaledToSize:size];
//                [message setThumbImage:iamgea];
//            
//
//        }else{
//            
//            [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://chat.leiyu.tv/upload/news/logo.png"]]]];
//        }
//        
//        WXWebpageObject * webpageObject = [WXWebpageObject object];
//        webpageObject.webpageUrl = self.m_model.m_shareUrl;
//        message.mediaObject = webpageObject;
//        SendMessageToWXReq * req = [[SendMessageToWXReq alloc]init];
//        req.bText = NO;
//        req.message = message;
//        if (type == SharingWXFriend) {
//            
//            req.scene = WXSceneTimeline;
//            
//        }else{
//            
//            req.scene = WXSceneSession;
//            
//        }
//        [WXApi sendReq:req];
//    }else{
//        
//        [SVProgressHUD showErrorWithStatus:@"你还没有安装微信,无法使用此功能"];
//    }
//}
//
//-(void)QQShareImage:(BOOL)image type:(SharingType)type
//{
//    NSString *utf8String = self.m_model.m_shareUrl;
//    self.m_shareUrl = self.m_model.m_shareUrl;
//    NSString *title = self.m_model.m_title;
//    NSString *description = self.m_model.m_summary;
////    NSString *previewImageUrla = self.m_model.m_img;
//    QQApiNewsObject *newsObj;
//    if (image) {
//        
////        newsObj = [QQApiNewsObject
////                   objectWithURL:[NSURL URLWithString:utf8String]
////                   title:title
////                   description:description
////                   previewImageURL:[NSURL URLWithString:previewImageUrla]];
//        NSData *imageData = UIImageJPEGRepresentation(self.m_image,1);
//        
//        newsObj = [QQApiNewsObject
//                   objectWithURL:[NSURL URLWithString:utf8String]
//                   title:title
//                   description:description
//                    previewImageData:imageData];
//        
//    }else{
//       
//        NSData * imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://chat.leiyu.tv/upload/news/logo.png"]];
//        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageData:imageData];
//    }
//    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
//    QQApiSendResultCode sent;
//    if (type == SharingQQ) {
//        //将内容分享到qq
//        sent = [QQApiInterface sendReq:req];
//    }else{
//        //将内容分享到qzone
//        sent = [QQApiInterface SendReqToQZone:req];
//    }
//    
//    [self handleSendResult:sent];
//    
//}
////判断QQ分享
//- (void)handleSendResult:(QQApiSendResultCode)sendResult
//{
//    switch (sendResult)
//    {
//        case EQQAPIAPPNOTREGISTED:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//            
//            
//            break;
//        }
//        case EQQAPIMESSAGECONTENTINVALID:
//        case EQQAPIMESSAGECONTENTNULL:
//        case EQQAPIMESSAGETYPEINVALID:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//            
//            
//            break;
//        }
//        case EQQAPIQQNOTINSTALLED:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//            
//            
//            break;
//        }
//        case EQQAPIQQNOTSUPPORTAPI:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//            
//            
//            break;
//        }
//        case EQQAPISENDFAILD:
//        {
//            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//            [msgbox show];
//            
//            
//            break;
//        }
//        default:
//        {
//            break;
//        }
//    }
//}
////微博分享
//- (void)WBShareImage:(BOOL)image type:(SharingType)type
//{
//    WBMessageObject *message = [WBMessageObject message];
//    WBWebpageObject *webpage = [WBWebpageObject object];
//    webpage.objectID = @"";
//    webpage.title = self.m_model.m_title;
//    webpage.description = self.m_model.m_summary;
//    webpage.webpageUrl = self.m_model.m_shareUrl;
//    
//    if (image) {
//         float with=([self.m_model.m_imgWith floatValue]*80)/[self.m_model.m_imgHeight floatValue];
//        CGSize size = CGSizeMake(with, 80);
//        UIImage * iamgea = [self imageWithImage:self.m_image scaledToSize:size];
//        NSData *fData = UIImageJPEGRepresentation(iamgea, 0.5);
//        NSData * imageData = fData;
//        webpage.thumbnailData = imageData;
//        
//    }else{
//       
//        NSData * imageData =[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://chat.leiyu.tv/upload/news/logo.png"]];
//        webpage.thumbnailData = imageData;
//    }
//    
//    message.mediaObject = webpage;
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
//    [WeiboSDK sendRequest:request];
//}
//-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//    // Create a graphics image context
//    UIGraphicsBeginImageContext(newSize);
//    
//    // Tell the old image to draw in this new context, with the desired
//    // new size
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    
//    // Get the new image from the context
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // End the context
//    UIGraphicsEndImageContext();
//    
//    // Return the new image.
//    return newImage;
//}
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/

@end
