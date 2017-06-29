//
//  NewsModel.h
//  chat
//
//  Created by 高超 on 16/5/6.
//  Copyright © 2016年 Dong. All rights reserved.
//
// 新闻Model
#import <Foundation/Foundation.h>

@interface NewsModel : DModel



/**
 用户头像
 */
@property(nonatomic,strong)NSString * m_avatar;

/**
 *  自己组织的时候  用到的新闻标题
 */
@property(nonatomic,strong)NSString * m_content;

/**
 分享Url
 */
@property(nonatomic,strong)NSString * m_contentUrl;


/**
 判断新闻聊天是否开通了  环信聊天室id
 */
@property(nonatomic,strong)NSString * m_easeId;

/**
  新闻iD
 */
@property(nonatomic,assign)int  m_id;

/**
 *  新闻图片
 */
@property(nonatomic,strong)NSString * m_img;

/**
 *  新闻图片高
 */
@property(nonatomic,strong)NSString * m_imgHeight;

/**
 *  新闻图片宽
 */
@property(nonatomic,strong)NSString * m_imgWith;

/**
 *  新闻类型  1 是自己组织类型  2 WebView
 */
@property(nonatomic,strong)NSString * m_newsType;

/**
 新闻类型  1原先类型  2图片类型  3嗅事百科
 */
@property(nonatomic,assign)NSInteger m_secType;
/**
  名字？
 */
@property(nonatomic,strong)NSString * m_nickName;


@property(nonatomic,strong)NSString * m_notes;
/**
 *  来源于什么
 */
@property(nonatomic,strong)NSString * m_source;
/**
 *  新闻标题
 */
@property(nonatomic,strong)NSString * m_title;


/**
 感兴趣的人 字符串
 */
@property(nonatomic,strong)NSString * uidIntrest;
/**
 *  点开显示的新闻网址
 */
@property(nonatomic,strong)NSString * m_link;
/**
 *  新闻持续时间  时间到了就重新请求
 */
@property(nonatomic,strong)NSString * m_remainTime;

/**
 到期时间
 */
@property(nonatomic,strong)NSString * m_remain;
/**
 *  新闻副标题
 */
@property(nonatomic,strong)NSString * m_summary;




/**
 *  新闻时间
 */
@property(nonatomic,strong)NSString * m_dtpub;
/**
 *  分享URL 这里不做数据解析  只做请求回来自己拼接URL 自己记录用
 */
@property(nonatomic,strong)NSString * m_shareUrl;

/**
 *  新闻状态
 */
@property(nonatomic,assign)ChatSquareType m_isState;
@end
