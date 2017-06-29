//
//  RoleDataViewController.m
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "RoleDataViewController.h"
#import "TopicChatRoomDataMembersCellTableViewCell.h"
#import "GroupMemberModel.h"
#import "RoleDataTableRoleNumberCell.h"
#import "GroupDetaileTableViewCell.h"
#import "RoleIntroduceTableViewCell.h"
#import "RoleIntroduceInfo.h"
#import "ShareView.h"
#import "ActorsAuditionViewController.h"
#import "AnswerModel.h"
#import "GroupMemberViewController.h"
#import "RoleChoiceViewController.h"
@interface RoleDataViewController ()<UITableViewDelegate,UITableViewDataSource,TopicChatRoomDataMembersCellTableViewCellDelegate>

/**
 成员数组
 */
@property(nonatomic,strong)NSMutableArray * m_MembersArray;


/**
 角色数组
 */
@property(nonatomic,strong)NSMutableArray * m_RoleNumberArray;

/**
 头视图
 */
@property(nonatomic,strong)UIImageView * m_tbImageView;

@property(nonatomic,strong)RoleIntroduceModel * m_model;
@end

@implementation RoleDataViewController

-(NSMutableArray *)m_dataBlockArr
{
    if (!_m_dataBlockArr) {
        _m_dataBlockArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _m_dataBlockArr;
}

-(NSMutableArray *)m_MembersArray
{
  if (!_m_MembersArray) {
        
        _m_MembersArray = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return _m_MembersArray;
}

-(NSMutableArray *)m_RoleNumberArray
{
   if (!_m_RoleNumberArray) {
       
        _m_RoleNumberArray = [[NSMutableArray alloc]initWithCapacity:0];
       
    }
    
    return _m_RoleNumberArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
      [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//     self.m_tableview.contentInset = UIEdgeInsetsMake([self.view getRealWidth:210], 0, 0, 0);
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,-[self.view getRealWidth:210], [UIScreen mainScreen].bounds.size.width, [self.view getRealWidth:210])];//64导航栏高度
//    
//    imageView.backgroundColor = RGBBgColor;
////    [imageView sd_setImageWithURL:[NSURL URLWithString:self.m_model.m_img]];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.clipsToBounds = YES;
//    
//    imageView.tag = 101;
//    
//    [self.m_tableview addSubview:imageView];
    [self addHeadView];//添加头视图
    
    self.m_tableview.showsVerticalScrollIndicator = NO;
    [self.m_goRoomBtn setImage:ImageNamed(@"chatroom_btn") forState:UIControlStateNormal];
    [self.m_goRoomBtn setTitle:@"进入聊天室" forState:UIControlStateNormal];
    self.m_goRoomBtn.backgroundColor = RGBBgNavColor;
    self.m_tableview.backgroundColor = RGBBgColor;
  NSDictionary * dic = [URLPath getNetRolePlayRoomData:self.m_roomId];
    
    [self getNetRequestData:dic];
    
   //self.m_model = [[RoleIntroduceModel alloc]init];
  // self.m_model.m_inrroduce = @"暗示法可适当发哈康师傅和可接受的房间卡上副科级按时开发商看缴费哈萨克剪短发上课脚发会计师话费卡就是发会计师话费卡就是副科级按时副科级按时副科级阿浩丰科技和看风景奥斯卡级发货快就会发看三角阀看手机话费卡十九大放空是金发科技司法考试就话费卡是分开吉安市覅乌尔求不具备这剧本u不错啊而月白求恩还不发货布局北京北京不会富文本副本不好吧SVN白细胞从v吧";
   
    // Do any additional setup after loading the view.
}

- (void)getNetRequestData:(NSDictionary *)info
{
    
    __weak RoleDataViewController * role = self;
    //这里等于这个属性 在退出此页面 如果网络请求没有请求完  则可以利用这个属性去停止请求 减轻卡顿
    [[AFHTTPClient share]getMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
        NSInteger rs = [[respostData objectForKey:K_rs]integerValue];
        
        if (rs ==1)
        {
            
            NSDictionary * dic = [respostData objectForKey:K_data];
            role.m_model = [RoleIntroduceModel mj_objectWithKeyValues:[dic objectForKey:@"info"]];
            //转换到期时间
            if ([ role.m_model.m_remain intValue] > 0) {
                 role.m_model.m_remain = [DTools ConversionTime: role.m_model.m_remain];
            }
                [self.m_tbImageView sd_setImageWithURL:[NSURL URLWithString:self.m_model.m_img]];//添加头视图
            [role.m_MembersArray removeAllObjects];
            [role.m_MembersArray addObjectsFromArray:[GroupMemberModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"members"]]];
            [role.m_RoleNumberArray removeAllObjects];
            [role.m_RoleNumberArray addObjectsFromArray:[RoleIntroduceInfo mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"roles"]]];
            
            
            [role.m_tableview reloadData];
            
                   if ([[dic objectForKey:@"cstatus"]integerValue] == -2 ) {//聊天室删除了详情 提示用户
                
                [DTools alertController:role title:nil message:@"聊天室已结束" handler:^(UIAlertAction *action) {
                   [role.navigationController popViewControllerAnimated:YES];
                }];
                
            }

            
            
            
        }else{
            
               [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
            
        }
        
    } failed:^(NSString *errorMsg) {
        
        
        [SVProgressHUD showErrorWithStatus:K_ErrorLog];
        
    }];
    
}

//添加头视图
-(void)addHeadView
{
    self.m_roomName.text = self.m_model.m_title;//抬头名称
    
    
    self.m_tableview.contentInset = UIEdgeInsetsMake([self.view getRealWidth:210], 0, 0, 0);
    self.m_tbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,-[self.view getRealWidth:210], [UIScreen mainScreen].bounds.size.width, [self.view getRealWidth:210])];//64导航栏高度
    
    //    [self.m_tbImageView sd_setImageWithURL:[NSURL URLWithString:self.m_model.m_img]];
    self.m_tbImageView.backgroundColor = RGBBgColor;
    self.m_tbImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.m_tbImageView.clipsToBounds = YES;
    
    self.m_tbImageView.tag = 101;
    
    [self.m_tableview addSubview:self.m_tbImageView];
}
/**
 进入聊天室按钮
 */
- (IBAction)clickGoChatRoom:(id)sender
{
    //6.26 xiong
//    if (self.m_isChatRoomPush) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//    
//      if ([self isLoginPush:YES pushLodingViewL:self]) {
//    if ([self.m_model.m_remain intValue] > 0) {
//        
//        //聊天中
//        int time = [DTools compareDate:[self tellMeTimeTwo] withDate:[DTools ConversionTime:self.m_model.m_remain]];
//        
//        if (time > 0) {
////
////                
//    AnswerModel * ansModel =[ShareAppDelegate.m_ActorsAuditio objectForKey:self.m_model.m_easeId];
//   
//    if(ansModel && [ansModel.m_question isEqualToString:self.m_model.m_question] && self.m_model.m_ansRight == ansModel.m_pos && ansModel.m_rolemodel)
//     {//判断是否答过这个题目 用房间ID作为Key取出选择的Model 然后判断是否为空  2.判断问答题目是否一样 3.判断正确的选项pos 和用户选择的pos 是否一致 如果一致  则直接进入聊天室  不一致则进入答案选项  角色信息model必须要有
//        
//         UIViewController *controller=[ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY];
//         //判断当前是否有聊天室
//         if (controller)
//         {
//             
//             //判断是否是同一个聊天室
//             if ( [ShareAppDelegate.m_roomId isEqualToString:self.m_model.m_easeId]) {
//                 //直接跳转当前聊天页面
//                 
//                 ChatViewController *topChat=[ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY];
//                 [self.navigationController pushViewController:topChat animated:NO];
//                 
//             }else{
//                 
//                 NSString * str = [NSString  stringWithFormat:@"您是否要退出『%@』并进入『%@』？", [self readRoomName],self.m_model.m_title];
//                 UIAlertController  * alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
//                 UIAlertAction  * action = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil];
//                 UIAlertAction  * action1 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                     
//                     
//                    //跳转聊天室
//                     [self pushChatRoom];
//                 }];
//                 
//                 [alert addAction:action];
//                 [alert addAction:action1];
//                 [self presentViewController:alert animated:YES completion:nil];
//             }
//             
//         }else{
//             
//             //跳转聊天室
//             [self pushChatRoom];
//         }
//     }else{
//         
//         UIViewController *controller=[ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY];
//         //判断当前是否有聊天室
//         if (controller)
//         {
//             
//             NSString * str = [NSString  stringWithFormat:@"您是否要退出『%@』并进入『%@』？", [self readRoomName],self.m_model.m_title];
//             UIAlertController  * alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
//             UIAlertAction  * action = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil];
//             UIAlertAction  * action1 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                 
//                 
//                 if ([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
//                 {
//                     
//                     [DTools DeleteCurrentPage];
//                     
//                 }
//                 
//                 //这里跳转问答，要判断是直接选择角色还是 跳转问答里面选择的是错误答案
//                 [self judgeRole:self.m_model];
//
//             }];
//             
//             [alert addAction:action];
//             [alert addAction:action1];
//             [self presentViewController:alert animated:YES completion:nil];
//
//         
//        
//         }else{
//             
//             //这里跳转问答，要判断是直接选择角色还是 跳转问答里面选择的是错误答案
//             [self judgeRole:self.m_model];
//
//             
//         }
//     }
////            //这里进入聊天室  还要判断当前是否有聊天室 聊天室是否是同一个
////            UIStoryboard * story = [UIStoryboard storyboardWithName:@"ChatSquare" bundle:nil];
////            
////            ActorsAuditionViewController  * actors = [story instantiateViewControllerWithIdentifier:@"ActorsAuditionViewController"];
////            
////            [self.navigationController pushViewController:actors animated:YES];
////            
//        }else{ //当对比时间小于0时代表着超时了
//            [self roomDownOver];
//        }
//
//    }else{//当直接判断model的持续时间为负数时也是超时了
//        
//         [self roomDownOver];
//    
//    }
//
//      }
//        
//    }
}

/**
 跳转聊天室
 */
-(void)pushChatRoom
{
    
    if ([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
    {
        
        [DTools DeleteCurrentPage];
        
    }
    ChatViewController *RoleChat=[[ChatViewController alloc] init];

   //6.26 xiong
//    RoleChat.m_fromStatListandData = YES;
//    RoleChat.m_chatRoomType = ChatRoomTypeRolePlay;
    RoleChat.m_RoleDataID = self.m_roomId;//请求聊天室详情要用到
    ShareAppDelegate.m_roomId = self.m_model.m_easeId;
    RoleChat.m_titleTopic= self.m_model.m_title;
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setObject:self.m_model.m_img forKey:k_roomPoto];
    //                topChat.m_topicChatModel =model;
    [ShareAppDelegate.m_chatRoomDict setObject:RoleChat forKey:K_CHAT_ROOM_KEY];
    [ShareAppDelegate.m_chatRoomDict setObject:[NSNumber numberWithBool:YES] forKey:K_TOPIC_BOOL];
    [self.navigationController pushViewController:RoleChat animated:NO];

    
}
/**
 跳转问答
 */
-(void)pushActorsaudition:( RoleIntroduceModel *)model
{
    //跳转问答
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"ChatSquare" bundle:nil];
    
    ActorsAuditionViewController * m_actorsaudition = [story instantiateViewControllerWithIdentifier:@"ActorsAuditionViewController"];
    
    m_actorsaudition.m_model =[[ActorsAuditionModel alloc]init];
    
    m_actorsaudition.m_model.m_question = model.m_question;
    [m_actorsaudition.m_model.m_answersArray addObjectsFromArray:model.m_answersArray];
    m_actorsaudition.m_model.m_ansRight = model.m_ansRight;
    m_actorsaudition.m_model.m_EaseRoom = model.m_easeId;
    m_actorsaudition.m_model.m_headImageUrl = model.m_imgQuestion;
    m_actorsaudition.m_model.m_roomID = [self.m_roomId intValue];
    NSDictionary * dic = [model mj_keyValues];
    m_actorsaudition.model = [NewsPlazaModel mj_objectWithKeyValues:dic];
    m_actorsaudition.m_fromStatListandData = YES;//详情页跳转
    //                m_actorsaudition.model = model;//聊天室剩余时间
    
    [self.navigationController pushViewController:m_actorsaudition animated:YES];
    
    
    
    
}
/**
 跳转角色选择
 */
-(void)pushRoleChoice:(RoleIntroduceModel *)model
{
    RoleChoiceViewController * rolechoice = [[RoleChoiceViewController alloc]init];
    rolechoice.m_fromStatListandData = NO;//吧从哪里跳转的BOOL传给下个界面 列表点过来的 就是NO  详情的就是YES
    rolechoice.m_roomID =[self.m_roomId intValue];
    
    rolechoice.m_easeId = model.m_easeId;
    
    NSDictionary * dic = [model mj_keyValues];
    rolechoice.model  = [NewsPlazaModel mj_objectWithKeyValues:dic];
     rolechoice.m_fromStatListandData = YES;//详情页跳转
    [self.navigationController pushViewController:rolechoice animated:YES];
}

/**
 判断该跳转哪里
 */
-(void)judgeRole:(RoleIntroduceModel*)model
{
    AnswerModel * answModel =[ShareAppDelegate.m_ActorsAuditio objectForKey:model.m_easeId];
    if (answModel && [answModel.m_question isEqualToString:model.m_question] ) {
        
        if (answModel.m_pos == model.m_ansRight) {//用户当初选择的是否 是对的
            
            
            [self  pushRoleChoice:model];//对的直接跳转选择角色
            
        }else{
            
            //不对跳转问答
            [self pushActorsaudition:model];
            
        }
    }else{
        //不存在用户选择的答案 跳转问答
        [self pushActorsaudition:model];
        
    }
    
    
}


-(void)roomDownOver
{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"聊天室『%@』已经结束",self.m_model.m_title] preferredStyle:UIAlertControllerStyleAlert];
    //上面控制提示框的内容和标题
    //下面控制提示框的按钮动作
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    //将内容标题加上动作 cancel
    [alert addAction:cancel];
    //然后在视图上显示提示框
    [self presentViewController:alert animated:YES completion:nil];
    

}
#pragma  mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -210) {
        CGRect rect = [self.m_tableview viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.m_tableview viewWithTag:101].frame = rect;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }
    return 1;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section ==2) {
//          return 10;
//    }
//    return 0;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    if (section ==2) {
//        
//      UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LCDW, 10)];
//      view.backgroundColor =RGBBgColor;
//    
//    return view;
//        
//    }
//    
//    return nil;
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    //去掉底部多余的表格线
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    if (indexPath.section == 0) {//介绍
       
            static NSString * cellID = @"RoleIntroduceTableViewCell";
            RoleIntroduceTableViewCell * cell  = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
            {
                
            cell = [[RoleIntroduceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//隐藏点击效果
            cell.m_model = self.m_model;
            return cell;
        
    }else if(indexPath.section == 1){//角色
       
        //加载Xib
        static NSString * identifer1 = @"RoleDataTableRoleNumberCell";
        UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifer1];
         RoleDataTableRoleNumberCell * cell = ( RoleDataTableRoleNumberCell*)[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
         [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //隐藏点击效果
        if (self.m_RoleNumberArray.count !=0) {
           
            [cell addData:self.m_RoleNumberArray];
            
        }
    [cell.m_collectionView reloadData];
        return cell;
        
    }else if (indexPath.section == 2) {//成员和 分享
     
        if (indexPath.row == 0) {//成员
            //加载Xib
            static NSString * identifer1 = @"TopicChatRoomDataMembersCellTableViewCell";
            UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
            
            [tableView registerNib:nib forCellReuseIdentifier:identifer1];
            
            TopicChatRoomDataMembersCellTableViewCell * cell = ( TopicChatRoomDataMembersCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
            cell.m_collectionView.userInteractionEnabled = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//隐藏点击效果
            if (self.m_MembersArray.count !=0) {
             
                [cell.m_userDataArray removeAllObjects];
                [cell.m_userDataArray addObjectsFromArray:self.m_MembersArray];
                
            }
           
            cell.m_numberPeople.text = [NSString stringWithFormat:@"%ld",self.m_MembersArray.count];
            cell.delegate = self;
               cell.m_titleLabel.text = @"成员";
            if ([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY] && [ShareAppDelegate.m_roomId isEqualToString:self.m_model.m_easeId])
            {//这里还要加入判断  EASEID是否是同一个聊天室
              
                cell.m_btn.hidden = NO;
                cell.m_btnW.constant = 32;
            }else{
                
                cell.m_btn.hidden = YES;
             cell.m_btnW.constant = 0;
            }
            
//            if (self.m_isState ==ChatIn || self.m_isChatRoomPush) {
//
                
//            }else{
//                cell.m_btn.hidden = YES;
//                cell.m_titleLabel.text = @"已感兴趣";
//                
//            }
            [cell.m_collectionView reloadData];
            return cell;

    }else{//分享
            
            //加载Xib
            static NSString * identifer1 = @"GroupDetaileTableViewCell";
            UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
            
            [tableView registerNib:nib forCellReuseIdentifier:identifer1];
            
            GroupDetaileTableViewCell * cell = ( GroupDetaileTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
             [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //隐藏点击效果
            cell.m_NameLabel.text = @"分享";
            cell.m_NameLabel.textColor = RGBAssistColor;
            cell.m_NameLabel.font = [UIFont systemFamilyFontOfSizeNoScale:16.f];
            return cell;
        }
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return [self.m_tableview cellHeightForIndexPath:indexPath model:self.m_model keyPath:@"m_model" cellClass:[RoleIntroduceTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
    }else if(indexPath.section == 1){
        return 170;
        
    }else{
        
        if (indexPath.row == 0) {
            return 75;
        }
        return 65;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {//分享
        
        if (indexPath.row == 0) {
            if ( self.m_isChatRoomPush ||([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY] && [ShareAppDelegate.m_roomId isEqualToString:self.m_model.m_easeId])) {
                
                //查看话题聊天室成员
                GroupMemberViewController * member = [[GroupMemberViewController alloc] init];
//                member.m_isTopicChatRoom = YES;
                member.m_chatRoomType = ChatRoomTypeRolePlay;//角色扮演
                member.m_form = [NSString stringWithFormat:@"角色扮演『%@』", self.m_model.m_title];
                [member.m_dataArr addObjectsFromArray:self.m_MembersArray];
//                member.m_ownerId=self.m_model.m_uid;
                //判断如果是聊天页面跳转过来了的  肯定带有BlickList数组 将数组传入 成员管理页面
                if (self.m_isChatRoomPush) {
                    [member.m_dataBlockArr addObjectsFromArray:self.m_dataBlockArr];
                }
                [self.navigationController pushViewController:member animated:YES];
            }
  
            
            
        }else if ( indexPath.row == 1){//分享
            
            
//        [ShareView shareInstance].m_VC = self;
//        [ShareView shareInstance].m_groupInfoModel = self.m_groupInfoModel;
        /**
         聊天室 群组分享
        */
            //6.26 xiong
//            NewsModel  * model = [[NewsModel alloc]init];
//            model.m_img =  self.m_model.m_img;
//            model.m_title =  self.m_model.m_title;
//            
//
//     
//        model.m_shareUrl =[NSString stringWithFormat:@"http://chat.leiyu.tv/index.php?ac=share&op=role&id=%@",self.m_roomId];//这里暂时没有给网址我先自己写个网址
//             model.m_title =[NSString stringWithFormat:@"我在[%@]聊天室当主演，快来和我演对手戏啊。剧组帅哥、美女、盒饭管够！",self.m_model.m_title];//主标题
//       model.m_summary =@"我发现个很有趣的聊天app——言言，这里有话题与新闻聊天室，快来一起聊!";//副标题
//
//      
//            if (![DTools isStringEmpty:model.m_img]) {
//                
//               RoleIntroduceInfo * rolmodel = self.m_RoleNumberArray[0];//分享如果没选角色 就选取角色列表的第一个角色头像
//                NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:rolmodel.m_avatar]];
//                [[ShareView shareInstance]ShareViewWindowModel:model image:[self scaleToSize:CGSizeMake(80, 80) image:[[UIImage alloc]initWithData:data]] isGroupShar:NO];
//                
//                
//            }else{
//                
//                [[ShareView shareInstance]ShareViewWindowModel:model image:ImageNamed(@"share_bot") isGroupShar:NO];
//            }
//       
        }
    }
}

#pragma mark - TopicChatRoomDataMembersCellTableViewCellDelegate
-(void)TopicChatRoomDataMembersCellTableViewCellDelegateTouchUserPhotoS:(NSString *)uid
{
//    if (self.m_isState == ChatIn || self.m_isChatRoomPush) {
//        
//        //查看话题聊天室成员
//        GroupMemberViewController * member = [[GroupMemberViewController alloc] init];
//        member.m_isTopicChatRoom = YES;
//        member.m_ownerId=self.m_model.m_uid;
//        [member.m_dataArr addObjectsFromArray:self.m_model.m_membersArray];
//        //判断如果是聊天页面跳转过来了的  肯定带有BlickList数组 将数组传入 成员管理页面
//        if (self.m_isChatRoomPush) {
//            [member.m_dataBlockArr addObjectsFromArray:self.m_blickList];
//        }
//        [self.navigationController pushViewController:member animated:YES];
//    }
//
    
}
- (IBAction)clcikgoBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
