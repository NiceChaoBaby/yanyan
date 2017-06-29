//
//  ChatTipoffModel.h
//  chat
//
//  Created by dong on 16/4/14.
//  Copyright © 2016年 Dong. All rights reserved.
//
//聊天室举报  18
#import "DModel.h"

@interface ChatTipoffModel : DModel
/**
 *  举报记录ID
 */
@property(nonatomic,strong) NSString *m_tipoffId;
/**
 *  聊天室ID
 */
@property(nonatomic,strong) NSString *m_roomID;
/**
 *  聊天室名称
 */
@property(nonatomic,strong) NSString *m_easeId;
/**
 *  环信聊天室ID
 */
@property(nonatomic,strong) NSString *m_roomName;
/**
 *  被举报人ID
 */
@property(nonatomic,strong) NSString *m_memberUid;
/**
 * 被举报人昵称
 */
@property(nonatomic,strong) NSString *m_memberName;
/**
 *  举报人ID
 */
@property(nonatomic,strong) NSString *m_fromUid;
/**
 *  举报人昵称
 */
@property(nonatomic,strong) NSString *m_fromName;
/**
 *  举报类型(1群组、2聊天室)
 */
@property(nonatomic,strong) NSString *m_type;

/**
 *  透传时间
 */
@property(nonatomic,strong)NSString * m_addTime;
@end
