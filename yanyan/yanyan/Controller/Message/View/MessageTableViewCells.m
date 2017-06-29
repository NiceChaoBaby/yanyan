//
//  MessageTableViewCell.m
//  yanyan
//
//  Created by xiong on 2017/6/28.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "MessageTableViewCells.h"

@implementation MessageTableViewCells


-(UIImageView*)m_imgMessagePhoto
{
    if (!_m_imgMessagePhoto)
    {
        _m_imgMessagePhoto=[UIImageView new];
    }
    return _m_imgMessagePhoto;
}

-(UILabel*)m_labTime
{
    if (!_m_labTime)
    {
        _m_labTime=[[UILabel alloc]initWithFont:12 textColor:[UIColor blackColor]];
       
    }
    return _m_labTime;
}
-(UILabel*)m_labLastMessage
{
    if (!_m_labLastMessage) {
        _m_labLastMessage=[[UILabel alloc]initWithFont:14 textColor:[UIColor grayColor]];
    }
    return _m_labLastMessage;
}
-(UILabel*)m_labMessageName
{
    if (!_m_labMessageName) {
        _m_labMessageName=[[UILabel alloc]initWithFont:15 textColor:[UIColor blackColor]];
    }
    return _m_labMessageName;
}
-(UILabel*)m_labNumberMessage
{
    if (!_m_labNumberMessage) {
        _m_labNumberMessage=[[UILabel alloc]initWithFont:14 textColor:[UIColor whiteColor]];
        _m_labNumberMessage.backgroundColor=[UIColor blueColor];
    }
    return _m_labNumberMessage;
}
// 重写构造方法 -- 只调用一次嘛 （套路来的！务必记住！）
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self initSD];
    }
    
    return self;
}

-(void)initSD
{
     [self.contentView sd_addSubviews:@[self.m_imgMessagePhoto,self.m_labNumberMessage,self.m_labMessageName,self.m_labTime,self.m_labLastMessage]];

    //头像
    self.m_imgMessagePhoto.sd_layout
    .leftSpaceToView(self.contentView, RW(20))
    .centerYEqualToView(self.contentView)
    .widthIs(RW(100))
    .heightIs(RW(100));
   
    //
    self.m_labMessageName.sd_layout
    .topSpaceToView(self.contentView, RW(25))
    .leftSpaceToView(self.m_labMessageName, RW(10))
    .autoHeightRatio(0);
    
    self.m_labLastMessage.sd_layout
    .topSpaceToView(self.m_labMessageName, RW(15))
    .leftSpaceToView(self.m_labMessageName, RW(10))
    .autoHeightRatio(0);
    
}
@end
