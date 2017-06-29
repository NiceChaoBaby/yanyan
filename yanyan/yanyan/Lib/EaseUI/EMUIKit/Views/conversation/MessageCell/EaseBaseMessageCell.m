//
//  EaseBaseMessageCell.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/30.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseBaseMessageCell.h"

#import "UIImageView+WebCache.h"

@interface EaseBaseMessageCell()

@property (strong, nonatomic) UILabel *nameLabel;

@property (nonatomic) NSLayoutConstraint *avatarWidthConstraint;
@property (nonatomic) NSLayoutConstraint *nameHeightConstraint;
@property (nonatomic) NSLayoutConstraint *sexWidthConstraint;
@property (nonatomic) NSLayoutConstraint *distanceHeightConstraint;

@property (nonatomic) NSLayoutConstraint *bubbleWithAvatarRightConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithoutAvatarRightConstraint;

@property (nonatomic) NSLayoutConstraint *bubbleWithNameTopConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithoutNameTopConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithImageConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithVideoConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithTextConstraint;

@end

@implementation EaseBaseMessageCell

@synthesize nameLabel = _nameLabel;

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseBaseMessageCell *cell = [self appearance];
    cell.avatarSize = 40;
    cell.avatarCornerRadius = 0;
    
    cell.messageNameColor = RGBAddAssistColor;
    cell.messageNameFont = [UIFont systemFontOfSize:14];
    cell.messageNameHeight =15;
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        cell.messageNameIsHidden = NO;
    }
    
//    cell.bubbleMargin = UIEdgeInsetsMake(8, 15, 8, 10);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(id<IMessageModel>)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier model:model];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = _messageNameFont;
        _nameLabel.textColor = _messageNameColor;
        [self.contentView addSubview:_nameLabel];
        
        
        //xiong 2016.4.7 m_distancelab
        
        //================
        self.m_distancelab.backgroundColor=RGBBeginChatColor;
        self.m_distancelab.textColor=[UIColor whiteColor];
        self.m_distancelab.font=[UIFont systemFontOfSize:12];
        self.m_distancelab.textAlignment=NSTextAlignmentCenter;
        [DTools getCorner:self.m_distancelab radius:2];
        
       
        
        
        self.m_locationlab.textColor=[UIColor whiteColor];
        self.m_locationlab.backgroundColor=RGBBgNavColor;
        self.m_locationlab.font=[UIFont systemFontOfSize:11];

       
        //================

       
        [self configureLayoutConstraintsWithModel:model];
        
        if ([UIDevice currentDevice].systemVersion.floatValue == 7.0) {
            self.messageNameHeight = 15;
        }
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    _bubbleView.backgroundImageView.image = self.model.isSender ? self.sendBubbleBackgroundImage : self.recvBubbleBackgroundImage;
    if ([self respondsToSelector:@selector(isCustomBubbleView:)] && [self isCustomBubbleView:self.model]) {
        return;
    
    }
    //xiong 2016.4.28 
    
    //================
    
    int type=[[self.model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
    if(type==4||type==7)
    {
       
        return;
    }
    
     //================
    switch (self.model.bodyType) {
        case EMMessageBodyTypeText:
        {
            [self removeConstraint:self.bubbleWithTextConstraint];
            
            int cid=[[self.model.message.ext objectForKey:K_CID_TOPIC] intValue];
            NSAttributedString *text;
            if (cid>0)
            {
               
                
                
                
                
              NSString *  text11=[NSString stringWithFormat:@"HI~我创建了%@聊天室,有没有兴趣一起来聊天？   点击查看",self.model.text];
                [text11 replaceUnicode];
                 text= [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:text11 textFont:[UIFont systemFontOfSize:16]];
            }else
            {
             text= [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:self.model.text textFont:[UIFont systemFontOfSize:16]];
            }

            

            CGSize size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
            YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
            ;
            float width=0;
            if (layout.textBoundingSize.width>self.bubbleMaxWidth)
            {
                width=self.bubbleMaxWidth;
            }else
            {
                width=layout.textBoundingSize.width;
            }
            
            
            CGFloat margin = [EaseMessageCell appearance].leftBubbleMargin.left + [EaseMessageCell appearance].leftBubbleMargin.right;
            
            
            self.bubbleWithTextConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width+margin];
           // NSLog(@"layout.textBoundingSize.width===%f===width==%f",layout.textBoundingSize.width,width);
            [self addConstraint:self.bubbleWithTextConstraint];
        }
            break;
        case EMMessageBodyTypeVideo:
        {
            CGSize retSize = self.model.thumbnailImageSize;
            
          //  DLog(@"W = %f  H = %f",retSize.width,retSize.height);
            //            retSize.width -=43;
            //            retSize.height +=20;
            if (retSize.width == 0 || retSize.height == 0) {
                retSize.width = kEMMessageImageSizeWidth;
                retSize.height = kEMMessageImageSizeHeight;
            }
            else  if(retSize.width > kEMMessageImageSizeWidth || retSize.height > kEMMessageImageSizeHeight)
            {
                
                //代码优化 求比例相乘
                CGFloat W = kEMMessageImageSizeWidth / retSize.width;
                CGFloat H = kEMMessageImageSizeHeight / retSize.height;
                
                CGFloat scale =  MIN(W, H);
                
                retSize.width *= scale;
                retSize.height *= scale;
                
            }else if(retSize.width > kEMMessageImageSizeWidth || retSize.height > kEMMessageImageSizeHeight){
                //代码优化 求比例相乘
                CGFloat W = kEMMessageImageSizeWidth / retSize.width;
                CGFloat H = kEMMessageImageSizeHeight / retSize.height;
                
                CGFloat scale =  MIN(W, H);
                
                retSize.width *= scale;
                retSize.height *= scale;
            }
          //  DLog(@"W = %f  H = %f",retSize.width,retSize.height);
            [self removeConstraint:self.bubbleWithVideoConstraint];
            //环信原来是图片外围有气泡的所以要加这个气泡的边距 leftBubbleMargin 和 rightBubbleMargin 而我们现在图片不需要气泡所以不加
//                  CGFloat margin = [EaseMessageCell appearance].leftBubbleMargin.left + [EaseMessageCell appearance].leftBubbleMargin.right;
            //约束图片气泡的宽
            self.bubbleWithVideoConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:retSize.width];
            [self addConstraint:self.bubbleWithVideoConstraint];

            break;
        }
        case EMMessageBodyTypeImage:
        {
            
            CGSize retSize = self.model.thumbnailImageSize;
            
           // DLog(@"W = %f  H = %f",retSize.width,retSize.height);
//            retSize.width -=43;
//            retSize.height +=20;
            if (retSize.width == 0 || retSize.height == 0) {
                retSize.width = kEMMessageImageSizeWidth;
                retSize.height = kEMMessageImageSizeHeight;
            }
            else  if(retSize.width > kEMMessageImageSizeWidth || retSize.height > kEMMessageImageSizeHeight){
                
                //代码优化 求比例相乘
                CGFloat W = kEMMessageImageSizeWidth / retSize.width;
            CGFloat H = kEMMessageImageSizeHeight / retSize.height;
            
            CGFloat scale =  MIN(W, H);
            
            retSize.width *= scale;
            retSize.height *= scale;
            
            }
          //  DLog(@"W = %f  H = %f",retSize.width,retSize.height);
            [self removeConstraint:self.bubbleWithImageConstraint];
            //环信原来是图片外围有气泡的所以要加这个气泡的边距 leftBubbleMargin 和 rightBubbleMargin 而我们现在图片不需要气泡所以不加
//            CGFloat margin = [EaseMessageCell appearance].leftBubbleMargin.left + [EaseMessageCell appearance].leftBubbleMargin.right;
            //约束图片气泡的宽
            self.bubbleWithImageConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:retSize.width];
             [self addConstraint:self.bubbleWithImageConstraint];
        }
            break;
        case EMMessageBodyTypeLocation:
        {
            
        }
            break;
        case EMMessageBodyTypeVoice:
        {
        }
            break;
       
        case EMMessageBodyTypeFile:
        {
        }
            break;
        default:
            break;
    }
}

- (void)configureLayoutConstraintsWithModel:(id<IMessageModel>)model
{
    if (model.isSender) {
        //xiong 2016.4.7 修改视图是否显示
        //================
        
       [self.m_distancelab setHidden:YES];
        [self.nameLabel setHidden:YES];
        [self.m_locationImageView setHidden:YES];
        [self.m_locationlab setHidden:YES];
      [self.m_sexImageView setHidden:YES];
        //================
        
        [self configureSendLayoutConstraints:(id<IMessageModel>)model];
    } else {
        
        
        //xiong 2016.4.7 修改视图是否显示
        //================
        
        [self.m_distancelab setHidden:NO];
        [self.nameLabel setHidden:NO];
        [self.m_locationImageView setHidden:NO];
        [self.m_locationlab setHidden:NO];
          [self.m_sexImageView setHidden:NO];
        //================
        [self configureRecvLayoutConstraints:(id<IMessageModel>)model];
    }
}

- (void)configureSendLayoutConstraints:(id<IMessageModel>)model
{
    if (self.bubbleWithBubbleBottomConstraint==nil)
    {
        self.bubbleWithBubbleBottomConstraint=[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-EaseMessageCellPadding/2];
        [self addConstraint:self.bubbleWithBubbleBottomConstraint];
    }
    //avatar view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseMessageCellPadding]];
    
    self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.avatarSize];
    [self addConstraint:self.avatarWidthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
   
    NSString *roleName=[model.message.ext objectForKey:K_RoleName];
    if(![DTools isStringEmpty:roleName])
    {

    
//    //name label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
    
    self.nameHeightConstraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.messageNameHeight];
    [self addConstraint:self.nameHeightConstraint];
    
    }
    
    
    //bubble view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-1]];
    
    if([DTools isStringEmpty:roleName])
    {
     //xiong 2016.4.7 修改了约束
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    }else{
         [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    }
    //status button
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
    
    //activity
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.activity attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
    
    //hasRead
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.hasRead attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-EaseMessageCellPadding]];
}

- (void)configureRecvLayoutConstraints:(id<IMessageModel>)model
{
    //    //bubble view
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.m_textButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseMessageCellPadding/2]];
     int type=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
  //  DLog(@"type大于0不=======%i",type);
    if (type>0)
    {
        [self.m_textButton setHidden:NO];
        [self removeConstraint:self.bubbleWithBubbleBottomConstraint];
       // DLog(@"type大于0不=======%i",type);
        
        //感兴趣按钮
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_textButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_textButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bubbleView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:EaseMessageCellPadding]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_textButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        //    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_textButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.m_textButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_textButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_textButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    }
    
    //avatar view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:EaseMessageCellPadding]];
    
    self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.avatarSize];
    [self addConstraint:self.avatarWidthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
     NSString *roleName=[model.message.ext objectForKey:K_RoleName];
    if([DTools isStringEmpty:roleName])
    {
        //sex ImageView
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_sexImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_sexImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:8]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_sexImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:9]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_sexImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15]];
    }
  
    //self.messageNameHeight   第一次运行为0 导致sex  约束了看不到
    //name label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    if([DTools isStringEmpty:roleName])
    {
         [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.m_sexImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:4]];
    }else
    {
         [self addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:8]];
    }
   
    
    self.nameHeightConstraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.messageNameHeight];
    [self addConstraint:self.nameHeightConstraint];
    //xiong 2016.4.7 距离
    
    //================
    
    //distance label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_distancelab attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15]];
   
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_distancelab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_distancelab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:EaseMessageCellPadding/2]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_distancelab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
     //m_locationImageView ImageView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_locationImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseMessageCellPadding/2]];
   
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_locationImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    //m_locationlab label
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_locationlab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.m_locationImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_locationlab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    

    //================
    //bubble view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.avatarView attribute:NSLayoutAttributeRight multiplier:1.0 constant:1]];
     //================

    
    self.bubbleWithNameTopConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraint:self.bubbleWithNameTopConstraint];
     //================
    
    
   
}

#pragma mark - Update Constraint

- (void)_updateAvatarViewWidthConstraint
{
    if (self.avatarView) {
        [self removeConstraint:self.avatarWidthConstraint];
        
        self.avatarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.avatarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:self.avatarSize];
        [self addConstraint:self.avatarWidthConstraint];
    }
}
//xiong 2016.4.7 修改约束

//================

- (void)_updateBubbleWithNameTopConstraint
{
    if (self.bubbleView) {
        [self removeConstraint:self.bubbleWithNameTopConstraint];
        
        self.bubbleWithNameTopConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraint:self.bubbleWithNameTopConstraint];
    }
}

//================

- (void)_updateNameHeightConstraint
{
    if (_nameLabel) {
        [self removeConstraint:self.nameHeightConstraint];
        
        self.nameHeightConstraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.messageNameHeight];
        [self addConstraint:self.nameHeightConstraint];
    }
}
- (void)_updateSexWidthConstraint
{
    if (_nameLabel) {
        [self removeConstraint:self.nameHeightConstraint];
        
        self.nameHeightConstraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.messageNameHeight];
        [self addConstraint:self.nameHeightConstraint];
    }
}
#pragma mark - setter

- (void)setModel:(id<IMessageModel>)model
{
    [super setModel:model];
    int cid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
     [self.m_textButton setHidden:YES];
    if (cid>0)
    {
        [self.m_textButton setHidden:NO];
        if(model.m_isSelect==NO)
        {
            
             [self.m_textButton setBackgroundColor:RGBACOLOR(86, 171, 228, 1) ];
            self.m_textButton.userInteractionEnabled=YES;
            [self.m_textButton setSelected:NO];
             [ self.m_textButton setTitle:@"感兴趣" forState:UIControlStateNormal];
        
            
        }else
        {
            [self.m_textButton setBackgroundColor:RGBACOLOR(179, 179, 179, 1) ];
            self.m_textButton.userInteractionEnabled=NO;
            [self.m_textButton setSelected:YES];
           
            [ self.m_textButton setTitle:@"已感兴趣" forState:UIControlStateSelected];
        
        }
        
    }
    int AGREE=[[model.message.ext objectForKey:K_CID_AGREE] intValue];
    if (AGREE>0)
    {
        
            [self.m_textButton setBackgroundColor:RGBACOLOR(179, 179, 179, 1) ];
            self.m_textButton.userInteractionEnabled=NO;
            [self.m_textButton setSelected:YES];
            
            [ self.m_textButton setTitle:@"已感兴趣" forState:UIControlStateSelected];
            
      
        
    }
    
    if (model.avatarURLPath)
    {
        
        if (![DTools isStringEmpty:[model.message.ext safeObjectForKey:K_RoleName]]) {
            //角色扮演头像是扮演角色头像
             [self.avatarView sd_setImageWithURL:[NSURL URLWithString:[model.message.ext safeObjectForKey:K_RoleAvatar]] placeholderImage:ImageNamed(K_avaterPHImage)];
        }else{
            
              [self.avatarView sd_setImageWithURL:[NSURL URLWithString:model.avatarURLPath] placeholderImage:ImageNamed(K_avaterPHImage)];
            
        }
       
    } else
    {
       
        self.avatarView.image =ImageNamed(K_avaterPHImage);
    }
    if (model.isSender) {
        //xiong 2016.4.7 修改视图是否显示
        //================
        
        [self.m_distancelab setHidden:YES];
        if (![DTools isStringEmpty:[model.message.ext safeObjectForKey:K_RoleName]])
        {

        [self.nameLabel setHidden:NO];
             [self setMessageNameIsHidden:NO];
        }else{
          [self.nameLabel setHidden:YES];
             [self setMessageNameIsHidden:YES];
        }
        [self.m_locationImageView setHidden:YES];
        [self.m_locationlab setHidden:YES];
        [self.m_sexImageView setHidden:YES];
        //================
        
//     [self setMessageNameIsHidden:YES];
    } else
    {
        
        
        //xiong 2016.4.7 修改视图是否显示
        //================
        
        [self.m_distancelab setHidden:NO];
        [self.nameLabel setHidden:NO];
        [self.m_locationImageView setHidden:NO];
        [self.m_locationlab setHidden:NO];
         [self setMessageNameIsHidden:NO];
         [self.m_sexImageView setHidden:NO];
        if(model.message.chatType==EMChatTypeChat)
        {
            [self setMessageNameIsHidden:YES];
             [self.m_sexImageView setHidden:YES];
        }
        //================
      //  [self configureRecvLayoutConstraints];
//        int uid=[[model.message.ext objectForKey:K_uid] intValue];
//            if (uid==[model.m_topicOwnerId intValue])
//            {
                [self.m_distancelab setHidden:YES];
        
//            }else
//            {
//                [self.m_distancelab setHidden:YES];
//            }
        
        if (![DTools isStringEmpty:[model.message.ext safeObjectForKey:K_RoleName]])
        {
            [self.m_sexImageView setHidden:YES];
        }
        //1男 2女
        if ([[model.message.ext safeObjectForKey:K_gender] intValue] ==1)
        {
            [self.m_sexImageView setImage:ImageNamed(@"man")];
          
        }else
        {
           [self.m_sexImageView setImage:ImageNamed(@"women")];
           
        }

       
       
    }
  

    NSString *roleName=[model.message.ext objectForKey:K_RoleName];
    if([DTools isStringEmpty:roleName])
    {
        _nameLabel.text = model.nickname;
    }else
    {
        _nameLabel.text = roleName;
    }
   
    //xiong 2016.4.8 距离赋值
    
    //================
    
//    self.m_distancelab.text=model.m_distanceText;
    
//    if ([model.m_locationText isNull]) {
//        self.m_distancelab.text=@"创建人";
    
//    }
    if (model.isSender)
    {
        [self.m_locationImageView setHidden:YES];
    }else
    {
        [self.m_locationImageView setHidden:YES];
        if ([model.m_locationText isNull]) {
           
             [self.m_locationImageView setHidden:NO];
        }else
        {
             [self.m_locationImageView setHidden:YES];
        
        }
        if(model.message.chatType==EMChatTypeChat)
        {
            [self.m_locationImageView setHidden:YES];
        }
    }
    
    
    
    [self.m_locationlab setHidden:YES];
    [self.m_locationImageView setHidden:YES];
      //================
    
    if (self.model.isSender) {
        _hasRead.hidden = YES;
        switch (self.model.messageStatus) {
            case EMMessageStatusDelivering:
            {
                _statusButton.hidden = YES;
                [_activity setHidden:NO];
                [_activity startAnimating];
            }
                break;
            case EMMessageStatusSuccessed:
            {
                _statusButton.hidden = YES;
                [_activity stopAnimating];
                if (self.model.isMessageRead) {
//                    _hasRead.hidden = NO;
                }
            }
                break;
            case EMMessageStatusPending:
            case EMMessageStatusFailed:
            {
                [_activity stopAnimating];
                [_activity setHidden:YES];
                _statusButton.hidden = NO;
            }
                break;
            default:
                break;
        }
    }
}

- (void)setMessageNameFont:(UIFont *)messageNameFont
{
    _messageNameFont = messageNameFont;
    if (_nameLabel) {
        _nameLabel.font = _messageNameFont;
    }
}

- (void)setMessageNameColor:(UIColor *)messageNameColor
{
    _messageNameColor = messageNameColor;
    if (_nameLabel) {
        _nameLabel.textColor = _messageNameColor;
    }
}

- (void)setMessageNameHeight:(CGFloat)messageNameHeight
{
    _messageNameHeight = messageNameHeight;
    if (_nameLabel) {
        [self _updateNameHeightConstraint];
    }
}

- (void)setAvatarSize:(CGFloat)avatarSize
{
    _avatarSize = avatarSize;
    if (self.avatarView) {
        [self _updateAvatarViewWidthConstraint];
    }
}

- (void)setAvatarCornerRadius:(CGFloat)avatarCornerRadius
{
    _avatarCornerRadius = avatarCornerRadius;
    if (self.avatarView){
        self.avatarView.layer.cornerRadius = avatarCornerRadius;
    }
}

- (void)setMessageNameIsHidden:(BOOL)messageNameIsHidden
{
    _messageNameIsHidden = messageNameIsHidden;
    if (_nameLabel) {
        _nameLabel.hidden = messageNameIsHidden;
        //xiong 2016.4.7 距离
        
        //================
        
        self.m_locationlab.hidden=messageNameIsHidden;
        self.m_locationImageView.hidden=messageNameIsHidden;
         [self _updateBubbleWithNameTopConstraint];
        //================
        
    }
}

#pragma mark - public

+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model
{
    
    
    EaseBaseMessageCell *cell = [self appearance];
    //xiong 2016.4.7 距离
    
    //================
    
    
    CGFloat minHeight ;
//    if (model.bodyType==EMMessageBodyTypeVoice)
//    {
//        minHeight=  cell.avatarSize;
//    }else
//    {
        minHeight= cell.avatarSize + EaseMessageCellPadding * 2 -5;
//    }
    //================
    CGFloat height=0;
    if(model.isSender)
    {
        
        NSString *roleName=[model.message.ext objectForKey:K_RoleName];
        if([DTools isStringEmpty:roleName])
        {
        
             height=5;// 加距离下面气泡5
        }else
        {
             height= cell.messageNameHeight+5;//5 加距离下面气泡5
        }
    }else
    {
        height= cell.messageNameHeight+5;//5 加距离下面气泡5
    }
   
   
  
    height +=[EaseMessageCell cellHeightWithModel:model];
    int uid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
    if (uid>0)
    {
     height+=40;
    }
    height = height > minHeight ? height : minHeight;
    //================
//    DLog(@"返回的高度 ------ 0 --------- ：%f",height);
    return height;
    

}

@end
