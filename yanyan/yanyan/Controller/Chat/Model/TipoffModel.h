//
//  TipoffModel.h
//  chat
//
//  Created by dong on 16/4/7.
//  Copyright © 2016年 Dong. All rights reserved.
//
//用户举报成员 11
#import "DModel.h"

@interface TipoffModel : DModel
/**
 *  举报记录ID
 */
@property(nonatomic,strong) NSString *m_Rid;
/**
 *  群组ID
 */
@property(nonatomic,strong) NSString *m_groupID;
/**
 *  群组名称
 */
@property(nonatomic,strong) NSString *m_groupName;
/**
 *  被举报人ID
 */
@property(nonatomic,strong) NSString *m_memberUid;
/**
 *  被举报人昵称
 */
@property(nonatomic,strong) NSString *m_memberName;
/**
 * 举报类型(1群组、2聊天室)
 */
@property(nonatomic,strong) NSString *m_type;
/**
 *  举报人ID
 */
@property(nonatomic,strong) NSString *m_fromUid;
/**
 *  举报人昵称
 */
@property(nonatomic,strong) NSString *m_fromNmae;
@end
