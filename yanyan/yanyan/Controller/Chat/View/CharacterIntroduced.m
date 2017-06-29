//
//  CharacterIntroduced.m
//  chat
//
//  Created by 高超 on 2017/5/18.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "CharacterIntroduced.h"
@implementation CharacterIntroduced

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(CharacterIntroduced *)shareInstance
{
    static id sharedInstance=nil;
    if(!sharedInstance)
    {
        
        sharedInstance = [[CharacterIntroduced alloc] initWithFrame:CGRectMake(0,0, LCDW, LCDH+20)];
        
    }
    return sharedInstance;
}

  // 这个方法显示角色介绍
-(void)addWaitingFigureView:(RoleIntroduceInfo*)model
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    if (self) {
        for (UIView *subviews in [self subviews]) {
            [subviews removeFromSuperview];
        }
    }
    self.backgroundColor=RGBACOLOR(0, 0, 0, 0.3);
    
    //这里写东西协议
    //背景图片
    UIImageView * m_imageView = [UIImageView new];
    m_imageView.backgroundColor = [UIColor whiteColor];
    m_imageView.userInteractionEnabled = YES;
    //角色头像
    UIImageView * m_userPhotoView = [UIImageView new];
    m_userPhotoView.backgroundColor = [UIColor clearColor];
    m_userPhotoView.contentMode = UIViewContentModeScaleAspectFill;
    m_userPhotoView.clipsToBounds = YES;
    //角色名称
    UILabel * m_UserName =  [UILabel new];
    m_UserName.textAlignment = NSTextAlignmentLeft;
    //这里是半粗体 [UIFont fontWithName:@"PingFangSC-Semibold" size:22.0f]  PingFangSC-Medium
    m_UserName.font = [UIFont systemFamilyFontOfSizeNoScale:22.0f];
    m_UserName.textColor = RGBChatTextColor;
    //textView
    UITextView * m_textView = [UITextView new];
    m_textView.font = [UIFont systemFamilyFontOfSizeNoScale:16.0f];
    m_textView.textColor = RGBChatTextColor;
    [m_textView setDelegate:self];
    //线
    UIView * m_view = [UIView new];
    m_view.backgroundColor =RGBLineColor;
    
    
    //按钮
    UIButton  * m_btn = [UIButton new];
    //    m_btn.backgroundColor = [UIColor greenColor];
    [m_btn addTarget:self action:@selector(clickClose:) forControlEvents:UIControlEventTouchUpInside];
    [m_btn setImage:ImageNamed(@"chatroom_close") forState:UIControlStateNormal];
    
    
    [DTools getAvaterCorner:m_imageView];
    
    //角色头像
    [m_userPhotoView sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(@"角色弹窗")];
    [DTools getAvaterCorner:m_userPhotoView];
    //角色名
    m_UserName.text = model.m_rname;
    //角色介绍
    m_textView.text =model.m_rdesc;
   
    
    //这里计算介绍的高度 如果超出最大高度  则使用最大高度   每超出则使用计算出来的高度 并且 禁止滑动效果
    float W = LCDW - 30 - 30 - 18 - 18;
    CGFloat H = [self heightForString:m_textView.text fontSize:16.0f andWidth:W];
   //算出来的高度只是文字高度 控件的内间距没有  所以加20的高度 不让字体显示不全
    if ((H+20) >  (LCDH/2 - 50)) {
        
        H = LCDH/2 - 50;
        
        [m_textView setUserInteractionEnabled:YES];
    }else{
        
        if ((H+20)< 112) {
            H = 112;
        }else{
        
        H+=20;
        }
        [m_textView setUserInteractionEnabled:NO];
        
    }
    [m_imageView sd_addSubviews:@[m_userPhotoView,m_UserName,m_textView,m_view,m_btn]];
    [self sd_addSubviews:@[m_imageView]];
  
    //背景图  白色
    m_imageView.sd_layout
    .leftSpaceToView(self,30)
    .rightSpaceToView(self,30)
    .autoHeightRatio(0)
    .centerYEqualToView(self);
    
    //角色头像
    m_userPhotoView.sd_layout
    .leftSpaceToView(m_imageView, 24)
    .topSpaceToView(m_imageView, 22)
    .widthIs(90)
    .heightIs(90);
    
    //角色名称
    m_UserName.sd_layout
    .leftSpaceToView(m_userPhotoView, 23)
    .rightSpaceToView(m_imageView,18)
    .topSpaceToView(m_imageView, 45);
    
    //角色介绍
    m_textView.sd_layout
    .leftSpaceToView(m_imageView,18)
    .rightSpaceToView(m_imageView,18)
    .topSpaceToView(m_userPhotoView,22)
    .heightIs(H);
    
    //分割线
    m_view.sd_layout
    .leftSpaceToView(m_imageView,0)
    .rightSpaceToView(m_imageView,0)
    .topSpaceToView(m_textView,12)
    .heightIs(1);
    
    //按钮
    m_btn.sd_layout
    .leftSpaceToView(m_imageView,0)
    .rightSpaceToView(m_imageView,0)
    .topSpaceToView(m_view,0)
    .heightIs(60);

    
     [m_imageView setupAutoHeightWithBottomViewsArray:@[m_btn] bottomMargin:0];
    
        //显示在界面上
    [self makeKeyAndVisible];
    
}

/**
@method 获取指定宽度情况ixa，字符串value的高度
@param value 待计算的字符串
@param fontSize 字体的大小
@param andWidth 限制字符串显示区域的宽度
@result float 返回的高度
*/
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
//    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
//    optionsattributes:@{NSFontAttributeName:[UIFontsystemFontOfSize:fontSize]}
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //这里注意 我们UIFont用的是自己特殊的字体的Font 所以  给系统计算高度的时候也要 [UIFont systemFamilyFontOfSize:fontSize] 用自己的设置的字体给系统 不然会高度不对
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:value attributes:@{NSFontAttributeName:[UIFont systemFamilyFontOfSize:fontSize], NSParagraphStyleAttributeName:style}];
       CGFloat labelH= [string boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX)options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
    return labelH;
}
-(void)clickClose:(UIButton *)btn
{
    
    [self dissMessView];
    
}


-(void)dissMessView
{
    [self resignKeyWindow];
    [self removeFromSuperview];
    self.hidden = YES;
    
    
}
-(void)tapAction
{
    
    [self dissMessView];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}



@end
