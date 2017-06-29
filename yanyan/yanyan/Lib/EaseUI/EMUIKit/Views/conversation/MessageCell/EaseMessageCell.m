//
//  EaseMessageCell.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseMessageCell.h"
#import "UIImage+UIColor.h"
#import "EaseBubbleView+Text.h"
#import "EaseBubbleView+Image.h"
#import "EaseBubbleView+Location.h"
#import "EaseBubbleView+Voice.h"
#import "EaseBubbleView+Video.h"
#import "EaseBubbleView+File.h"
#import "EaseBubbleView+Share.h"
#import "EaseBubbleView+News.h"

#import "UIImageView+WebCache.h"
#import "EaseEmotionEscape.h"
#import "NSAttributedString+YYText.h"
#import "UIImage+GIF.h"
#import "YYAnimatedImageView.h"


CGFloat const EaseMessageCellPadding = 10;

NSString *const EaseMessageCellIdentifierRecvText = @"EaseMessageCellRecvText";
NSString *const EaseMessageCellIdentifierRecvLocation = @"EaseMessageCellRecvLocation";
NSString *const EaseMessageCellIdentifierRecvVoice = @"EaseMessageCellRecvVoice";
NSString *const EaseMessageCellIdentifierRecvVideo = @"EaseMessageCellRecvVideo";
NSString *const EaseMessageCellIdentifierRecvImage = @"EaseMessageCellRecvImage";
NSString *const EaseMessageCellIdentifierRecvFile = @"EaseMessageCellRecvFile";
NSString *const EaseMessageCellIdentifierRecvShare = @"EaseMessageCellIdentifierRecvShare";
NSString *const EaseMessageCellIdentifierRecvShare2 = @"EaseMessageCellIdentifierRecvShare2";
NSString *const EaseMessageCellIdentifierRecvNews = @"EaseMessageCellIdentifierRecvNews";
NSString *const EaseMessageCellIdentifierRecvInterest = @"EaseMessageCellIdentifierSendInterest";//感兴趣

NSString *const EaseMessageCellIdentifierSendText = @"EaseMessageCellSendText";
NSString *const EaseMessageCellIdentifierSendLocation = @"EaseMessageCellSendLocation";
NSString *const EaseMessageCellIdentifierSendVoice = @"EaseMessageCellSendVoice";
NSString *const EaseMessageCellIdentifierSendVideo = @"EaseMessageCellSendVideo";
NSString *const EaseMessageCellIdentifierSendImage = @"EaseMessageCellSendImage";
NSString *const EaseMessageCellIdentifierSendFile = @"EaseMessageCellSendFile";
NSString *const EaseMessageCellIdentifierSendShare = @"EaseMessageCellIdentifierSendShare";
NSString *const EaseMessageCellIdentifierSendShare2 = @"EaseMessageCellIdentifierSendShare2";
NSString *const EaseMessageCellIdentifierSendNews = @"EaseMessageCellIdentifierSendNews";
NSString *const EaseMessageCellIdentifierSendInterest = @"EaseMessageCellIdentifierSendInterest";//感兴趣
@interface EaseMessageCell()
{
    EMMessageBodyType _messageType;
}

@property (nonatomic) NSLayoutConstraint *statusWidthConstraint;
@property (nonatomic) NSLayoutConstraint *activtiyWidthConstraint;
@property (nonatomic) NSLayoutConstraint *hasReadWidthConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleMaxWidthConstraint;

@end

@implementation EaseMessageCell

@synthesize statusButton = _statusButton;
@synthesize bubbleView = _bubbleView;
@synthesize hasRead = _hasRead;
@synthesize activity = _activity;

+ (void)initialize
{
    
    // UIAppearance Proxy Defaults
    EaseMessageCell *cell = [self appearance];
    cell.statusSize = 20;
    cell.activitySize = 20;
   
        cell.bubbleMaxWidth = LCDW>320?250: 200;
    
    
    /*  warden_bubble    */
    cell.leftBubbleMargin = UIEdgeInsetsMake(15,25,15,25);
    cell.rightBubbleMargin = UIEdgeInsetsMake(15,25,15,25);
    cell.bubbleMargin = UIEdgeInsetsMake(15, 0, 15, 0);
    
//    cell.leftBubbleMargin = UIEdgeInsetsMake(8, 26, 8, 17);
//    cell.rightBubbleMargin = UIEdgeInsetsMake(8, 17, 8, 26);
//    cell.bubbleMargin = UIEdgeInsetsMake(8, 0, 8, 0);

    //原版
    //    cell.leftBubbleMargin = UIEdgeInsetsMake(8, 15, 8, 10);
    //        cell.rightBubbleMargin = UIEdgeInsetsMake(8, 10, 8, 15);
    //        cell.bubbleMargin = UIEdgeInsetsMake(8, 0, 8, 0);
   
    /*  warden_bubble    */
    //    cell.leftBubbleMargin = UIEdgeInsetsMake(15,25,2,24);
    //    cell.rightBubbleMargin = UIEdgeInsetsMake(15,24,2,25);
    //    cell.bubbleMargin = UIEdgeInsetsMake(15, 0, 2, 0);
  
    /*  bubble */
//    cell.leftBubbleMargin = UIEdgeInsetsMake(10,25,10, 15);
//    cell.rightBubbleMargin = UIEdgeInsetsMake(10,15,10,25);
//    cell.bubbleMargin = UIEdgeInsetsMake(10, 0, 10, 0);
    
    cell.messageTextFont = [UIFont systemFontOfSize:16];
    cell.messageTextColor =RGBChatTextColor;
    
    cell.messageLocationFont = [UIFont systemFontOfSize:10];
    cell.messageLocationColor = [UIColor whiteColor];
    
    cell.messageVoiceDurationColor = [UIColor grayColor];
    cell.messageVoiceDurationFont = [UIFont systemFontOfSize:12];
    
    cell.messageFileNameColor = [UIColor blackColor];
    cell.messageFileNameFont = [UIFont systemFontOfSize:13];
    cell.messageFileSizeColor = [UIColor grayColor];
    cell.messageFileSizeFont = [UIFont systemFontOfSize:11];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(id<IMessageModel>)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _messageType = model.bodyType;
        [self _setupSubviewsWithType:_messageType
                            isSender:model.isSender
                               model:model];
    }
    
    return self;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - setup subviews

- (void)_setupSubviewsWithType:(EMMessageBodyType)messageType
                      isSender:(BOOL)isSender
                         model:(id<IMessageModel>)model
{
    _statusButton = [[UIButton alloc] init];
    _statusButton.translatesAutoresizingMaskIntoConstraints = NO;
    _statusButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_statusButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/messageSendFail"] forState:UIControlStateNormal];
    [_statusButton addTarget:self action:@selector(statusAction) forControlEvents:UIControlEventTouchUpInside];
    _statusButton.hidden = YES;
    [self.contentView addSubview:_statusButton];
    
    _bubbleView = [[EaseBubbleView alloc] initWithMargin:isSender?_rightBubbleMargin:_leftBubbleMargin isSender:isSender];
    _bubbleView.translatesAutoresizingMaskIntoConstraints = NO;
    _bubbleView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_bubbleView];
    
    _avatarView = [[UIImageView alloc] init];
    _avatarView.translatesAutoresizingMaskIntoConstraints = NO;
    _avatarView.backgroundColor = [UIColor clearColor];
    _avatarView.clipsToBounds = YES;
    _avatarView.userInteractionEnabled = YES;
    [self.contentView addSubview:_avatarView];
    
    
    _m_textButton=[[UIButton alloc] init];
    _m_textButton.translatesAutoresizingMaskIntoConstraints = NO;
   [ _m_textButton setTitle:@"感兴趣" forState:UIControlStateNormal];
     [ _m_textButton setTitle:@"已感兴趣" forState:UIControlStateSelected];
    [_m_textButton setBackgroundImage:[UIImage imageWithColor:RGBACOLOR(27, 109, 165, 1)] forState:UIControlStateHighlighted];
    [_m_textButton setBackgroundColor:RGBACOLOR(86, 171, 228, 1) ];
//    [_m_textButton setHidden:YES];
//    _m_textButton.backgroundColor = [UIColor redColor];
    _m_textButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [DTools getCorner:_m_textButton radius:15];
    [_m_textButton addTarget:self action:@selector(clickTextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_m_textButton];

 
    
    
    
    //xiong 2016.4.7 距离
    //==============
    _m_distancelab = [[UILabel alloc] init];
    //如果是从代码层面开始使用Autolayout,需要对使用的View的translatesAutoresizingMaskIntoConstraints的属性设置为NO.
   // 即可开始通过代码添加Constraint,否则View还是会按照以往的autoresizingMask进行计算.
    _m_distancelab.translatesAutoresizingMaskIntoConstraints = NO;
    //_m_distancelab.text = @"";
    _m_distancelab.textAlignment = NSTextAlignmentCenter;
    _m_distancelab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_m_distancelab];
    
    
    
    _m_sexImageView = [[UIImageView alloc] init];
    _m_sexImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _m_sexImageView.backgroundColor = [UIColor clearColor];
//    [_m_sexImageView setImage:[UIImage imageNamed: @"man"]];
    [_m_sexImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.contentView addSubview:_m_sexImageView];
    
    _m_locationImageView = [[UIImageView alloc] init];
    _m_locationImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _m_locationImageView.backgroundColor = [UIColor clearColor];
    _m_locationImageView.clipsToBounds = YES;
    _m_locationImageView.userInteractionEnabled = YES;
    [_m_locationImageView setImage:[UIImage imageNamed: @"chatroom_map_small"]];
    [self.contentView addSubview:_m_locationImageView];
    
    
    
    _m_locationlab = [[UILabel alloc] init];
    //如果是从代码层面开始使用Autolayout,需要对使用的View的translatesAutoresizingMaskIntoConstraints的属性设置为NO.
    // 即可开始通过代码添加Constraint,否则View还是会按照以往的autoresizingMask进行计算.
    _m_locationlab.translatesAutoresizingMaskIntoConstraints = NO;
   _m_locationlab.text = @"";
    _m_locationlab.textAlignment = NSTextAlignmentCenter;
    _m_locationlab.font = [UIFont systemFontOfSize:12];
    [_m_locationlab sizeToFit];
    [self.contentView addSubview:_m_locationlab];
    
    //==============
    _hasRead = [[UILabel alloc] init];
    _hasRead.translatesAutoresizingMaskIntoConstraints = NO;
    _hasRead.text = NSEaseLocalizedString(@"hasRead", @"Read");
    _hasRead.textAlignment = NSTextAlignmentCenter;
    _hasRead.font = [UIFont systemFontOfSize:12];
    _hasRead.hidden = YES;
    [_hasRead sizeToFit];
    [self.contentView addSubview:_hasRead];
    
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activity.translatesAutoresizingMaskIntoConstraints = NO;
    _activity.backgroundColor = [UIColor clearColor];
    _activity.hidden = YES;
    [self.contentView addSubview:_activity];
    //xiong 2016.4.28 赋值
    
    //================
    
    int type=[[model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
    if(type==4)
    {
        [_bubbleView setupShareBubbleView];
        NSString *urlAvatar=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_AVATAR];
        NSString *titleStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_NAME];
        NSString *contentStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_CONTENT];
        [_bubbleView.m_avatarImageView sd_setImageWithURL:[NSURL URLWithString:urlAvatar] placeholderImage:ImageNamed(K_avaterPHImage)];
        _bubbleView.m_titleLabel.text =[NSString stringWithFormat:@"分享群组:%@",titleStr];
        _bubbleView.m_contentLabel.text =contentStr;
        [self _setupConstraints];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewTapAction:)];
        [_bubbleView addGestureRecognizer:tapRecognizer];
        
        UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarViewTapAction:)];
        [_avatarView addGestureRecognizer:tapRecognizer2];
        return;
    }
    if(type==7)
    {
        [_bubbleView setupNewsBubbleView];
        
            NSString *urlAvatar=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_NEWS_IMGURL];
            NSString *titleStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_NEWS_TITLE];
            
            [_bubbleView.newsIconView sd_setImageWithURL:[NSURL URLWithString:urlAvatar] placeholderImage:ImageNamed(K_newsPHImage)];
            _bubbleView.newsNameLabel.text =titleStr;
  
        [self _setupConstraints];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewTapAction:)];
        [_bubbleView addGestureRecognizer:tapRecognizer];
        
        UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarViewTapAction:)];
        [_avatarView addGestureRecognizer:tapRecognizer2];
        return;
    }
    
    //================
    if ([self respondsToSelector:@selector(isCustomBubbleView:)] && [self isCustomBubbleView:model]) {
        [self setCustomBubbleView:model];
    } else {
        switch (messageType)
        {
            case EMMessageBodyTypeText:
            {
                [_bubbleView setupTextBubbleView];
                
                     _bubbleView.textLabel.font = _messageTextFont;
                    _bubbleView.textLabel.textColor = _messageTextColor;
                
            }
                break;
            case EMMessageBodyTypeImage:
            {
                [_bubbleView setupImageBubbleView];
                
                _bubbleView.imageView.image = [UIImage imageNamed:@"EaseUIResource.bundle/imageDownloadFail"];
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                [_bubbleView setupLocationBubbleView];
                
                _bubbleView.locationImageView.image = [[UIImage imageNamed:@"EaseUIResource.bundle/chat_location_preview"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
                _bubbleView.locationLabel.font = _messageLocationFont;
                _bubbleView.locationLabel.textColor = _messageLocationColor;
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                [_bubbleView setupVoiceBubbleView];
                
                _bubbleView.voiceDurationLabel.textColor = _messageVoiceDurationColor;
                _bubbleView.voiceDurationLabel.font = _messageVoiceDurationFont;
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                [_bubbleView setupVideoBubbleView];
                
                _bubbleView.videoTagView.image = [UIImage imageNamed:@"chatroom_play"];
            }
                break;
            case EMMessageBodyTypeFile:
            {
                [_bubbleView setupFileBubbleView];
                
                _bubbleView.fileNameLabel.font = _messageFileNameFont;
                _bubbleView.fileNameLabel.textColor = _messageFileNameColor;
                _bubbleView.fileSizeLabel.font = _messageFileSizeFont;
            }
                break;
//            case EMMessageBodyTypeShare:
//            {
//                [_bubbleView setupShareBubbleView];
//                
//                _bubbleView.fileNameLabel.font = _messageFileNameFont;
//                _bubbleView.fileNameLabel.textColor = _messageFileNameColor;
//                _bubbleView.fileSizeLabel.font = _messageFileSizeFont;
//            }
//                break;
            default:
                break;
        }
    }
    
    [self _setupConstraints];
    
    int cid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
  
    
    //判断是不是url
    if(![self isUrlStr:model.text])
    {
        //不是url
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewTapAction:)];
        tapRecognizer.delegate=self;
        [_bubbleView addGestureRecognizer:tapRecognizer];
    }else
    
    {//如果是url  且是感心趣 类型 也要有点击事件  要不然就会出现 感兴趣文字点击不了
        if (cid>0)
        {
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewTapAction:)];
            tapRecognizer.delegate=self;
            [_bubbleView addGestureRecognizer:tapRecognizer];
        }
    }
    
    
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarViewTapAction:)];
    [_avatarView addGestureRecognizer:tapRecognizer2];
}

#pragma mark - Setup Constraints

- (void)_setupConstraints
{

   self.bubbleWithBubbleBottomConstraint=[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EaseMessageCellPadding/2];
    [self addConstraint:self.bubbleWithBubbleBottomConstraint];
 

    
    
    //status button
    self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.statusSize];
    [self addConstraint:self.statusWidthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.statusButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    //activtiy
    self.activtiyWidthConstraint = [NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.activitySize];
    [self addConstraint:self.activtiyWidthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.activity attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    

}

#pragma mark - Update Constraint

- (void)_updateHasReadWidthConstraint
{
    if (_hasRead) {
        [self removeConstraint:self.hasReadWidthConstraint];
        
        self.hasReadWidthConstraint = [NSLayoutConstraint constraintWithItem:_hasRead attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:40];
        [self addConstraint:self.hasReadWidthConstraint];
    }
}

- (void)_updateStatusButtonWidthConstraint
{
    if (_statusButton) {
        [self removeConstraint:self.statusWidthConstraint];
        
        self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.statusSize];
        [self addConstraint:self.statusWidthConstraint];
    }
}

- (void)_updateActivityWidthConstraint
{
    if (_activity) {
        [self removeConstraint:self.activtiyWidthConstraint];
        
        self.statusWidthConstraint = [NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.activitySize];
        [self addConstraint:self.activtiyWidthConstraint];
    }
}

- (void)_updateBubbleMaxWidthConstraint
{
    [self removeConstraint:self.bubbleMaxWidthConstraint];
    int type=[[_model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
    if(type==4||type==7)
    {
        self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:(LCDW>320?250: 200)];
        [self addConstraint:self.bubbleMaxWidthConstraint];
    }else
    {
        self.bubbleMaxWidthConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bubbleMaxWidth];
        [self addConstraint:self.bubbleMaxWidthConstraint];
    }

}

#pragma mark - setter

- (void)setModel:(id<IMessageModel>)model
{
    
    
   
    
        //普通气泡
    _bubbleView.backgroundImageView.image = [DTools ChatDubbleDetermineType:0 direction:model.isSender];
    
    
    
    //
    [_bubbleView.backgroundImageView setHidden:NO];
    [_bubbleView.videoTagView setHidden:YES];
    _model = model;
    if ([self respondsToSelector:@selector(isCustomBubbleView:)] && [self isCustomBubbleView:model]) {
        [self setCustomModel:model];
    } else {
        
        //xiong 2016.4.28 赋值
        
        //================
        
        int type=[[model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
        if(type==4)
        {
            NSString *urlAvatar=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_AVATAR];
            NSString *titleStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_NAME];
            NSString *descStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_DESC];
            NSString *contentStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_CONTENT];
            [_bubbleView.m_avatarImageView sd_setImageWithURL:[NSURL URLWithString:urlAvatar] placeholderImage:ImageNamed(K_avaterPHImage)];
            _bubbleView.m_titleLabel.text =[NSString stringWithFormat:@"分享群组:%@",titleStr];
            _bubbleView.m_descLabel.text =descStr;
            _bubbleView.m_contentLabel.text =contentStr;
            return;
        }
        if(type==7)
        {
            NSString *urlAvatar=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_NEWS_IMGURL];
            NSString *titleStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_NEWS_TITLE];
    
            [_bubbleView.newsIconView sd_setImageWithURL:[NSURL URLWithString:urlAvatar] placeholderImage:ImageNamed(K_newsPHImage)];
            _bubbleView.newsNameLabel.text =titleStr;
     
       
            return;
        }
        //================
        switch (model.bodyType) {
            case EMMessageBodyTypeText:
            {
                
                
             
                
                
                int cid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
                 NSString * create=[model.message.ext objectForKey:K_createUserSendMessage];
                                    
                if (cid>0)
                {
                    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   self.messageTextFont,NSFontAttributeName,
                                                  _messageTextColor,NSForegroundColorAttributeName
                                                  ,nil];
                   
                    
                    
                 
                    NSString *text=[NSString stringWithFormat:@"HI~我创建了%@聊天室,有没有兴趣一起来聊天？   点击查看",model.text];
                    [text replaceUnicode];
                    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:text  attributes:attributeDict];
                    
                    [AttributedStr addAttribute:NSForegroundColorAttributeName
                     
                                          value:[UIColor orangeColor]
                     
                                          range:NSMakeRange(7, model.text.length)];
                    
                    
                    [AttributedStr addAttribute:NSForegroundColorAttributeName
                     
                                          value: RGBACOLOR(0, 122, 255, 1)
                     
                                          range:NSMakeRange(text.length-4, 4)];
                    
                   _bubbleView.textLabel.attributedText = AttributedStr;

                }else  if([create isEqualToString:K_createUserSendMessage])
                {
                    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                                   self.messageTextFont,NSFontAttributeName,
                                                   _messageTextColor,NSForegroundColorAttributeName
                                                   ,nil];
                    
                    
                    
                    
                    
                    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:model.text  attributes:attributeDict];
                    
                    [AttributedStr addAttribute:NSForegroundColorAttributeName
                     
                                          value:[UIColor redColor]
                     
                                          range:NSMakeRange(0, 4)];
                    
                    
                   
                    
                    _bubbleView.textLabel.attributedText = AttributedStr;
                }
                else  if([self isUrlStr:model.text])
                {
                    _bubbleView.textLabel.attributedText =[self cheackUrlStr:model.text];
                
                }else
                {
                    _bubbleView.textLabel.attributedText =[[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:model.text textFont:self.messageTextFont];
                    _bubbleView.textLabel.textColor = _messageTextColor;
                }
                
            }
                break;
            case EMMessageBodyTypeImage:
            {
                CGSize retSize = model.thumbnailImageSize;
                
                
                if (retSize.width == 0 || retSize.height == 0) {
                    retSize.width = kEMMessageImageSizeWidth;
                    retSize.height = kEMMessageImageSizeHeight;
                }
                else if(retSize.width > kEMMessageImageSizeWidth || retSize.height > kEMMessageImageSizeHeight){
                
                  
                    
                   //代码优化 求比例相乘
                    CGFloat W = kEMMessageImageSizeWidth / retSize.width;
                    CGFloat H = kEMMessageImageSizeHeight / retSize.height;
                    
                    CGFloat scale =  MIN(W, H);
                    
                    retSize.width *= scale;
                    retSize.height *= scale;
                    
                }
                

              [_bubbleView.backgroundImageView setHidden:YES];
                
                for (UIView *subviews in [self.bubbleView subviews]) {
                    [subviews removeFromSuperview];
                }
                  CGRect imageRect=CGRectMake(0, 0, retSize.width, model.cellHeight);//-20不知道什么原因
                CGRect frame = imageRect;
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
                
                CAShapeLayer *layer = [CAShapeLayer layer];
                
                layer.frame = imageView.bounds;
                
                        if (model.isSender)
                        {
                              layer.contents = (id)[UIImage imageNamed:@"bubble-2"].CGImage;
                        }else
                        {
                              layer.contents  = (id)[UIImage imageNamed:@"bubble-1"].CGImage;
                        }
                layer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
                layer.contentsScale = [UIScreen mainScreen].scale;
                imageView.layer.mask = layer;
                imageView.layer.frame = imageView.frame;
                imageView.image= ImageNamed(@"ease_default_image");
               
              
                UIImage *image = _model.thumbnailImage;
                if (!image) {
                    image = _model.image;
                    if (!image) {
                        
                        [_bubbleView addSubview:imageView];
                        [_bubbleView.imageView sd_setImageWithURL:[NSURL URLWithString:_model.fileURLPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                        {
                            
                            if(!error)
                            {
                             [imageView removeFromSuperview];
                                imageView.image = image;
                                [_bubbleView addSubview:imageView];
                            }else
                            {
                             [_bubbleView addSubview:imageView];
                            }
                           
                           

                        }];
                        
                       
                    } else {
                        
                        imageView.image = image;
                        [_bubbleView addSubview:imageView];

                    }
                } else {
                    
                    imageView.image = image;
                    [_bubbleView addSubview:imageView];
                    

//                    
                    
                 
                }
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                _bubbleView.locationLabel.text = _model.address;
            }
                break;

            case EMMessageBodyTypeVoice:
            {
                if (_bubbleView.voiceImageView) {
                  
                    self.bubbleView.voiceImageView.image = self.model.isSender ? [UIImage imageNamed:@"chat_sender_audio_playing_full"] : [UIImage imageNamed:@"chat_receiver_audio_playing_full"];
                    _bubbleView.voiceImageView.animationImages = self.model.isSender ? self.sendMessageVoiceAnimationImages:self.recvMessageVoiceAnimationImages;
                }
                if (!self.model.isSender) {
                    if (self.model.isMediaPlayed){
                        _bubbleView.isReadView.hidden = YES;
                    } else {
                        _bubbleView.isReadView.hidden = NO;
                    }
                }
                
                if (_model.isMediaPlaying) {
                    [_bubbleView.voiceImageView startAnimating];
                }
                else{
                    [_bubbleView.voiceImageView stopAnimating];
                }
                
                _bubbleView.voiceDurationLabel.text = [NSString stringWithFormat:@"%d''",(int)_model.mediaDuration];
            }
            break;

            case EMMessageBodyTypeVideo:
            {
                
                CGSize retSize = model.thumbnailImage.size;
                if (retSize.width == 0 || retSize.height == 0) {
                    retSize.width = kEMMessageImageSizeWidth;
                    retSize.height = kEMMessageImageSizeHeight;
                }
                else if (retSize.width > retSize.height) {
                    CGFloat height =  kEMMessageImageSizeWidth / retSize.width * retSize.height;
                    retSize.height = height;
                    retSize.width = kEMMessageImageSizeWidth;
                }
                else {
                    CGFloat width = kEMMessageImageSizeHeight / retSize.height * retSize.width;
                    retSize.width = width;
                    retSize.height = kEMMessageImageSizeHeight;
                }
                
                
                
                
                UIImage *image = _model.isSender ? _model.image : _model.thumbnailImage;
                image= [self scaleToSize:image size:retSize];
                
                [_bubbleView.backgroundImageView setHidden:YES];
                [_bubbleView.videoTagView setHidden:NO];
                CGRect imageRect=CGRectMake(0, 0, retSize.width, model.cellHeight);
                if (!image) {
                    image = _model.image;
                    if (!image) {
                        //  [_bubbleView.videoImageView sd_setImageWithURL:[NSURL URLWithString:_model.fileURLPath] placeholderImage:[UIImage imageNamed:_model.failImageName]];
                        _bubbleView._maskLayer.frame = imageRect;
                        _bubbleView._contentLayer.frame = imageRect;
                        _bubbleView._contentLayer.contents = (id)ImageNamed(@"ease_default_image").CGImage;
                        
                          UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
                        [_bubbleView addSubview:imageView];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:_model.fileURLPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                         {
                             _bubbleView._maskLayer.frame = imageRect;
                             _bubbleView._contentLayer.frame = imageRect;
                             [imageView removeFromSuperview];
                             if(!error)
                             {
                                
                                 
                                 _bubbleView._contentLayer.contents = (id)image.CGImage;
                             }else
                             {
                                
                                
                                 _bubbleView._contentLayer.contents = (id)ImageNamed(@"ease_default_image").CGImage;
                             }

                            
                         }];
                        
                    } else {
                        //_bubbleView.videoImageView.image = image;
                        
                        _bubbleView._maskLayer.frame = imageRect;
                        _bubbleView._contentLayer.frame = imageRect;
                        _bubbleView._contentLayer.contents = (id)image.CGImage;
                    }
                } else {
                    //_bubbleView.videoImageView.image = image;
                    
                    _bubbleView._maskLayer.frame = imageRect;
                    _bubbleView._contentLayer.frame = imageRect;
                    _bubbleView._contentLayer.contents = (id)image.CGImage;
                }
//                _bubbleView.videoImageView.image = image;
            }

                break;
            case EMMessageBodyTypeFile:
            {
                _bubbleView.fileIconView.image = [UIImage imageNamed:_model.fileIconName];
                _bubbleView.fileNameLabel.text = _model.fileName;
                _bubbleView.fileSizeLabel.text = _model.fileSizeDes;
            }
                break;
            default:
                break;
        }
    }
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
- (void)setStatusSize:(CGFloat)statusSize
{
    _statusSize = statusSize;
    [self _updateStatusButtonWidthConstraint];
}

- (void)setActivitySize:(CGFloat)activitySize
{
    _activitySize = activitySize;
    [self _updateActivityWidthConstraint];
}

- (void)setSendBubbleBackgroundImage:(UIImage *)sendBubbleBackgroundImage
{
//    CGFloat top = 23; // 顶端盖高度
//    CGFloat bottom = 13 ; // 底端盖高度
//    CGFloat left = 10; // 左端盖宽度
//    CGFloat right = 20; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
//    sendBubbleBackgroundImage = [sendBubbleBackgroundImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    

  _sendBubbleBackgroundImage = sendBubbleBackgroundImage;
}

- (void)setRecvBubbleBackgroundImage:(UIImage *)recvBubbleBackgroundImage
{
//    CGFloat top = 13; // 顶端盖高度
//    CGFloat bottom = 13 ; // 底端盖高度
//    CGFloat left = 20; // 左端盖宽度
//    CGFloat right = 10; // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
//    recvBubbleBackgroundImage = [recvBubbleBackgroundImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    _recvBubbleBackgroundImage = recvBubbleBackgroundImage;
}

- (void)setBubbleMaxWidth:(CGFloat)bubbleMaxWidth
{
    _bubbleMaxWidth = bubbleMaxWidth;
    [self _updateBubbleMaxWidthConstraint];
}

- (void)setRightBubbleMargin:(UIEdgeInsets)rightBubbleMargin
{
    _rightBubbleMargin = rightBubbleMargin;
}

- (void)setLeftBubbleMargin:(UIEdgeInsets)leftBubbleMargin
{
    _leftBubbleMargin = leftBubbleMargin;
}

- (void)setBubbleMargin:(UIEdgeInsets)bubbleMargin
{
    _bubbleMargin = bubbleMargin;
    _bubbleMargin = self.model.isSender ? _rightBubbleMargin:_leftBubbleMargin;
    if ([self respondsToSelector:@selector(isCustomBubbleView:)] && [self isCustomBubbleView:_model]) {
        [self updateCustomBubbleViewMargin:_bubbleMargin model:_model];
    } else {
        if (_bubbleView)
        {
            //xiong 2016.4.28
            
            //================
            float width =LCDW>320?250: 200;
            
            
            //    }
           width -= (self.leftBubbleMargin.left + self.leftBubbleMargin.right + self.rightBubbleMargin.left + self.rightBubbleMargin.right)/2;
            
    
            //================
            
          
            

            int type=[[self.model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
            if(type==4)
            {
                 NSString *contentStr=[self.model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_CONTENT];
                if (contentStr.length>0) {
                    NSAttributedString *text = [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:contentStr textFont:[UIFont systemFontOfSize:16]];
                    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
                  
                     _bubbleView.m_descLabelHeight=rect.size.height;
                }else
                {
                     _bubbleView.m_descLabelHeight=0;
                }
               
                [_bubbleView updateShareMargin:_bubbleMargin];
                return;
            }
            if (type==7)
            {
              
                [_bubbleView updateNewsMargin:_bubbleMargin];
                return;

            }
            //================
           
            switch (_messageType) {
                case EMMessageBodyTypeText:
                {
                    [_bubbleView updateTextMargin:_bubbleMargin];
                }
                    break;
                case EMMessageBodyTypeImage:
                {
//                    [_bubbleView updateImageMargin:_bubbleMargin];
                }
                    break;
                case EMMessageBodyTypeLocation:
                {
                    [_bubbleView updateLocationMargin:_bubbleMargin];
                }
                    break;
                case EMMessageBodyTypeVoice:
                {
                    [_bubbleView updateVoiceMargin:_bubbleMargin];
                }
                    break;
                case EMMessageBodyTypeVideo:
                {
                    [_bubbleView updateVideoMargin:_bubbleMargin];
                }
                    break;
                case EMMessageBodyTypeFile:
                {
                    [_bubbleView updateFileMargin:_bubbleMargin];
                }
                    break;
//                case EMMessageBodyTypeShare:
//                {
//                    [_bubbleView updateShareMargin:_bubbleMargin];
//                }
//                    break;
                default:
                    break;
            }
            
        }
    }
}

- (void)setMessageTextFont:(UIFont *)messageTextFont
{
    _messageTextFont = messageTextFont;
    if (_bubbleView.textLabel) {
        _bubbleView.textLabel.font = messageTextFont;
    }
}

- (void)setMessageTextColor:(UIColor *)messageTextColor
{
    _messageTextColor = messageTextColor;
    if (_bubbleView.textLabel)
    {
        int uid=[[_model.message.ext objectForKey:K_CID_TOPIC] intValue];
          NSString * create=[_model.message.ext objectForKey:K_createUserSendMessage];
        if (uid>0)
        {
            NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           self.messageTextFont,NSFontAttributeName,
                                           _messageTextColor,NSForegroundColorAttributeName
                                           ,nil];
     
            NSString *text=[NSString stringWithFormat:@"HI~我创建了%@聊天室,有没有兴趣一起来聊天？   点击查看",_model.text];
            [text replaceUnicode];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:text  attributes:attributeDict];
            
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor orangeColor]
             
                                  range:NSMakeRange(7, _model.text.length)];
            
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value: RGBACOLOR(0, 122, 255, 1)
             
                                  range:NSMakeRange(text.length-4, 4)];
            
            _bubbleView.textLabel.attributedText = AttributedStr;

        }else  if([create isEqualToString:K_createUserSendMessage])
        {
            NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           self.messageTextFont,NSFontAttributeName,
                                           _messageTextColor,NSForegroundColorAttributeName
                                           ,nil];
            
            
            
            
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:_model.text  attributes:attributeDict];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor redColor]
             
                                  range:NSMakeRange(0, 4)];
            
            
            
            
            _bubbleView.textLabel.attributedText = AttributedStr;
        }

        else  if([self isUrlStr:_model.text])
        {
            _bubbleView.textLabel.attributedText =[self cheackUrlStr:_model.text];
            
        }else
        {
            _bubbleView.textLabel.textColor = _messageTextColor;
        }
        
    }
}

- (void)setMessageLocationColor:(UIColor *)messageLocationColor
{
    _messageLocationColor = messageLocationColor;
    if (_bubbleView.locationLabel) {
        _bubbleView.locationLabel.textColor = _messageLocationColor;
    }
}

- (void)setMessageLocationFont:(UIFont *)messageLocationFont
{
    _messageLocationFont = messageLocationFont;
    if (_bubbleView.locationLabel) {
        _bubbleView.locationLabel.font = _messageLocationFont;
    }
}

- (void)setSendMessageVoiceAnimationImages:(NSArray *)sendMessageVoiceAnimationImages
{
    _sendMessageVoiceAnimationImages = sendMessageVoiceAnimationImages;
}

- (void)setRecvMessageVoiceAnimationImages:(NSArray *)recvMessageVoiceAnimationImages
{
    _recvMessageVoiceAnimationImages = recvMessageVoiceAnimationImages;
}

- (void)setMessageVoiceDurationColor:(UIColor *)messageVoiceDurationColor
{
    _messageVoiceDurationColor = messageVoiceDurationColor;
    if (_bubbleView.voiceDurationLabel) {
        _bubbleView.voiceDurationLabel.textColor = _messageVoiceDurationColor;
    }
}

- (void)setMessageVoiceDurationFont:(UIFont *)messageVoiceDurationFont
{
    _messageVoiceDurationFont = messageVoiceDurationFont;
    if (_bubbleView.voiceDurationLabel) {
        _bubbleView.voiceDurationLabel.font = _messageVoiceDurationFont;
    }
}

- (void)setMessageFileNameFont:(UIFont *)messageFileNameFont
{
    _messageFileNameFont = messageFileNameFont;
    if (_bubbleView.fileNameLabel) {
        _bubbleView.fileNameLabel.font = _messageFileNameFont;
    }
}

- (void)setMessageFileNameColor:(UIColor *)messageFileNameColor
{
    _messageFileNameColor = messageFileNameColor;
    if (_bubbleView.fileNameLabel) {
        _bubbleView.fileNameLabel.textColor = _messageFileNameColor;
    }
}

- (void)setMessageFileSizeFont:(UIFont *)messageFileSizeFont
{
    _messageFileSizeFont = messageFileSizeFont;
    if (_bubbleView.fileSizeLabel) {
        _bubbleView.fileSizeLabel.font = _messageFileSizeFont;
    }
}

- (void)setMessageFileSizeColor:(UIColor *)messageFileSizeColor
{
    _messageFileSizeColor = messageFileSizeColor;
    if (_bubbleView.fileSizeLabel) {
        _bubbleView.fileSizeLabel.textColor = _messageFileSizeColor;
    }
}

#pragma mark - action

- (void)bubbleViewTapAction:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        if (!_delegate) {
            return;
        }
        
        if ([self respondsToSelector:@selector(isCustomBubbleView:)] && [self isCustomBubbleView:_model]) {
            if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                [_delegate messageCellSelected:_model];
                return;
            }
        }
        int type=[[_model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
        if(type==4)
        {
            if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                [_delegate messageCellSelected:_model];
            }
            return;
        }
        if(type==7)
        {
            if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                [_delegate messageCellSelected:_model];
            }
            return;
        }

        switch (_model.bodyType) {
            case EMMessageBodyTypeText:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                    [_delegate messageCellSelected:_model];
                }
            }
                break;
            case EMMessageBodyTypeImage:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                    [_delegate messageCellSelected:_model];
                }
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                    [_delegate messageCellSelected:_model];
                }
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                    [_delegate messageCellSelected:_model];
                }
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                    [_delegate messageCellSelected:_model];
                }
            }
                break;
            case EMMessageBodyTypeFile:
            {
                if ([_delegate respondsToSelector:@selector(messageCellSelected:)]) {
                    [_delegate messageCellSelected:_model];
                }
            }
                break;
            default:
                break;
        }
    }
}

- (void)avatarViewTapAction:(UITapGestureRecognizer *)tapRecognizer
{
    if ([_delegate respondsToSelector:@selector(avatarViewSelcted:)]) {
        [_delegate avatarViewSelcted:_model];
    }
}

- (void)statusAction
{
    if ([_delegate respondsToSelector:@selector(statusButtonSelcted:withMessageCell:)]) {
        [_delegate statusButtonSelcted:_model withMessageCell:self];
    }
}

#pragma mark - IModelCell

#pragma mark - public

+ (NSString *)cellIdentifierWithModel:(id<IMessageModel>)model
{
  static  NSString *cellIdentifier = nil;
    if (model.isSender) {
        
        
        int type=[[model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
        if(type==4)
        {
            
            NSString *contentStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_CONTENT];
            if (contentStr.length>0)
            {
                cellIdentifier=EaseMessageCellIdentifierSendShare2;
            }else
            {
                cellIdentifier=EaseMessageCellIdentifierSendShare;
            }
            return cellIdentifier;
        }
        if(type==7)
        {
            cellIdentifier=EaseMessageCellIdentifierSendNews;
     
            return cellIdentifier;
        }

        switch (model.bodyType) {
            case EMMessageBodyTypeText:
                cellIdentifier = EaseMessageCellIdentifierSendText;
                break;
            case EMMessageBodyTypeImage:
                cellIdentifier = EaseMessageCellIdentifierSendImage;
                break;
            case EMMessageBodyTypeVideo:
                cellIdentifier = EaseMessageCellIdentifierSendVideo;
                break;
            case EMMessageBodyTypeLocation:
                cellIdentifier = EaseMessageCellIdentifierSendLocation;
                break;
            case EMMessageBodyTypeVoice:
                cellIdentifier = EaseMessageCellIdentifierSendVoice;
                break;
            case EMMessageBodyTypeFile:
                cellIdentifier = EaseMessageCellIdentifierSendFile;
                break;
//            case EMMessageBodyTypeShare:
//                cellIdentifier = EaseMessageCellIdentifierSendShare;
//                break;
            default:
                break;
        }
    }
    else{
        
        int type=[[model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
        if(type==4)
        {
            //防止重用
            NSString *contentStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_CONTENT];
            if (contentStr.length>0)
            {
                cellIdentifier=EaseMessageCellIdentifierRecvShare2;
            }else
            {
             cellIdentifier=EaseMessageCellIdentifierRecvShare;
            }
          
            return cellIdentifier;
        }
        if(type==7)
        {
            cellIdentifier=EaseMessageCellIdentifierRecvNews;
            
            return cellIdentifier;
        }
        int uid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
        if (uid>0)
        {
            cellIdentifier=EaseMessageCellIdentifierRecvInterest;
            
            return cellIdentifier;
        }
        switch (model.bodyType) {
                
                
                
            case EMMessageBodyTypeText:
                cellIdentifier = EaseMessageCellIdentifierRecvText;
                break;
            case EMMessageBodyTypeImage:
                cellIdentifier = EaseMessageCellIdentifierRecvImage;
                break;
            case EMMessageBodyTypeVideo:
                cellIdentifier = EaseMessageCellIdentifierRecvVideo;
                break;
            case EMMessageBodyTypeLocation:
                cellIdentifier = EaseMessageCellIdentifierRecvLocation;
                break;
            case EMMessageBodyTypeVoice:
                cellIdentifier = EaseMessageCellIdentifierRecvVoice;
                break;
            case EMMessageBodyTypeFile:
                cellIdentifier = EaseMessageCellIdentifierRecvFile;
                break;
//            case EMMessageBodyTypeShare:
//                cellIdentifier = EaseMessageCellIdentifierRecvShare;
//                break;

            default:
                break;
        }
    }
    
    return cellIdentifier;
}

+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model
{
    EaseMessageCell *cell = [self appearance];
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }

//    EaseMessageCell *cell = [self appearance];
    CGFloat bubbleMaxWidth = cell.bubbleMaxWidth;
//    if ([UIDevice currentDevice].systemVersion.floatValue == 7.0) {
    
            bubbleMaxWidth =LCDW>320?250: 200;
      
        
//    }
    bubbleMaxWidth -= (cell.leftBubbleMargin.left + cell.leftBubbleMargin.right + cell.rightBubbleMargin.left + cell.rightBubbleMargin.right)/2;
    
    CGFloat height = cell.bubbleMargin.top + cell.bubbleMargin.bottom;
    //================
    
    int type=[[model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
    if(type==4)
    {
           NSString *contentStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_GROUP_CONTENT];
        if(contentStr.length>0)
        {
            NSAttributedString *text = [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:contentStr textFont:[UIFont systemFontOfSize:16]];
            CGRect rect = [text boundingRectWithSize:CGSizeMake(bubbleMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
            height+=90+rect.size.height;
        }else
        {
            height+=90;
        }
    
       // height += EaseMessageCellPadding;
        model.cellHeight = height;
//        bubbleMaxWidth=300;
//        cell.bubbleMaxWidth=270;
        return height;
       
    }
    if(type==7)
    {
        NSString *contentStr=[model.message.ext safeObjectForKey:K_MESSAGE_ATTR_NEWS_TITLE];
        
    
    
//    CGRect    nameRect = [contentStr boundingRectWithSize:CGSizeMake(bubbleMaxWidth-85, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
        
      
        float height2=  [self CalcuText:contentStr width:bubbleMaxWidth-85];
        //距离图片 5+60+10   加距离右边背景10
        
            height=cell.bubbleMargin.top + cell.bubbleMargin.bottom+height2+40;
        //距离上边背景10 lable 高20  底部10
        if (height<84+cell.bubbleMargin.top + cell.bubbleMargin.bottom)
        {
            height=84+cell.bubbleMargin.top + cell.bubbleMargin.bottom;
        }
       
        model.cellHeight = height;
     
      
        return height;
        
    }
    
    //================
    switch (model.bodyType) {
        case EMMessageBodyTypeText:
        {
            
            NSAttributedString *text;
           // DLog(@"%@",model.message.ext);
            int cid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
            if (cid>0)
            {
              
                NSString *texts=[NSString stringWithFormat:@"HI~我创建了%@聊天室,有没有兴趣一起来聊天？   点击查看",model.text];
                [texts replaceUnicode];
               text = [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:texts textFont:cell.messageTextFont];
            }else
            {
                text = [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:model.text textFont:cell.messageTextFont];
            
            }
           
            //xiong 2016.4.7 高
            CGSize size = CGSizeMake(bubbleMaxWidth, CGFLOAT_MAX);
           //  DLog(@"返回的高度 ------ size --------- ：W:%f,H:%f",size.width,size.height);
            YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
            //================
            //================
            //xiong 2016.4.28
            
             height += (layout.textBoundingSize.height > 20 ? layout.textBoundingSize.height : 20)+10;
           
        }
            break;
        case EMMessageBodyTypeImage:
        {
            CGSize retSize = model.thumbnailImageSize;
            if (retSize.width == 0 || retSize.height == 0) {
                retSize.width = kEMMessageImageSizeWidth;
                retSize.height = kEMMessageImageSizeHeight;
            }
            else if(retSize.width > kEMMessageImageSizeWidth || retSize.height > kEMMessageImageSizeHeight){
                
                
                //代码优化 求比例相乘
                CGFloat W = kEMMessageImageSizeWidth / retSize.width;
                CGFloat H = kEMMessageImageSizeHeight / retSize.height;
                
                CGFloat scale =  MIN(W, H);
                
                retSize.width *= scale;
                retSize.height *= scale;

            }
            height = retSize.height;

           
        }
            
            break;
        case EMMessageBodyTypeVideo:
       {
            CGSize retSize = model.thumbnailImageSize;
            if (retSize.width == 0 || retSize.height == 0) {
                retSize.width = kEMMessageImageSizeWidth;
                retSize.height = kEMMessageImageSizeHeight;
            }
            else if(retSize.width > kEMMessageImageSizeWidth || retSize.height > kEMMessageImageSizeHeight){
                
                
                //代码优化 求比例相乘
                CGFloat W = kEMMessageImageSizeWidth / retSize.width;
                CGFloat H = kEMMessageImageSizeHeight / retSize.height;
                
                CGFloat scale =  MIN(W, H);
                
                retSize.width *= scale;
                retSize.height *= scale;
                

                
                
                
                
                


            }
           
           
           //视频不需要间距
           height = retSize.height;
           
          
        }
            
            break;
        case EMMessageBodyTypeLocation:
        {
            height += kEMMessageLocationHeight;
        }
            break;
        case EMMessageBodyTypeVoice:
        {
            //xiong 2016.4.7 高
            
            //================
            
            
            if (model.isSender)
            {
                height -= kEMMessageVoiceHeight;
                
            }else
            {
                height += kEMMessageVoiceHeight;
            }
            //================
           
        }
            break;
        case EMMessageBodyTypeFile:
        {
            NSString *text = model.fileName;
            UIFont *font = cell.messageFileNameFont;
            CGRect nameRect = [text boundingRectWithSize:CGSizeMake(bubbleMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
            
            height += (nameRect.size.height > 20 ? nameRect.size.height : 20);
            
            text = model.fileSizeDes;
            font = cell.messageFileSizeFont;
            CGRect sizeRect = [text boundingRectWithSize:CGSizeMake(bubbleMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
           
            height += (sizeRect.size.height > 15 ? sizeRect.size.height : 15);
        }
            break;
        default:
            break;
    }

   
    model.cellHeight = height;
  // DLog(@"返回的高度 ------ &&&&&&&&&&& --------- ：%f",height);
    return height;
}
//计算文本高度
//+(float)CalcuText:(NSString *)str width:(float) width
//{
//    UILabel * labelText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
//    labelText.text = str;
//    labelText.lineBreakMode = NSLineBreakByCharWrapping;
//    labelText.numberOfLines = 0;
//    labelText.font=[UIFont systemFontOfSize:16];
////    [labelText sizeToFit];
//    //    //高度计算公式
//       CGSize size = [labelText sizeThatFits:CGSizeMake(CGRectGetWidth(labelText.frame), MAXFLOAT)];
//   
//    return size.height;
//}
//计算文本高度
+(float)CalcuText:(NSString *)str width:(float) width
{
    UILabel * labelText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,width, MAXFLOAT)];
    labelText.font = [UIFont systemFontOfSize:16];
    labelText.text = str;
    labelText.lineBreakMode = NSLineBreakByTruncatingTail;
    labelText.numberOfLines = 0;
  
    CGSize size = [labelText sizeThatFits:CGSizeMake(CGRectGetWidth(labelText.frame), MAXFLOAT)];
    
    return size.height;
}

-(void)clickTextButton:(UIButton *)sender
{
    
 
    if([self.delegate respondsToSelector:@selector(messageTextButton:::)])
    {
        [self.delegate messageTextButton:_model :self.m_indexPath :sender];
    }
}
/**
 *
 *判断是否是网址
 *
 *  @param Urlstr 聊天信息
 *
 *  @return YES/NO
 */
- (BOOL) isUrlStr:(NSString *) Urlstr
{
    
    if (Urlstr == nil) {
        return nil;
    }
    NSError *error = nil;
    NSRegularExpression *regex =[NSRegularExpression regularExpressionWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:NSRegularExpressionCaseInsensitive error:&error ];
    
    NSArray* matches = [regex matchesInString:Urlstr options:NSMatchingReportCompletion range:NSMakeRange(0, [Urlstr length])];
    if (matches.count>0)
    {
        return YES;
    }else
    {
        return NO;
    }
}
/**
 *
 *  聊天框
 *
 *  @param aInputText <#aInputText description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableAttributedString *) cheackUrlStr:(NSString *) Urlstr
{
    
    if (Urlstr == nil) {
        return nil;
    }
    NSError *error = nil;
    NSRegularExpression *regex =[NSRegularExpression regularExpressionWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:NSRegularExpressionCaseInsensitive error:&error ];
    
    NSArray* matches = [regex matchesInString:Urlstr options:NSMatchingReportCompletion range:NSMakeRange(0, [Urlstr length])];
    NSMutableAttributedString * string = [[ NSMutableAttributedString alloc ] initWithString:Urlstr attributes:nil ];
    if (matches.count>0)
    {
        for (NSTextCheckingResult *match in matches)
        {
            NSRange matchRange = [match range];
//            NSString *subStr = [Urlstr substringWithRange:matchRange];
            
            [string addAttribute:NSForegroundColorAttributeName
             
                           value:RGBACOLOR(30, 144, 255, 1)
             
                           range:matchRange];
            [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:16.0] range:matchRange];
            YYTextHighlight *highlight = [YYTextHighlight new];
            [highlight setColor:[UIColor whiteColor]];
            
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                //                if ([self.delegate respondsToSelector:@selector(messageCellUrl)])
                //                {
                //                    [self.delegate messageCellUrl:text.string];
                //                }
                
                NSRange range2 = {0, 4};
                NSString *http= [text.string substringWithRange:range2];
                
              //  DLog(@"text.string了-----%@",[text.string substringWithRange:range]);
                NSURL* url;
                if (![http isEqualToString:@"http"])
                {
                    url= [[ NSURL alloc ] initWithString :[NSString stringWithFormat:@"http://%@",text.string]];
                    
                }else
                {
//                    [[ NSURL alloc ] initWithString:@"www.bfidfd.com"]
                    url= [[ NSURL alloc ] initWithString :text.string];
                }
                [[UIApplication sharedApplication ] openURL:url options:@{} completionHandler:^(BOOL success) {
              
                    DLog(@"是否成功--%i",success);
                }];
            };
            [string yy_setTextHighlight:highlight range:matchRange];
          //  DLog(@"找到了-----%@",subStr);
        }
    }
    return string;

    NSString *urlPattern =  @"(\\[[\\s\\S]*?\\])";

    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:urlPattern options:NSRegularExpressionCaseInsensitive error:&error ];
    
    NSArray* matches2 = [regex2 matchesInString:Urlstr options:NSMatchingReportCompletion range:NSMakeRange(0, [Urlstr length])];
   
    
    int delNum = 0;
    for (NSTextCheckingResult *match in matches2) {
        NSRange matchRange = [match range];
        NSString *subStr = [Urlstr substringWithRange:matchRange];
        
        
        EMTextAttachment* textAttachment = [[EMTextAttachment alloc] init];
        textAttachment.bounds = CGRectMake(0, 0,20,20);
        UIImage * emojiImage;
        NSString *emojiName = [EaseConvertToCommonEmoticonsHelperD convertToSystemEmoticons:subStr];
        textAttachment.imageName = emojiName;
        
        emojiImage = [UIImage imageNamed:emojiName];
        UIImageView* imag = [[UIImageView alloc] init];
        imag.image = [UIImage sd_animatedGIFNamed:emojiName];
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:[UIImage sd_animatedGIFNamed:emojiName]];
        //        imageView.backgroundColor=[UIColor redColor];
        NSMutableAttributedString * textAttachmentString;
        NSAttributedString * textAttachmentString2;
        if (emojiImage) {
            
            textAttachmentString= [NSMutableAttributedString yy_attachmentStringWithContent:imag contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(30, 30) alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentCenter];
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
    if (matches.count>0)
    {
        
        return string;
    }else
    {
        return nil;
    }
    
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
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([touch.view isKindOfClass:[YYLabel class]]){
////        YYLabel *label = (YYLabel *)touch.view;
////        if ([label containslinkAtPoint:[touch locationInView:label]]){
//            return NO;
////        }else{
////            return YES;
////        }
//    }else{
//        return YES;
//    }
//}
@end
