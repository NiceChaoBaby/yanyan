 //
//  LookUserViewController.m
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "LookUserViewController.h"
#import "UserPlaceTableViewCell.h"
#import "messageTableViewCell.h"
#import "FriendAloneChatViewController.h"
#import "FriendListModel.h"
#import "FriendInformationModel.h"
#import "BlickListModel.h"
#import "SYPhotoBrowser.h"
@interface LookUserViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
        CGFloat signH;
    CGFloat intrestH;
    CGFloat fromH;//来源高
    BOOL m_deleFriendPush;
    NSMutableArray * m_blockListArray;
    BOOL m_source;//是否需要来源
    
}
@property (weak, nonatomic) IBOutlet UIButton *m_conversationBtn;//对话Btn
@property (weak, nonatomic) IBOutlet UIButton *m_attentionBtn;//加好友Btn
@property (weak, nonatomic) IBOutlet UIImageView *m_backgroundImage;//背景图
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
@property (nonatomic,strong) FriendInformationModel *m_userInfoModel;
@property(nonatomic,strong) NSMutableArray *m_titleDataArr;
@property (weak, nonatomic) IBOutlet UIImageView *m_navBacground;//导航栏背景
@property(nonatomic,strong) NSDictionary *m_dataDic;
@property (weak, nonatomic) IBOutlet UILabel *m_userNameLabel;//用户名称
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_lowH;//低端高度
@property (weak, nonatomic) IBOutlet UIView *m_optionsView;//按钮的底视图View
@property (weak, nonatomic) IBOutlet UIImageView *m_titleBG;
@property (weak, nonatomic) IBOutlet UIButton *m_rightNavBtn;
/**
 *  判断网络请求是否成功默认NO
 */
@property (nonatomic,assign) BOOL m_isNetSuccessA;
@end

@implementation LookUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.m_optionsView.hidden = YES;//进来先隐藏选项按钮  等数据请求完毕后再显示
    signH = 65;
    [self.m_conversationBtn setBtnBackgroundIamgeColor:RGBBgNavColor state:UIControlStateNormal radius:0];
    [self.m_attentionBtn setBtnBackgroundIamgeColor:RGBBgNavColor state:UIControlStateNormal radius:0];
    self.m_titleDataArr = [NSMutableArray arrayWithCapacity:0];
    //这里生活足迹暂时不开放 @"生活足迹",
    [self.m_titleDataArr addObject:[NSArray arrayWithObjects:@"言言ID",@"等级",@"性别",@"生日",@"年龄",@"个人签名", nil]];
    [self.m_titleDataArr addObject:[NSArray arrayWithObjects:@"情感状况",@"兴趣",@"故乡",@"来源",nil]];
    // Do any additional setup after loading the view.
    //去掉底部多余的表格线
    [self.m_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //获取群组黑名单
    if([self.m_uid integerValue] != [[self giveMeUid] integerValue]){
    [self AccessBlacklist];
    }
    [self getNetUserDtat:self.m_uid];
    
    if (_m_from == nil) {
       
        [self ComparedToFriends];
    }
   
    //查询黑名单方法
    m_blockListArray = [[NSMutableArray alloc]initWithCapacity:0];
    
       self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
  }
-(void)ComparedToFriends
{
    NSMutableArray *arr=[FriendListModel mj_objectArrayWithKeyValuesArray:[self myFriendListLocalRead]];
    for (int i = 0 ; i < arr.count; i ++) {
        FriendListModel *model  = arr[i];
        
        if ([model.m_fuid intValue]==[[self giveMeUid]integerValue])
        {
            self.m_from = model.m_source;
            break;
        }

    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)AccessBlacklist
{
    NSDictionary * dic = [URLPath getNetBlackListRequest];
    [[AFHTTPClient share]postMethod:[dic objectForKey:K_URL] param:[dic objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
        NSInteger rs = [[respostData safeObjectForKey:K_rs]integerValue];
        if (rs == 1) {
            NSMutableArray * array = [BlickListModel mj_objectArrayWithKeyValuesArray:[respostData objectForKey:K_data]];
            [m_blockListArray addObjectsFromArray:array];
             [DTools storageUserBlackList:m_blockListArray];//储存黑名单
            //如果存在黑名单 则不显示
            if ([self CompareTheBlacklist]) {
                self.m_lowH.constant = 0;
                self.m_optionsView.hidden = YES;
            }

        }
        
        
        
        
    } failed:^(NSString *errorMsg) {
        
    }];

    
    
}
-(BOOL)CompareTheBlacklist
{
    if (m_blockListArray.count !=0) {
        for (BlickListModel * model in m_blockListArray) {
        if ( [self.m_uid integerValue]  == [model.m_id integerValue]) {
            
            return YES;
            break;
            
        }
    }
    }
    
    
    
    return NO;
    
}

/**
 *  头视图方法
 */
-(void)upLayout
{

    UIView *  m_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LCDW, 205)];
    m_view.backgroundColor = [UIColor clearColor];
    
    UIImageView * m_image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    m_image.backgroundColor = [UIColor clearColor];
    m_image.center = m_view.center;
    [DTools setImageView:m_image];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(LookBigUserPhoto)];
    [m_image addGestureRecognizer:tap];
    [m_image sd_setImageWithURL:[NSURL URLWithString:self.m_userInfoModel.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage)];
    [m_view addSubview:m_image];
   

    //设置背景图
    if (self.m_userInfoModel.m_bgimage.length == 0) {
        
        self.m_backgroundImage.image = ImageNamed(k_begImage);
        
    }else{
        
        [self.m_backgroundImage sd_setImageWithURL:[NSURL URLWithString:self.m_userInfoModel.m_bgimage] placeholderImage:ImageNamed(k_begImage)];
    }
    
    self.m_tableView.tableHeaderView = m_view;
}

-(void)LookBigUserPhoto
{
    NSMutableArray * arr = [[NSMutableArray alloc]initWithCapacity:0];
    [arr addObject:self.m_userInfoModel.m_avatarBig];
    SYPhotoBrowser *photoBrowser = [[SYPhotoBrowser alloc] initWithImageSourceArray:arr caption:@"" delegate:self];
    
    photoBrowser.initialPageIndex = 0;
    photoBrowser.pageControlStyle = SYPhotoBrowserPageControlStyleLabel;
    [self presentViewController:photoBrowser animated:YES completion:nil];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource,UITableViewDelegate

/**
 *   滚动视图代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
 
//    NSInteger taer;
//    if (LCDH <= 460) {
//        taer = 300 +(signH + intrestH -65);
//    }else{
//        taer = 250 +(signH + intrestH - 65);
//    }
//    
//    
//    if (scrollView.contentOffset.y < -(LCDW -215)) {
//        
//        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -(LCDW -215));
//
//    }else if (scrollView.contentOffset.y > taer){
//        
//      scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x,taer);
//
//    }
//
    CGPoint contentOffsetPoint = self.m_tableView.contentOffset;
    CGRect frame = self.m_tableView.frame;
    
    if ( (contentOffsetPoint.y) > (self.m_tableView.contentSize.height - frame.size.height) +100)
    {
        
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, (self.m_tableView.contentSize.height - frame.size.height)+100);
        DLog(@"在");
    }else{
        
        if (scrollView.contentOffset.y < -(LCDW - 215)) {
            //
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -(LCDW - 215));
            //
            //           //往上拉最大值
        }
    }
    
    self.m_navBacground.alpha = 0.01f * scrollView.contentOffset.y;
    
    if (self.m_navBacground.alpha >= 0.01) {
        self.m_titleBG.hidden = YES;
    }else{
        self.m_titleBG.hidden = NO;
    }

//    //判断移动距离 设置 状态栏字体颜色
//    if (scrollView.contentOffset.y > 0 ) {
//        //改变状态栏颜色
//        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//    }else{
//        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//        
//    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.m_isNetSuccessA)
    {
        return 0;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.m_isNetSuccessA)
    {
        return 0;
    }
    if (section==0) {
        return 6;
    }else if(section == 1)
    {
        FriendListModel * model = [DTools CompareIsFriendModelEaseId:self.m_userInfoModel.m_easeUname];
        if (model && ![DTools isStringEmpty: model.m_source]) {//有model是好友显示来源
             return 4;
        }else{
            return 3;
        }
       
    }else{
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.m_isNetSuccessA)
    {
        return 0;
    }
    if (indexPath.section==0 && indexPath.row==5)
    {//个人签名
                   return signH;
    }else if (indexPath.section == 1 && indexPath.row == 1)
    {//个人兴趣
       
            return intrestH;
    }else if ( indexPath.section == 1 && indexPath.row == 3){
    
         FriendListModel * model = [DTools CompareIsFriendModelEaseId:self.m_userInfoModel.m_easeUname];
       
        if(!model && [DTools isStringEmpty: model.m_source] ){
            
            return 0;
        }else{
            
            if([self compareUser: self.m_userInfoModel]){
                NSInteger H =  [self CalculateText:model.m_source];
                if (H < 65) {
                    H = 65;
                }
            return H;
                
            }else{
                return 0;
            }
        }
        
    }else{
       
        return 65;
    }

}

//区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if(section == 2){
        return 1;
    }
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
//    //分割线样式
//    tableView.separatorStyle = UITableViewScrollPositionNone ;
    
    
    
    if (indexPath.section==0)
    {
//        if(indexPath.row==0)
//        {
//            return [UserPlaceTableViewCell createTableView:tableView cellForRowAtIndexPath:indexPath titleDataArr:self.m_titleDataArr];
//        }else
//        {
        
    return [messageTableViewCell createTableView:tableView cellForRowAtIndexPath:indexPath titleDataArr:self.m_titleDataArr FriendInformationModel:self.m_userInfoModel];
        
//        }
    }
    else
    {
        if (indexPath.row == 3) {
            
            static NSString * identifer1 = @"messageTableViewCell";
            UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:identifer1];
            messageTableViewCell * cell = (messageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *arr=[self.m_titleDataArr safeObjectAtIndex:indexPath.section];
            cell.m_titleLab.text = arr[indexPath.row];
            cell.m_titleLab.numberOfLines =1;
            cell.m_titleLab.lineBreakMode = NSLineBreakByTruncatingTail;
        //对比好友列表如果有则返回model  否则返回空
            FriendListModel * model = [DTools CompareIsFriendModelEaseId:self.m_userInfoModel.m_easeUname];
             if (model && ![DTools isStringEmpty: model.m_source]) {//有model是好友显示来源
                //如果是好友 则把好友列表来源写上
                cell.m_contentLab.text = model.m_source;
            }
            return cell;
            
        }else{
            
            messageTableViewCell * cell = [messageTableViewCell createTableView:tableView cellForRowAtIndexPath:indexPath titleDataArr:self.m_titleDataArr FriendInformationModel:self.m_userInfoModel];

        return   cell;
            
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0&&indexPath.row==0)
//    {
//        FriendFootPrintViewController *friendFoot=[[FriendFootPrintViewController alloc] init];
//        friendFoot.m_uid=self.m_userInfoModel.m_id;
//        [self.navigationController pushViewController:friendFoot animated:YES];
//    }
   
}

#pragma mark - 按钮方法
//对话方法
- (IBAction)clickConversation:(UIButton *)sender
{
    
//     UserOperation * userModel = [self DetermineTheUserLevelOperation:[self myGroupListLocalRead] type:directMessages];
  BOOL a =  [self promptMessageOperationType:directMessages];
    if (a) {

    if (!self.m_isNetSuccessA)
    {
        return;
    }
        
     //        NSArray* array =self.navigationController.viewControllers;
            
            //    因为是堆栈的原理，此时的array里放了两个元素分别为 @[A , B];
            //    所以我们就可以直接判断
            //    [array[0] isKindOfClass:[WelcomeViewController class]];
         //6.26 xiong
//            NSArray *controllerArr=self.navigationController.viewControllers;
//            for (UIViewController *myController in controllerArr)
//            {
        
//                if ([myController isKindOfClass:[EaseMessageViewController class]] )
//                {
//                    
//                    EaseMessageViewController *con=(EaseMessageViewController*)myController;
//                     FriendListModel *m_friendListModel= [self updateData];
//                    //是单聊界面
//                    if ( con.conversation.type==EMConversationTypeChat)
//                    {
//                         FriendAloneChatViewController *alone=(FriendAloneChatViewController*)con;
//                       
//                        //是同一个人不
//                        if([alone.conversation.conversationId isEqualToString:m_friendListModel.m_easeUname])
//                        {
//                            [self.navigationController popToViewController: alone animated:YES];
//                             return;
//                        }else
//                        {
//                            [self pushAlone:m_friendListModel];
//                             return;
//                        }
//                        
//                    }else
//                    {
//
//                       [self pushAlone:m_friendListModel];
//                        return;
//                    }
               // }
//            }
     
    FriendAloneChatViewController *aloneChat=[[FriendAloneChatViewController alloc] init];
    aloneChat.m_friendListModel= [self updateData];
    [self.navigationController pushViewController:aloneChat animated:YES];
    }
    
}
-(void)pushAlone:(FriendListModel *)m_friendListModel
{
    //这里需要重新设置别名么？
    //6.26 xiong
//    UIStoryboard *storyboardMessage = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
//    MessageViewController   *controller= [storyboardMessage instantiateViewControllerWithIdentifier:@"MessageViewController"];
//    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:controller];
//    
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
//    ShareAppDelegate.menuController = [storyboard instantiateViewControllerWithIdentifier:@"menuController"];
//    // Create frosted view controller
//    //
//    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:ShareAppDelegate.menuController];
//    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
//    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
//    frostedViewController.liveBlur = YES;
//    //        frostedViewController.delegate = self;
//    
//    
//    ShareAppDelegate.window.rootViewController = frostedViewController;
//    ;
//    
//    
//    //                        [[NSNotificationCenter defaultCenter]postNotificationName:k_pushAlone object:m_friendListModel];
//    [self writefriendAlone:m_friendListModel];
}
-(FriendListModel *)updateData
{
    FriendListModel *friend=[[FriendListModel alloc] init];
   friend= [FriendListModel mj_objectWithKeyValues:self.m_dataDic];
    friend.m_fuid=[self.m_dataDic objectForKey:K_id];
    return friend;
}
- (IBAction)clickMoreButton:(UIButton *)sender
{
    [self addUIAlert];
}
//加好友方法
- (IBAction)clickAttention:(UIButton *)sender
{
    
    if (!self.m_isNetSuccessA)
    {
        return;
    }
    
    if (sender.selected)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您是否确定要删除好友“%@“",self.m_userInfoModel.m_nickname] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               [self getNetDeleteFriendfuid:self.m_uid];//删除好友
        }];
        
        [alert addAction:action];
        [alert addAction:action1];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else
    {
        //加好友等级判断
//        UserOperation * userModel = [self DetermineTheUserLevelOperation:[self myGroupListLocalRead] type:addFriend];
        BOOL a =  [self promptMessageOperationType:addFriend];

        if (a) {

        [self getNetAddFriendfuid:self.m_uid];//加好友
        }
    }
    
}
- (IBAction)clickGoback:(id)sender
{
    if (self.m_chatPush && m_deleFriendPush) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        
    [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - UIAlertController
-(void)addUIAlert
{
   

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self reportAlieert];
        
        
    }];
    [alert addAction:cancel];
    
    
        
        UIAlertAction * cancel1;
        
        if ([self CompareTheBlacklist]) {
            
          cancel1 = [UIAlertAction actionWithTitle:@"移出黑名单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              
               [SVProgressHUD show];
              NSDictionary * dic = [URLPath getNetblacklistRemoveID:self.m_uid];
              [[AFHTTPClient share]getMethod:[dic objectForKey:K_URL] param:[dic objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
                  NSInteger rs = [[respostData safeObjectForKey:K_rs]integerValue];
                  
                  if (rs == 1) {
                      
                     
                      
                      NSDictionary * dic = [respostData objectForKey:K_data];
                      NSInteger a = [[dic objectForKey:@"hx_ret"]integerValue];
                      //这里后台如果返回0则代表移除黑名单失败 我们自己再移除一遍黑名单
                      if (a == 0) {
                  //6.26 xiong
//                      EMError *error = [[EMClient sharedClient].contactManager removeUserFromBlackList:self.m_userInfoModel.m_easeUname];
//                      if (!error) {
//                          NSLog(@"发送成功");
//                          [SVProgressHUD showSuccessWithStatus:@"移除黑名单成功"];
//                         
//                      }else{
//                          
//                          [SVProgressHUD showErrorWithStatus:error.errorDescription];
//                      }
                          
                      }else{
                     
                       [SVProgressHUD showSuccessWithStatus:@"移除黑名单成功"];
                      }
                      [self.m_attentionBtn setTitle:@"添加好友" forState:UIControlStateNormal];
                      [self.m_attentionBtn setImage:ImageNamed(@"chatroom_btn_add") forState:UIControlStateNormal];
                      self.m_attentionBtn.selected = [self compareUser: self.m_userInfoModel];
                      self.m_lowH.constant = 49;
                      self.m_optionsView.hidden = NO;
                      //更新黑名单
                      [m_blockListArray removeAllObjects];
                      //请求黑名单
                      [self AccessBlacklist];

                      
                  }else{
                      
                      [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];

                  }
                  
              } failed:^(NSString *errorMsg) {
                  
                  [SVProgressHUD showErrorWithStatus:errorMsg];

              }];
              
              
            }];

        }else{
            
            cancel1 = [UIAlertAction actionWithTitle:@"加入黑名单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"加入黑名单将不会收到该用户所发任何消息，同时自动解除好友关系，是否将该用户加入黑名单？" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self addBlackListConfirm];
                }];
                
                [alert addAction:cancel];
                UIAlertAction * cancel2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:cancel2];
                [self presentViewController:alert animated:YES completion:nil];
        
                
            }];
        }
       [alert addAction:cancel1];
    
    UIAlertAction * cancel2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel2];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
//加入黑名单操作
-(void)addBlackListConfirm
{
    NSMutableArray * blackListArray = [DTools haveStorageUserBlackList];
    
    if (blackListArray.count >= 20) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"黑名单已满，无法拉黑" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        
        [SVProgressHUD show];
        NSDictionary * dic = [URLPath getNetblacklistAddID:self.m_uid];
        [[AFHTTPClient share]getMethod:[dic objectForKey:K_URL] param:[dic objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
            NSInteger rs = [[respostData safeObjectForKey:K_rs]integerValue];
            
            if (rs == 1) {
                
                NSDictionary * dic = [respostData objectForKey:K_data];
                NSInteger a = [[dic objectForKey:@"hx_ret"]integerValue];
                //这里后台如果返回0则代表加入黑名单失败 我们自己再加入黑名单
                if (a == 0) {
                    //6.26 xiong
//                    EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:self.m_userInfoModel.m_easeUname relationshipBoth:YES];
//                    
//                    if (!error) {
//                        //这里添加成功后 后台自动解除好友   在好友列表里删除该好友
////                        [SVProgressHUD showSuccessWithStatus:@"添加黑名单成功"];
//                        NSLog(@"发送成功");
//                        
//                    }else{
//                        [SVProgressHUD showErrorWithStatus:error.errorDescription];
//                    }
                    
                }
                [m_blockListArray removeAllObjects];
                //获取群组黑名单
                [self AccessBlacklist];
                NSString * str = [NSString stringWithFormat:@"已将%@加入黑名单，可在设置-管理黑名单中进行移除。",self.m_userInfoModel.m_nickname];
                [DTools alertController:self title:nil message:str handler:^(UIAlertAction *action) {
                    
                }];
                [SVProgressHUD dismiss];
                //这里添加成功后 后台自动解除好友
//                [SVProgressHUD showSuccessWithStatus:@"添加黑名单成功"];
                [self RemoveMyFriendID:self.m_uid];//在好友列表里删除该好友
                //更新黑名单
                [m_blockListArray removeAllObjects];
                //请求黑名单
                [self AccessBlacklist];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
            }
        } failed:^(NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    
    }
    
    
}
//举报类型提示框
-(void)reportAlieert
{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择举报类型" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"暴力色情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary * dic = [URLPath getNetReportTypeP:@"1" whoId:self.m_uid Reason:@"暴力色情"];
        [self reportUser:dic];
    }];
    [alert addAction:cancel];
    UIAlertAction * cancel1 = [UIAlertAction actionWithTitle:@"人生攻击" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary * dic = [URLPath getNetReportTypeP:@"1" whoId:self.m_uid Reason:@"人生攻击"];
           [self reportUser:dic];
    }];
    [alert addAction:cancel1];
    UIAlertAction * cancel2 = [UIAlertAction actionWithTitle:@"广告骚扰" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary * dic = [URLPath getNetReportTypeP:@"1" whoId:self.m_uid Reason:@"广告骚扰"];
           [self reportUser:dic];
    }];
    [alert addAction:cancel2];
    UIAlertAction * cancel3 = [UIAlertAction actionWithTitle:@"谣言及虚假消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary * dic = [URLPath getNetReportTypeP:@"1" whoId:self.m_uid Reason:@"谣言及虚假消息"];
           [self reportUser:dic];
    }];
    [alert addAction:cancel3];
    UIAlertAction * cancel4 = [UIAlertAction actionWithTitle:@"政治敏感" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary * dic = [URLPath getNetReportTypeP:@"1" whoId:self.m_uid Reason:@"政治敏感"];
           [self reportUser:dic];
    }];
    [alert addAction:cancel4];
    UIAlertAction * cancel5 = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary * dic = [URLPath getNetReportTypeP:@"1" whoId:self.m_uid Reason:@"其他"];
           [self reportUser:dic];
    }];
    [alert addAction:cancel5];
    UIAlertAction * cancel6 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel6];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 网络请求
/**
 *  得到用户信息
 */
- (void)getNetUserDtat:(NSString*)uid
{
    [SVProgressHUD showWithStatus:@"请求中..."];
    NSDictionary *info =[URLPath getNetUserDtatG:uid];
    NSString *url = [info objectForKey:K_URL];
    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
    
    __weak LookUserViewController *weakSelf = self;
    [[AFHTTPClient share] getMethod:url param:param success:^(NSDictionary *respostData) {
        
        
        DLog(@"成功--pid-%@",respostData);
        int rs=[[respostData safeObjectForKey:K_rs] intValue];
        if (rs==1)
        {
            [SVProgressHUD dismiss];
            //获取自己ID
            NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
            NSString *uidStr=[accountDefaults objectForKey:UserDefaultNameKey];
            NSDictionary *dic=[respostData objectForKey:K_data];
            weakSelf.m_dataDic =[NSDictionary dictionaryWithDictionary:dic];
          weakSelf.m_userInfoModel  =[FriendInformationModel mj_objectWithKeyValues:dic];
           signH = [weakSelf CalculateText:weakSelf.m_userInfoModel.m_signature];//当请求下来时 就计算签名需要的高度
            intrestH = [weakSelf CalculateText:weakSelf.m_userInfoModel.m_intrest];//当请求下来时 就计算兴趣需要的高度
            weakSelf.m_userNameLabel.text = weakSelf.m_userInfoModel.m_nickname;//赋值用户名称
            weakSelf.m_optionsView.hidden = NO;
            //判断对比是否是自己的好友
            if (![weakSelf compareUser: weakSelf.m_userInfoModel]) {
                
                [weakSelf.m_attentionBtn setTitle:@"添加好友" forState:UIControlStateNormal];
                [weakSelf.m_attentionBtn setImage:ImageNamed(@"chatroom_btn_add") forState:UIControlStateNormal];
                weakSelf.m_attentionBtn.selected = [weakSelf compareUser: weakSelf.m_userInfoModel];
                
                
              
            }else{
                
                [weakSelf.m_attentionBtn setTitle:@"删除好友" forState:UIControlStateNormal];
                 [weakSelf.m_attentionBtn setImage:ImageNamed(@"chatroom_btn_del") forState:UIControlStateNormal];
                weakSelf.m_attentionBtn.selected = [weakSelf compareUser: weakSelf.m_userInfoModel];
            }
            
             //如果自己看的是自己的详细信息
            if([weakSelf.m_uid integerValue] == [uidStr integerValue]){
                
                weakSelf.m_lowH.constant = 0;
                weakSelf.m_conversationBtn.hidden = YES;
                weakSelf.m_attentionBtn.hidden = YES;
                weakSelf.m_rightNavBtn.hidden = YES;
                 weakSelf.m_optionsView.hidden = YES;
            }
            
            
            
            weakSelf.m_isNetSuccessA=YES;
            [weakSelf upLayout];
            weakSelf.title=weakSelf.m_userInfoModel.m_nickname;
            [weakSelf.m_tableView reloadData];
        }else{
            weakSelf.m_navBacground.alpha = 1;
            [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
        }

    } failed:^(NSString *errorMsg)
     
     {
         weakSelf.m_navBacground.alpha = 1;
         [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
         
     }];
}

/**
 *  删除好友
 */
- (void)getNetDeleteFriendfuid:(NSString*)fuid
{
    [SVProgressHUD showWithStatus:@"正与好友一刀两断"];
    NSDictionary *info =[URLPath getNetDeleteFriendfuidP:fuid];
    NSString *url = [info objectForKey:K_URL];
    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
    
    __weak LookUserViewController *weakSelf = self;
    [[AFHTTPClient share] getMethod:url param:param success:^(NSDictionary *respostData) {
        
        
        DLog(@"成功--pid-%@",respostData);
        int rs=[[respostData safeObjectForKey:K_rs] intValue];
        if (rs==1)
        {
            [SVProgressHUD dismiss];
           // NSArray *arr=[respostData objectForKey:K_data];
//            NSMutableArray  *modelArr=[FriendListModel mj_objectArrayWithKeyValuesArray:arr];
//            [weakSelf.m_dataArr removeAllObjects];
//            [weakSelf.m_dataArr addObjectsFromArray:modelArr];
//            [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
            //当好友删除操作成功  比对删除好友列表
            [weakSelf comparDeleteUser:[weakSelf.m_uid integerValue]];
            //更改Btn
            [weakSelf.m_attentionBtn setTitle:@"添加好友" forState:UIControlStateNormal];
            [weakSelf.m_attentionBtn setImage:ImageNamed(@"chatroom_btn_add") forState:UIControlStateNormal];
            weakSelf.m_attentionBtn.selected = [weakSelf compareUser: weakSelf.m_userInfoModel];
            m_deleFriendPush = YES;
            [DTools alertController:weakSelf title:nil message:@"删除成功" handler:^(UIAlertAction *action) {
               
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }];
//            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
        }
        //[SVProgressHUD dismiss];
        
    } failed:^(NSString *errorMsg)
     
     {
         [SVProgressHUD showErrorWithStatus:@"失败"];
         
     }];
}
/**
 *  添加好友
 */
- (void)getNetAddFriendfuid:(NSString*)fuid
{
    [SVProgressHUD showWithStatus:@"请求中..."];
    NSDictionary *info =[URLPath getNetAddFriendfuidP:fuid extra:nil from:self.m_from];
    NSString *url = [info objectForKey:K_URL];
    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
    
    __weak LookUserViewController *weakSelf = self;
    
    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
        
        
        DLog(@"成功--pid-%@",respostData);
        int rs=[[respostData safeObjectForKey:K_rs] intValue];
        if (rs==1)
        {
//            [SVProgressHUD dismiss];
           // NSArray *arr=[respostData objectForKey:K_data];
            //            NSMutableArray  *modelArr=[FriendListModel mj_objectArrayWithKeyValuesArray:arr];
            //            [weakSelf.m_dataArr removeAllObjects];
            //            [weakSelf.m_dataArr addObjectsFromArray:modelArr];
            
            //提示框
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"已发送好友申请" preferredStyle:UIAlertControllerStyleAlert];
            //上面控制提示框的内容和标题
            //下面控制提示框的按钮动作
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            //将内容标题加上动作 cancel
            [alert addAction:cancel];
            //然后在视图上显示提示框
            [weakSelf presentViewController:alert animated:YES completion:nil];
            


        }else
        {
            //提示框
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"对方已经是您的好友" preferredStyle:UIAlertControllerStyleAlert];
            //上面控制提示框的内容和标题
            //下面控制提示框的按钮动作
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            //将内容标题加上动作 cancel
            [alert addAction:cancel];
            //然后在视图上显示提示框
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        [SVProgressHUD dismiss];
        
    } failed:^(NSString *errorMsg)
     
     {
         [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
         
     }];
}
-(void)reportUser:(NSDictionary *)info
{
    [[AFHTTPClient share]postMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
            DLog(@"成功--pid-%@",respostData);
            int rs=[[respostData safeObjectForKey:K_rs] intValue];
            if (rs==1)
            {
                UIAlertController * aler = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"对『%@』举报成功，我们将尽快审核处理。",self.m_userInfoModel.m_nickname] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [aler addAction:action];
                [self presentViewController:aler animated:YES completion:nil];
           
//                 [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
                
            }else{
                
                 [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
                
            }
        } failed:^(NSString *errorMsg) {
              [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    
        
    
    
    
    
}
//判断是不是自己的好友
-(BOOL)compareUser:(FriendInformationModel *)friendModel
{
    BOOL a = [DTools compareIsFriend:[friendModel.m_id intValue]];
   
    
    
    return a;
    
}

/**
 *  比对好友  删除对应好友列表的好友 （删除好友成功操作）
 */
-(void)comparDeleteUser:(NSInteger)uid
{
    
    NSMutableArray * array = [self myFriendListLocalRead];
    
    for (int i = 0;  i < array.count ; i ++) {
        FriendListModel * model = array[i];
        if ([model.m_fuid integerValue] == uid) {
            //在好友列表删除对应得好友
            [array removeObjectAtIndex:i];
            //本地储存好友列表
            [self myFriendListLocalStorage:array];
           
            break;
        }
    
    
}
}

//计算文本高度
-(CGFloat)CalculateText:(NSString *)Text
{
    CGFloat allHigh;
    UILabel * labelText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, LCDW - 110, MAXFLOAT)];
    labelText.lineBreakMode = NSLineBreakByTruncatingTail;
    labelText.numberOfLines = 0;
    labelText.text = Text;
    labelText.font=[UIFont systemFamilyFontOfSize:16];
    [labelText sizeToFit];
    //这里加43是除去原高20的一行文字高度 身下的cell应有的高度间距
    allHigh = CGRectGetHeight(labelText.frame) + 43;
    
    if (allHigh < 65) {
        allHigh = 65;
    }
    
    return allHigh;
//    //高度计算公式
//    CGSize size = [labelText sizeThatFits:CGSizeMake(CGRectGetWidth(labelText.frame), MAXFLOAT)];
//    
//    signH = size.height + 45;//本身高度 + 大于的高度 = 总高度
//    if (signH < 65) {
//        signH = 65;
//    }
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
