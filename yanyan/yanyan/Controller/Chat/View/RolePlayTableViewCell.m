//
//  RolePlayTableViewCell.m
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "RolePlayTableViewCell.h"

@implementation RolePlayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/**************************** 懒加载 ***********************************/
-(UIImageView *)m_userPhoto
{
    if (!_m_userPhoto) {
        _m_userPhoto = [UIImageView new];
         _m_userPhoto.backgroundColor = [UIColor clearColor];
    }
    
    return _m_userPhoto;
}
//用户名称
-(UILabel *)m_UserNamelabel
{
    if (!_m_UserNamelabel) {
        _m_UserNamelabel = [UILabel new];
        
        [_m_UserNamelabel setTextColor:RGBChatTextColor];
        _m_UserNamelabel.numberOfLines = 1;
        [_m_UserNamelabel setFont:[UIFont systemFamilyFontOfSize:16.f]];
    }
    
    return _m_UserNamelabel;
}


/**
 角色说明
 */
-(UILabel *)m_details
{
    if (!_m_details) {
        _m_details = [UILabel new];
        [_m_details setTextColor:RGBAssistColor];
        _m_details.numberOfLines = 1;
        [_m_details setFont:[UIFont systemFamilyFontOfSize:14.f]];
        
    }
    
    
    return _m_details;
}

-(UIButton *)m_stateBtn
{
    if (!_m_stateBtn) {
        _m_stateBtn = [UIButton new];
        [_m_stateBtn setTitleColor:RGBBgNavColor forState:UIControlStateNormal];
        _m_stateBtn.backgroundColor = [UIColor clearColor];
        _m_stateBtn.layer.borderWidth = 1;
        _m_stateBtn.layer.borderColor = RGBBgNavColor.CGColor;
        [_m_stateBtn setTitle:@"选择" forState:UIControlStateNormal];
        [_m_stateBtn addTarget:self action:@selector(clickStateRole:) forControlEvents:UIControlEventTouchUpInside];
        [DTools getCorner:_m_stateBtn radius:6];
        
    }
    
    return _m_stateBtn;
}

/********************************************************************/




// 重写构造方法 -- 只调用一次嘛 （套路来的！务必记住！）
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView sd_addSubviews:@[self.m_userPhoto,self.m_UserNamelabel,self.m_details,self.m_stateBtn]];
        
    self.m_userPhoto.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 7.5)
        .widthIs(50)
        .heightIs(50);
        
    self.m_stateBtn.sd_layout
        .rightSpaceToView(self.contentView, 10)
        .centerYEqualToView(self.contentView)
        .widthIs(60)
        .heightIs(33);
        
   self.m_UserNamelabel.sd_layout
        .leftSpaceToView(self.m_userPhoto, 10)
        .rightSpaceToView(self.m_stateBtn, 15)
        .topSpaceToView(self.contentView, 12);
    

   self.m_details.sd_layout
        .leftSpaceToView(self.m_userPhoto, 10)
        .rightSpaceToView(self.m_stateBtn, 15)
        .bottomSpaceToView(self.contentView, 12)
        .heightIs(20);
        
        [self setupAutoHeightWithBottomView:self.m_userPhoto bottomMargin:7.5];
        
    }
      return self;
}


-(void)setM_rolemodel:(RoleIntroduceInfo *)m_rolemodel
{
    _m_rolemodel = m_rolemodel;
    [_m_stateBtn setTitle:@"选择" forState:UIControlStateNormal];
    //角色头像
    [self.m_userPhoto sd_setImageWithURL:[NSURL URLWithString:m_rolemodel.m_avatar] placeholderImage:ImageNamed(@"角色列表头像")];
     [DTools getCorner:self.m_userPhoto radius:5];
    //角色名称
    self.m_UserNamelabel.text = m_rolemodel.m_rname;
    //角色说明
    self.m_details.text = m_rolemodel.m_rdesc;

    
    
}
-(void)clickStateRole:(UIButton * )Btn
{
    [Btn setTitle:@"" forState:UIControlStateNormal];
    
    [DTools buttonWaitForHUD:Btn HUD:YES];
 RoleChoiceViewController * role = (RoleChoiceViewController *)[DTools getViewController:self];
 NSDictionary * dic = [URLPath getNetRoleplayRoleNumberRoomid:[NSString stringWithFormat:@"%d",role.model.m_NewId] roleID:[NSString stringWithFormat:@"%d",self.m_rolemodel.m_id]];
    [self getNetRequestData:dic];
    
    
    
}



/**
 请求角色编号
 */
- (void)getNetRequestData:(NSDictionary *)info
{
    __weak RolePlayTableViewCell * role = self;
    [[AFHTTPClient share]getMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
       
        NSInteger rs = [[respostData objectForKey:K_rs]integerValue];
        
        if (rs ==1) {
          //记录编号
            role.m_rolemodel.m_roleNumber = [NSString stringWithFormat:@"%@",[respostData objectForKey:@"data"]];
           
            [DTools buttonCompleteHUD:self.m_stateBtn blockBtn:^(bool isDown) {
                
                if ([role.delegate respondsToSelector:@selector(RolePlayTableViewCellDelegateState:)]) {
                    [role.delegate RolePlayTableViewCellDelegateState:self.m_rolemodel];
                }
                
                [role.m_stateBtn setTitle:@"选择" forState:UIControlStateNormal];
            }];
            

            
        
        
        }else{
            
            
              [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
        }
        
        
    } failed:^(NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
