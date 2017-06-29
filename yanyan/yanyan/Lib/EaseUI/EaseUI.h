//
//  EaseUI.h
//  EaseUI
//
//  Created by EaseMob on 15/10/22.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "EaseMessageViewController.h"
#import "EaseViewController.h"

#import "IModelCell.h"
#import "IModelChatCell.h"
#import "EaseMessageCell.h"
#import "EaseBaseMessageCell.h"
#import "EaseBubbleView.h"
#import "EaseUserCell.h"


#import "EaseChineseToPinyin.h"
#import "EaseEmoji.h"
#import "EaseEmotionEscape.h"
#import "EaseEmotionManager.h"
#import "EaseSDKHelper.h"
#import "EMCDDeviceManager.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "EaseConvertToCommonEmoticonsHelperD.h"
#import "NSDate+Category.h"
#import "NSString+Valid.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+HUD.h"
#import "UIViewController+DismissKeyboard.h"
#define NSEaseLocalizedString(key, comment) [[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"EaseUIResource" withExtension:@"bundle"]] localizedStringForKey:(key) value:@"" table:nil]
@interface EaseUI : NSObject

@end
