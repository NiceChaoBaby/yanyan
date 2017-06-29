//
//  ActorsAuditionModel.h
//  chat
//
//  Created by 高超 on 2017/5/16.
//  Copyright © 2017年 Dong. All rights reserved.
//
//演员试镜Model
#import <Foundation/Foundation.h>

@interface ActorsAuditionModel : NSObject

//问题
@property(nonatomic,strong)NSString * m_question;


/**
 选项数组
 */
@property(nonatomic,strong)NSMutableArray * m_answersArray;



//正确选项
@property(nonatomic,assign)int m_ansRight;

/**
 环信房间ID
 */
@property(nonatomic,strong)NSString * m_EaseRoom;

/**
 这个是我们聊天室自己的ID
 */
@property(nonatomic,assign)int  m_roomID;
/**
 头视图的图片  有则有 无则无
 */
@property(nonatomic,strong)NSString * m_headImageUrl;


//选项数组
//@property(nonatomic,strong)NSMutableArray * m_arrayState;


@end
