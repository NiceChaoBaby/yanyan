////
////  GroupMemberViewController.m
////  chat
////
////  Created by 高超 on 16/3/17.
////  Copyright © 2016年 Dong. All rights reserved.
////
//群成员
#import "GroupMemberViewController.h"
//#import "MemberTableViewCell.h"
////#import "LookUserViewController.h"
//
//#import "GroupMemberModel.h"
//#import "UIImage+UIColor.h"
////#import "ChineseInclude.h"
////#import "PinYinForObjc.h"
//#import "BlockModel.h"
////#import "BMChineseSort.h"
////#import "MyFriendsTableViewCell.h"
@interface GroupMemberViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
//@property (strong, nonatomic)  UITableView *m_tableView;//列表
//@property (strong, nonatomic) UISearchBar *m_searchBar;//搜索
//@property(nonatomic,strong)UISearchDisplayController * m_searchDisplayController;//搜索自带TableView
//
//@property(nonatomic,strong)NSMutableArray * m_searchResultsArr;
//
//@property(nonatomic,retain)NSMutableArray *m_indexArray;
////设置每个section下的cell内容
//@property(nonatomic,retain)NSMutableArray *m_letterResultArr;
////设置每个section下的cell内容
//@property(nonatomic,retain)NSMutableArray *m_modelDataArr;
@end
//
@implementation GroupMemberViewController
//
//-(id)init
//{
//    self=[super init];
//    if (self)
//    {
//        self.m_dataArr=[[NSMutableArray alloc] init];
//        self.m_dataBlockArr=[[NSMutableArray alloc] init];
//
//    }
//    return self;
//}
//
//-(NSMutableArray *)m_dataArr
//{
//    if (!_m_dataArr) {
//        _m_dataArr =[[NSMutableArray alloc]initWithCapacity:0];
//    }
//    
//    return _m_dataArr;
//}
//-(NSMutableArray *)m_modelDataArr
//{
//    if (!_m_modelDataArr) {
//        _m_modelDataArr =[[NSMutableArray alloc]initWithCapacity:0];
//    }
//    
//    return _m_modelDataArr;
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    
//     [self.navigationController setNavigationBarHidden:NO animated:NO];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self StateSetlayout];
//  
//    if (self.m_isChat) {
//        
//        
//        [self requestNet];
//    }else{
//        
//        
//         [self initData];
//    }
//
//   
//   
//    // Do any additional setup after loading the view.
}
//
//-(void)requestNet
//{
//        [SVProgressHUD show];
//    //         [SVProgressHUD show];
//    
//    //    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    NSDictionary * info = [URLPath getNetChatRoomDataGRoomID:ShareAppDelegate.m_roomId];
//    [[AFHTTPClient share]getMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
//        NSInteger  rs = [[respostData safeObjectForKey:K_rs]integerValue];
//        if (rs == 1) {
//            
//            DLog(@"%@",respostData);
//            
//            [SVProgressHUD dismiss];
//            self.m_dataArr = [GroupMemberModel mj_objectArrayWithKeyValuesArray:[respostData objectForKey:K_data]];
//            //添加结束时间
//            for (int i = 0; i <self.m_dataArr.count ; i ++) {
//                GroupMemberModel * model = self.m_dataArr[i];
//                if ([model.m_isforbid boolValue])
//                {
//                    NSDate* theDate=[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:model.m_remain];
//                    
//                    //取两个日期对象的时间间隔：
//                    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
//                    //NSTimeInterval cha=[theDate timeIntervalSinceDate:currentDate];
//                    model.m_endDate=theDate;
//                    [self.m_dataArr replaceObjectAtIndex:i withObject:model];
//                }
//                
//            }
//            
//            [self.m_tableView reloadData];
//             [self initData];
//        }else{
//            
//               [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//        }
//        
//    } failed:^(NSString *errorMsg) {
//           [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
//    }];
//}
//
//-(void)initData
//{
//    if (self.m_isChat) {
//         self.title = [NSString stringWithFormat:@"聊天室成员(%lu)",(unsigned long)self.m_dataArr.count];
//    }else if (self.m_chatRoomType == ChatRoomTypeTopic){
//     
//         self.title = [NSString stringWithFormat:@"话题聊天室成员(%lu)",(unsigned long)self.m_dataArr.count];
//    
//    }else if(self.m_chatRoomType == ChatRoomTypeRolePlay){
//
//         self.title = [NSString stringWithFormat:@"角色扮演聊天室成员(%lu)",(unsigned long)self.m_dataArr.count];
//
//
//    }else{
//    
//    self.title = [NSString stringWithFormat:@"群成员(%lu)",(unsigned long)self.m_dataArr.count];
//    }
//    [self _sortDataArray];
//    self.m_searchResultsArr = [[NSMutableArray alloc]init];
//    [self.m_indexArray insertObject:@"{search}" atIndex:0];
//    [self.m_modelDataArr insertObject:[[self MemberArray:self.m_dataArr] objectForKey:@"manager"] atIndex:0];
//    
//    [self.m_tableView reloadData];
//}
//#pragma mark - 返回联系人
//-(NSMutableDictionary*)MemberArray:(NSArray*)stringArr
//{
//   
//    NSMutableArray *managerArr=[NSMutableArray array];
//    NSMutableArray *memberArr = [NSMutableArray array];
//   
//    //拼音分组
//    for (GroupMemberModel* object in stringArr) {
//        
//        NSString *m_id =object.m_isManger;
//       
//      
//            [memberArr  addObject:object];
//        
//    }
//    
//    NSArray *arr=[self sortIndex:@"m_isManger" dataArr:managerArr];
//    
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:arr,@"manager",memberArr,@"member", nil];
//    return dic;
//}
//-(NSArray *)sortIndex:(NSString*)indexKey dataArr:(NSArray *)dataArr
//
//{
//    
//    NSComparator cmptr = nil;
//    
//    //    if (NO)
//    
//    //    {
//    
//            cmptr = ^(GroupMemberModel* obj1, GroupMemberModel* obj2)
//    
//            {
//    
//                if ([obj1.m_isManger floatValue] > [obj2.m_isManger floatValue])
//    
//                {
//    
//                    return (NSComparisonResult)NSOrderedDescending;
//    
//                }
//    
//                if ([obj1.m_isManger floatValue] < [obj2.m_isManger floatValue])
//    
//                {
//    
//                    return (NSComparisonResult)NSOrderedAscending;
//    
//                }
//    
//                return (NSComparisonResult)NSOrderedSame;
//    
//            };
//    
//    //    }
//    
//    //    else
//    
//    //    {
//    
////    cmptr = ^(GroupMemberModel* obj1, GroupMemberModel* obj2)
////    
////    {
////        
////        if ([obj1.m_isManger floatValue] < [obj2.m_isManger floatValue])
////            
////        {
////            
////            return (NSComparisonResult)NSOrderedDescending;
////            
////        }
////        
////        if ([obj1.m_isManger floatValue] > [obj2.m_isManger floatValue])
////            
////        {
////            
////            return (NSComparisonResult)NSOrderedAscending;
////            
////        }
////        
////        return (NSComparisonResult)NSOrderedSame;
////        
////    };
//    
//    
//    
//    //    }
//    
//    
//    
//    
//    
//    NSArray *newArr = [dataArr sortedArrayUsingComparator:cmptr];
//    
//    return newArr ;
//    
//    
//    
//}
////设置布局
//-(void)StateSetlayout
//{
//    
//    self.m_searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, LCDW, 44)];
//    //self.m_searchBar.backgroundColor = [UIColor grayColor];
//    UIView *searchTextField = nil;
//    self.m_searchBar.delegate=self;
//    //  需要设置barTintColor后, 才能拿到UISearchBarTextField对象
//    self.m_searchBar.barTintColor = [UIColor whiteColor];
//    searchTextField = [[[self.m_searchBar.subviews firstObject] subviews] lastObject];
//    
//    searchTextField.backgroundColor = RGBBgColor;
//    self.m_searchBar.placeholder = @"搜索";
//    //修改搜索框背景
//    self.m_searchBar.backgroundColor=[UIColor whiteColor];
//    //    //去掉搜索框背景
//    [[[[ self.m_searchBar . subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
//    // 添加 searchbar 到 headerview
//  [self.view addSubview:self.m_searchBar];
//    
//
//    self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.m_searchBar.frame), LCDW, LCDH_H-CGRectGetMaxY(self.m_searchBar.frame)) style:UITableViewStylePlain];
//    self.m_tableView.delegate=self;
//    self.m_tableView.dataSource=self;
//    self.m_tableView.tag=10000;
//    self.m_tableView.backgroundColor=RGBBgColor;
//    self.m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    
//    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
//    
//    [self.m_tableView setTableFooterView:v];
//    //改变索引的颜色
//    self.m_tableView.sectionIndexColor =RGBAddAssistColor;
//   
//    [self.view addSubview:self.m_tableView];
//
//
//}
//
//
//
//
//#pragma mark - UITableViewDataSource & UITableViewDelegate
//
////右边索引 字节数(如果不实现 就不显示右侧索引)
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    
////        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:
////                [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
//    if (self.m_tableView.tag==20000)
//    {
//        return [[NSArray alloc] init];
//    }else
//    {
//        return self.m_indexArray;
//    }
//    
//}
//
//////section （标签）标题显示
////- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
////    
////    
////    if (self.m_tableView.tag==20000)
////    {
////        return @"";
////    }else
////    {
////        if (section==0)
////        {
////            return @"群主、管理员";
////        }else
////        {
////            return [self.m_indexArray objectAtIndex:section];
////        }
////        
////    }
////    
////    
////    
////}
//
//
////标签数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    if (self.m_tableView.tag==20000)
//    {
//        return 1;
//    }else
//    {
//        return  self.m_indexArray.count;
//    }
//    
//}
//
//// 设置section的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//   
//    if (self.m_tableView.tag==20000)
//    {
//        return 0;
//    }else
//    {
//        if (section==0) {
//            if (self.m_isChat||self.m_chatRoomType == ChatRoomTypeRolePlay)
//            {
//                return  0;
//                
//            }else 
//            {
//                return  22;
//            }
//        }else
//        {
//            return 22;
//        }
//        
//    }
//    
//    
//}
//
////点击右侧索引表项时调用
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    
//    NSString *key = [self.m_indexArray objectAtIndex:index];
//    NSLog(@"sectionForSectionIndexTitle key=%@",key);
//    if (key == UITableViewIndexSearch) {
//        [self.m_tableView setContentOffset:CGPointZero animated:NO];
//        return NSNotFound;
//    }
//    
//    return index;
//}
//
//
//// 设置cell的高度
//- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.m_tableView.tag==20000)
//    {
//        if (self.m_chatRoomType == ChatRoomTypeRolePlay) {
//            return 65;
//        }else{
//            return 50;
//        }
//
//    }else
//    {
//        if (self.m_chatRoomType == ChatRoomTypeRolePlay) {
//            return 65;
//        }else{
//            return 50;
//        }
//    }
//    
//    
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    if (self.m_tableView.tag==20000)
//    {
//        return  self.m_searchResultsArr.count;
//    }else
//    {
//        return [[self.m_modelDataArr objectAtIndex:section] count];
//    }
//    
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    //去掉底部多余的表格线
//    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
//    //分割线样式
//    tableView.separatorStyle = UITableViewScrollPositionTop ;
//    
//if (self.m_chatRoomType == ChatRoomTypeRolePlay) {
//        
//        
//         static NSString * identifer1 = @"MyFriendsTableViewCell";
//        UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
//        
//        [tableView registerNib:nib forCellReuseIdentifier:identifer1];
//    
////        //新版本  角色扮演 列表   拉取的好友列表Cell
////        MyFriendsTableViewCell * cell = (MyFriendsTableViewCell * )[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
////        cell.selectionStyle = UITableViewCellSelectionStyleNone;
////        GroupMemberModel*model= [self.m_searchResultsArr safeObjectAtIndex:indexPath.row];
//    
//    
//    GroupMemberModel*model;
//    if (self.m_tableView.tag==20000)
//    {
//        
//        
//        
//       model = [self.m_searchResultsArr safeObjectAtIndex:indexPath.row];
//       
//        
//    }else{
//        NSArray *arr=[self.m_modelDataArr objectAtIndex:indexPath.section];
//       model= [arr safeObjectAtIndex:indexPath.row];
//       
//    }
//    //6.26 xiong
////    //判断是男是女：性别 1男  2女
////    if ([model.m_gender isEqualToString:@"1"])
////    {
////        [cell.m_genderImageView setImage:ImageNamed(@"man")];
////        
////        
////    }else
////    {
////        [cell.m_genderImageView setImage:ImageNamed(@"women")];
////        
////    }
////    cell.m_friendName.text=model.m_nickName;
////    [cell.m_avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage)];
////    //隐藏头像点击按钮事件
////    cell.m_clickButton.userInteractionEnabled = YES;
////    cell.m_clickButton.hidden = YES;
////    
////    cell.m_signature.text = [NSString stringWithFormat:@"扮演 %@[%d]",model.m_Rolename,model.m_roleNmuber];
////    [self flagImageViewfriends:cell model:model];//判断是否被禁言
//        return cell;
//    
//    
//}else{
//    
//         static NSString * identifer1 = @"MemberTableViewCell";
//        UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
//        
//        [tableView registerNib:nib forCellReuseIdentifier:identifer1];
//    MemberTableViewCell * cell = (MemberTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell选中样式
//    cell.m_userPhoto.backgroundColor = [UIColor purpleColor];
//  
//    if (self.m_tableView.tag==20000)
//    {
//        
//        
//       
//        GroupMemberModel*model= [self.m_searchResultsArr safeObjectAtIndex:indexPath.row];
//        //判断是男是女：性别 1男  2女
//        if ([model.m_gender isEqualToString:@"1"])
//        {
//            [cell.m_imageGender setImage:ImageNamed(@"man")];
//            
//            
//        }else
//        {
//            [cell.m_imageGender setImage:ImageNamed(@"women")];
//            
//        }
//
//        cell.m_userName.text=model.m_nickName;
//        [cell.m_userPhoto sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage)];
//        [cell.m_menberFlagLab setHidden:NO];
//        cell.m_menberFlagLab.backgroundColor=[UIColor whiteColor];
//       
//            [cell.m_menberFlagLab setHidden:YES];
//        
//        
//        
//
//         [self flagImageView:cell model:model];
//        
//    }else
//    {
//        NSArray *arr=[self.m_modelDataArr objectAtIndex:indexPath.section];
//           GroupMemberModel*model= [arr safeObjectAtIndex:indexPath.row];
//            cell.m_userName.text=model.m_nickName;
//        //判断是男是女：性别 1男  2女
//        if ([model.m_gender isEqualToString:@"1"])
//        {
//            [cell.m_imageGender setImage:ImageNamed(@"man")];
//            
//            
//        }else
//        {
//            [cell.m_imageGender setImage:ImageNamed(@"women")];
//            
//        }
//        [cell.m_userPhoto sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage)];
//        [cell.m_menberFlagLab setHidden:NO];
//         cell.m_menberFlagLab.backgroundColor=[UIColor whiteColor];
//        
//            [cell.m_menberFlagLab setHidden:YES];
//        
//        
//       
//         [self flagImageView:cell model:model];
//    }
//  
//    return cell;
//    }
//    
//}
////-(void)
//-(void)flagImageViewfriends:(MyFriendsTableViewCell *)cell  model:(GroupMemberModel *)model
//{
//    BOOL isBlock=NO;//是否有被屏蔽的人
//    for (BlockModel *blockModel in self.m_dataBlockArr) {
//        if ([blockModel.m_blockUid isEqualToString:model.m_id])
//            
//        {
//            
//            isBlock=YES;
//            break;
//        }
//        
//    }
//    DLog(@"%@",model.m_id);
//    
//    [cell.m_flagImageView setHidden:NO];
//    
//    if ([model.m_isforbid boolValue]&&isBlock)
//    {
//        cell.m_flagImageView.image=ImageNamed(@"chatroom_prohibit");
//    }else if ([model.m_isforbid boolValue])
//    {
//        cell.m_flagImageView.image=ImageNamed(@"chatroom_prohibit");
//    }else if (isBlock)
//    {
//        cell.m_flagImageView.image=ImageNamed(@"chatroom_shield");
//    }else
//    {
//        [cell.m_flagImageView setHidden:YES];
//        cell.m_flagImageView.image=ImageNamed(@"");
//    }
//}
//
//
////-(void)
//-(void)flagImageView:(MemberTableViewCell *)cell  model:(GroupMemberModel *)model
//{
//    BOOL isBlock=NO;//是否有被屏蔽的人
//    for (BlockModel *blockModel in self.m_dataBlockArr) {
//        if ([blockModel.m_blockUid isEqualToString:model.m_id])
//            
//        {
//            
//            isBlock=YES;
//            break;
//        }
//        
//    }
//    DLog(@"%@",model.m_id);
//
//     [cell.m_flagImageView setHidden:NO];
//    
//    if ([model.m_isforbid boolValue]&&isBlock)
//    {
//        cell.m_flagImageView.image=ImageNamed(@"chatroom_prohibit");
//    }else if ([model.m_isforbid boolValue])
//    {
//         cell.m_flagImageView.image=ImageNamed(@"chatroom_prohibit");
//    }else if (isBlock)
//    {
//         cell.m_flagImageView.image=ImageNamed(@"chatroom_shield");
//    }else
//    {
//        [cell.m_flagImageView setHidden:YES];
//         cell.m_flagImageView.image=ImageNamed(@"");
//    }
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, LCDW, 22)];
//    view.backgroundColor=RGBBgColor;
//    
//    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, LCDW-10, 22)];
//    lab.textColor=RGBAddAssistColor;
//    lab.backgroundColor=[UIColor clearColor];
//    lab.font=[UIFont systemFamilyFontOfSize:15];
//    
//        if (section==0)
//        {
//            if (self.m_groupPeople) {
//                 lab.text= @"群主、管理员";
//            }else if(self.m_isChat)
//            {
//                lab.text = @"";
//            }else if(self.m_chatRoomType ==ChatRoomTypeTopic)
//            {
//                lab.text = @"创建人";
//            }else if(self.m_chatRoomType == ChatRoomTypeRolePlay)
//            {
//                lab.text = @"";
//            }
//           
//        }else
//        {
//            lab.text=[self.m_indexArray objectAtIndex:section];
//        }
//    
//    [view addSubview:lab];
//    return view;
//
//}
//
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DLog(@"准备滑动了");
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    editingStyle = UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DLog(@"滑动完毕了");
//    
//}
//
////iOS 8  Cell往左滑动自定义按钮代理
//-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    if (self.m_tableView.tag==20000)
//    {
//        GroupMemberModel*model= [self.m_searchResultsArr safeObjectAtIndex:indexPath.row];
//       return  [self getSetManager:model indexPath:indexPath];
//    }else
//    {
//        NSArray *arr=[self.m_modelDataArr objectAtIndex:indexPath.section];
//        GroupMemberModel*model= [arr safeObjectAtIndex:indexPath.row];
//        return [self getSetManager:model indexPath:indexPath];
//    }
//        
//
//}
///**
// *  管理成员
// *
// *  @param model
// *
// *  @return
// */
//-(NSArray <UITableViewRowAction *> *)getSetManager:(GroupMemberModel*)model indexPath:(NSIndexPath *)indexPath
//{
//   
//    BOOL isBlock=NO;//是否有被屏蔽的人
//    for (BlockModel *blockModel in self.m_dataBlockArr) {
//        if ([blockModel.m_blockUid isEqualToString:model.m_id])
//            
//        {
//            
//            isBlock=YES;
//            break;
//        }
//
//    }
//   
//    //自定义滑动按钮
//    UITableViewRowAction * blockRoWAction  = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消\n屏蔽" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        NSLog(@"取消\n屏蔽");
//        if (self.m_chatRoomType == ChatRoomTypeTopic ||self.m_isChat)
//        {
//            [self getNetChatroomUnblock:ShareAppDelegate.m_roomId mid:model.m_id];
//            
//        }else
//        {
////
//        }
//    }];
//    blockRoWAction.backgroundColor = RGBACOLOR(17, 205, 110, 1);
//           //自定义滑动按钮
//        UITableViewRowAction * forbidRoWAction  = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消\n禁言" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//            NSLog(@"取消\n禁言");
//            
//            [self getNetChatroomUnforbidP:ShareAppDelegate.m_roomId mid:[model.m_id intValue] indexPath:indexPath];
//            
//            
//        }];
//        forbidRoWAction.backgroundColor = RGBACOLOR(255, 149, 0, 1);
//    if(self.m_isChat)
//    {
//        if (isBlock)
//        {
//            return @[blockRoWAction];
//        }
//    }
//    if (self.m_chatRoomType == ChatRoomTypeTopic)
//    {
//
//        
//        
//        
//        if (isBlock)
//        {
//            
//            return @[blockRoWAction];
//            
//             
//        }else
//        {
//            
//        }
//       
//        
//        
//    }
//    //群主
//    if ([self.m_isManager isEqualToString:@"1"])
//    {
//        if ([model.m_isManger intValue]==0)
//        {
//                //群成员
//            //自定义滑动按钮
//            UITableViewRowAction * editRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"设为\n管理" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                NSLog(@"设为\n管理");
////                [self getNetSetadministratorgid:self.m_groupId mid:model.m_id];
//            }];
//             editRoWAction.backgroundColor = RGBBgNavColor;
//           
//           
//           
//            UITableViewRowAction * deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                NSLog(@"移除");
////                [self getNetGetoutGroupgid:self.m_groupId mid:model.m_id];
//            }];
//            deleteRoWAction.backgroundColor =RGBMyInterestColor;
//            
//         
//            
//            if ([model.m_isforbid boolValue])
//            {
//                //自定义滑动按钮
//                UITableViewRowAction * forbidRoWAction  = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消\n禁言" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                    NSLog(@"取消\n禁言");
//                  
////                        [self getNetGroupRevokeGag:model.m_id gid:self.m_groupId];
//                    
//                    
//                }];
//                forbidRoWAction.backgroundColor = RGBACOLOR(255, 149, 0, 1);
//                
//                
//                
//                if (isBlock)
//                {
//                    return @[deleteRoWAction,blockRoWAction,forbidRoWAction,editRoWAction];
//                }else{
//                 return @[deleteRoWAction,forbidRoWAction,editRoWAction];
//                }
//            }else
//            {
//                if (isBlock)
//                {
//                     return @[deleteRoWAction,blockRoWAction,editRoWAction];
//                }else
//                {
//                     return @[deleteRoWAction,editRoWAction];
//                }
//                
//            }
//           
//        }
//        
//        
//        //群主
//        else if ([model.m_isManger intValue]==1)
//        {
//            
//            if (isBlock)
//            {
//                return @[blockRoWAction];
//            }else
//            {
//                 return [[NSArray alloc] init];
//            }
//          
//            
//            
//        }
//        
//        
//        //管理员
//        else
//        {
//            
//            
//            //自定义滑动按钮
//            UITableViewRowAction * editRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消\n管理" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                NSLog(@"取消\n管理员");
////                [self getNetRevokAdministratorGid:self.m_groupId mid:model.m_id];
//            }];
//            editRoWAction.backgroundColor = RGBBgNavColor;
//      
//            UITableViewRowAction * deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                NSLog(@"移除");
////                [self getNetGetoutGroupgid:self.m_groupId mid:model.m_id];
//                
//            }];
//           deleteRoWAction.backgroundColor =RGBMyInterestColor;
//            //自定义滑动按钮
//            
//            if ([model.m_isforbid boolValue])
//            {
//                //自定义滑动按钮
//                UITableViewRowAction * forbidRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消\n禁言" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                    NSLog(@"取消\n禁言");
//                    
////                        [self getNetGroupRevokeGag:model.m_id gid:self.m_groupId];
//                    
//
//                }];
//                forbidRoWAction.backgroundColor = RGBACOLOR(255, 149, 0, 1);
//                
//                
//                if (isBlock)
//                {
//                    return @[deleteRoWAction,blockRoWAction,forbidRoWAction,editRoWAction];
//                }else{
//                    return @[deleteRoWAction,forbidRoWAction,editRoWAction];
//                }
//            }else
//            {
//                if (isBlock)
//                {
//                    return @[deleteRoWAction,blockRoWAction,editRoWAction];
//                }else
//                {
//                    return @[deleteRoWAction,editRoWAction];
//                }
//                
//            }
//
//           
//        }
//        
//        
//        
//    }
//    //管理员
//    else if ([self.m_isManager isEqualToString:@"2"])
//    {
//        
//        if ([model.m_isManger intValue]==0)
//        {
//            //群成员
//            
//          
//         
//            UITableViewRowAction * deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                NSLog(@"移除");
//                
////                 [self setNetData:model.m_id type:2];
////                [self getNetGetoutGroupgid:self.m_groupId mid:model.m_id];
//            }];
//           deleteRoWAction.backgroundColor =RGBMyInterestColor;
//            if ([model.m_isforbid boolValue])
//            {
//                //自定义滑动按钮
//                UITableViewRowAction * forbidRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消\n禁言" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//                    NSLog(@"取消\n禁言");
//                    
//                    
//                  
////                        [self getNetGroupRevokeGag:model.m_id gid:self.m_groupId];
//                   
//
//                }];
//                forbidRoWAction.backgroundColor = RGBACOLOR(255, 149, 0, 1);
//                
//                if (isBlock)
//                {
//                    return @[deleteRoWAction,blockRoWAction,forbidRoWAction];
//                }else{
//                    return @[deleteRoWAction,forbidRoWAction];
//                }
//            }else
//            {
//                if (isBlock)
//                {
//                    return @[deleteRoWAction,blockRoWAction];
//                }else
//                {
//                    return @[deleteRoWAction];
//                }
//                
//            }
//
//            
//        }else
//        {
//            if (isBlock)
//            {
//                return @[blockRoWAction];
//            }else
//            {
//                return [[NSArray alloc] init];
//            }
//        }
//    }
//    else
//    {
//        if (isBlock)
//        {
//            return @[blockRoWAction];
//        }else
//        {
//            return [[NSArray alloc] init];
//        }
//    }
//    
//    
//
//
//}
////点击代理
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    GroupMemberModel*model;
//    if (self.m_tableView.tag==20000)
//    {
//        
//        
//        
//        model= [self.m_searchResultsArr safeObjectAtIndex:indexPath.row];
//        
//        
//        
//        
//    }else
//    {
//        NSArray *arr=[self.m_modelDataArr objectAtIndex:indexPath.section];
//        model= [arr safeObjectAtIndex:indexPath.row];
//        
//        
//    }
//
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Friends" bundle:nil];
//    LookUserViewController * lookUser = [storyboard instantiateViewControllerWithIdentifier:@"LookUserViewController"];
//    lookUser.m_uid=model.m_id;
//    
////    NSUserDefaults * accountDefaults = [NSUserDefaults standardUserDefaults];
//   
//    if (![self.m_form isNull]) {
//    if (self.m_isChat) {
//        self.m_form = [NSString stringWithFormat:@"聊天室『%@』",[self readRoomName]];
//    }else if (self.m_chatRoomType == ChatRoomTypeTopic){
//          self.m_form = [NSString stringWithFormat:@"话题聊天室『%@』",[self readRoomName]];
//    }else if (self.m_chatRoomType == ChatRoomTypeRolePlay){
//        self.m_form = [NSString stringWithFormat:@"角色扮演聊天室『%@』",[self readRoomName]];
//    }
//    }
//
//    lookUser.m_from = self.m_form;
//    [self.navigationController pushViewController:lookUser animated:YES];
//    
//}
//
//#pragma mark - UISearchBarDelegate
//
//- (void):(UISearchBar *)searchBars
//{
//    [searchBars resignFirstResponder];
//    self.m_tableView.tag=20000;
//    [self search:searchBars.text];
//    [self.m_tableView reloadData];
//}
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    if (searchText.length==0)
//    {
//        self.m_tableView.tag=10000;
//       
//        [self.m_tableView reloadData];
//        return;
//    }
//    self.m_tableView.tag=20000;
//    [self search:searchText];
//    [self.m_tableView reloadData];
//}
//- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBars
//{
//    [searchBars resignFirstResponder];
//    self.m_tableView.tag=10000;
//    [self.m_tableView reloadData];
//    
//}
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBars
//{
//    [searchBars resignFirstResponder];
//    self.m_tableView.tag=20000;
//    [self search:searchBars.text];
//    [self.m_tableView reloadData];
//    
//}
//- (void)search:(NSString *)searchText
//{
//    //6.26 xiong
////    [self.m_searchResultsArr removeAllObjects];
////    if (searchText.length>0&&![ChineseInclude isIncludeChineseInString:searchText]) {
////        
////        
////        
////        for (int i=0; i<self.m_dataArr.count; i++) {
////            GroupMemberModel *model=self.m_dataArr[i];
////            if ([ChineseInclude isIncludeChineseInString:model.m_nickName]) {
////                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:model.m_nickName];
////                NSRange titleResult=[tempPinYinStr rangeOfString:searchText options:NSCaseInsensitiveSearch];
////                if (titleResult.length>0) {
////                    [self.m_searchResultsArr addObject:self.m_dataArr[i]];
////                }
////                //                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:[self.m_dataArr[i] objectForKey:@"title"]];
////                //                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:searchBar.text options:NSCaseInsensitiveSearch];
////                //                if (titleHeadResult.length>0) {
////                //                    [self.m_searchResultsArr addObject:self.m_dataArr[i]];
////                //                }
////            }
////            else {
////                NSRange titleResult=[model.m_nickName rangeOfString:searchText options:NSCaseInsensitiveSearch];
////                if (titleResult.length>0) {
////                    [self.m_searchResultsArr addObject:self.m_dataArr[i]];
////                }
////            }
////        }
////    } else if (searchText.length>0&&[ChineseInclude isIncludeChineseInString:searchText]) {
////        for (GroupMemberModel *tempDic in self.m_dataArr) {
////            NSRange titleResult=[tempDic.m_nickName rangeOfString:searchText options:NSCaseInsensitiveSearch];
////            if (titleResult.length>0) {
////                [self.m_searchResultsArr addObject:tempDic];
////            }
////        }
////    }
//    
//}
//
//
//#pragma mark - 网络请求
///**
// *  设置管理员
// *
// *  @param gid 群组ID
// *  @param mid 要设置的ID
// *
// *  @return POST
// */
//-(void)getNetSetadministratorgid:(NSString *)gid mid:(NSString *)mid
//{
//     [SVProgressHUD showWithStatus:@"设置中..."];
//    NSDictionary *info =[URLPath getNetSetadministratorgidP:gid mid:mid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//     __weak GroupMemberViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData)
//     {
//         
//         
//         DLog(@"成功--pid-%@",respostData);
//         int rs=[[respostData safeObjectForKey:K_rs] intValue];
//         if (rs==1)
//         {
//             
////              NSArray *arr=[respostData objectForKey:K_data];
////              NSMutableArray  *modelArr=[GroupMemberModel mj_objectArrayWithKeyValuesArray:arr];
//             [weakSelf setNetData:mid type:0];
//             [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
//             
//         }else
//         {
//             [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//         }
//         //[SVProgressHUD dismiss];
//         
//     } failed:^(NSString *errorMsg)
//     
//     {
//         [SVProgressHUD showErrorWithStatus:@"失败"];
//         
//     }];
//}
///**
// *  取消\n管理员
// *
// *  @param gid 群ID
// *  @param mid 成员ID
// *
// *  @return POST
// */
//-(void)getNetRevokAdministratorGid:(NSString *)gid mid:(NSString *)mid
//{
//    [SVProgressHUD showWithStatus:@"设置中..."];
//    NSDictionary *info =[URLPath getNetRevokAdministratorGidP:gid mid:mid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//     __weak GroupMemberViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData)
//     {
//         
//         
//         DLog(@"成功--pid-%@",respostData);
//         int rs=[[respostData safeObjectForKey:K_rs] intValue];
//         if (rs==1)
//         {
//             
////             NSArray *arr=[respostData objectForKey:K_data];
////             NSMutableArray  *modelArr=[GroupMemberModel mj_objectArrayWithKeyValuesArray:arr];
//             //清空数据
//            
//             
//             [weakSelf setNetData:mid type:1];
//             [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
//             
//         }else
//         {
//             [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//         }
//         //[SVProgressHUD dismiss];
//         
//     } failed:^(NSString *errorMsg)
//     
//     {
//         [SVProgressHUD showErrorWithStatus:@"失败"];
//         
//     }];
//    
//}
///**
//  *  管理员取消用户禁言
//  *
//  *  @param mid 被取消\n禁言的用户
//  *  @param gid 群组id
//  *
//  */
//-(void )getNetGroupRevokeGag:(NSString *)mid gid:(NSString *)gid
//{
//      [SVProgressHUD showWithStatus:@"取消中..."];
//    NSDictionary *info =[URLPath getNetGroupRevokeGagP:mid gid:gid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//     __weak GroupMemberViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData)
//     {
//         
//         
//         DLog(@"成功--pid-%@",respostData);
//         int rs=[[respostData safeObjectForKey:K_rs] intValue];
//         if (rs==1)
//         {
//             
////             NSArray *arr=[respostData objectForKey:K_data];
////             NSMutableArray  *modelArr=[GroupMemberModel mj_objectArrayWithKeyValuesArray:arr];
//             //清空数据
//             
//             
//             [weakSelf setNetData:mid type:3];
//             [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
//             
//         }else
//         {
//             [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//         }
//         //[SVProgressHUD dismiss];
//         
//     } failed:^(NSString *errorMsg)
//     
//     {
//         [SVProgressHUD showErrorWithStatus:@"失败"];
//         
//     }];
//
//}
///**
// *  取消聊天室用户禁言
// *
// *  @param roomId 聊天室id
// *  @param mid 被禁言的用户ID
// *  @return 数据字典
// */
//-(void)getNetChatroomUnforbidP:(NSString *)roomId mid:(int)mid indexPath:(NSIndexPath *)indexPath
//{
//    //    [SVProgressHUD showWithStatus:@"请求数据中....."];
//    
//    
//    NSDictionary *info =[URLPath getNetChatroomUnforbidP:roomId mid:mid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//        __weak GroupMemberViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
//        
//        
//        DLog(@"成功--%@",respostData);
//        
//        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//        //        NSString  *msg=[respostData objectForKey:k_msg];
//        
//        if (rs==1)
//        {
//            NSString *mid=[NSString stringWithFormat:@"%i",[[respostData objectForKey:@"mid"] intValue]];
//            
//            
//            
//          
//            
//          
//            NSMutableArray * array = [[NSMutableArray alloc ]initWithCapacity:0];
//            [array addObjectsFromArray: self.m_dataArr];
//            
//            for (GroupMemberModel *model in array)
//            {
//                if ([model.m_id isEqualToString:mid])
//                {
//                     model.m_isforbid=@"0";
//                    [[NSNotificationCenter defaultCenter] postNotificationName:K_Unforbid_User object:model];
//                    [weakSelf.m_dataArr removeObject:model];
//                    break;
//                }
//            }
//            
//            
//           
//            
//           
//
//           
//            [self.m_tableView reloadData];
//          
//            [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
//            
//
//        } else
//        {
//            
//        }
//        
//        
//    } failed:^(NSString *errorMsg)
//     
//     {
//         
//         
//     }];
//}
//
///**
// *  取消\n屏蔽群组成员
// *
// *  @param gid 群组id
// *  @param mid 屏蔽用户
// *
// */
//-(void )getNetGroupUnblock:(NSString *)mid gid:(NSString *)gid
//{
//    [SVProgressHUD showWithStatus:@"取消中..."];
//    NSDictionary *info =[URLPath getNetGroupUnblockP:gid mid:mid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//     __weak GroupMemberViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData)
//     {
//         
//         
//         DLog(@"成功--pid-%@",respostData);
//         int rs=[[respostData safeObjectForKey:K_rs] intValue];
//         if (rs==1)
//         {
//             
//             NSString *uid=[NSString stringWithFormat:@"%i",[[respostData objectForKey:K_data] intValue]];
//            
//            
//             
//             NSMutableArray * array = [[NSMutableArray alloc ]initWithCapacity:0];
//             [array addObjectsFromArray: weakSelf.m_dataBlockArr];
//             
//                 for (BlockModel *model in array)
//                 {
//                     if ([model.m_blockUid isEqualToString:uid])
//                     {
//                         [weakSelf.m_dataBlockArr removeObject:model];
//                         break;
//                     }
//                 }
//           
//           
//             BlockModel *blockModel=[[BlockModel alloc]init];
//             
//             blockModel.m_blockUid = uid;
//             [[NSNotificationCenter defaultCenter] postNotificationName:K_Unblock_User object:blockModel];
//             [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
//             
//         }else
//         {
//             [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//         }
//         //[SVProgressHUD dismiss];
//           [weakSelf.m_tableView reloadData];
//     } failed:^(NSString *errorMsg)
//     
//     {
//         [SVProgressHUD showErrorWithStatus:@"失败"];
//           [weakSelf.m_tableView reloadData];
//     }];
//    
//}
///**
// *  取消\n屏蔽群组成员
// *
// *  @param gid 群组id
// *  @param mid 屏蔽用户
// *
// */
//-(void )getNetChatroomUnblock:(NSString *)roomId mid:(NSString *)mid
//{
//    [SVProgressHUD showWithStatus:@"取消中..."];
//    NSDictionary *info =[URLPath getNetChatroomUnblockP:roomId mid:mid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//     __weak GroupMemberViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData)
//     {
//         
//         
//         DLog(@"成功--pid-%@",respostData);
//         int rs=[[respostData safeObjectForKey:K_rs] intValue];
//         if (rs==1)
//         {
//             
//             NSString *uid=[NSString stringWithFormat:@"%i",[[respostData objectForKey:K_data] intValue]];
//             
//             
//             
//             NSMutableArray * array = [[NSMutableArray alloc ]initWithCapacity:0];
//             [array addObjectsFromArray: weakSelf.m_dataBlockArr];
//             
//             for (BlockModel *model in array)
//             {
//                 if ([model.m_blockUid isEqualToString:uid])
//                 {
//                     [weakSelf.m_dataBlockArr removeObject:model];
//                     break;
//                 }
//             }
//             
//             BlockModel *blockModel=[[BlockModel alloc]init];
//             
//             blockModel.m_blockUid = uid;
//             [[NSNotificationCenter defaultCenter] postNotificationName:K_Unblock_User object:blockModel];
//             
//             [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
//             
//         }else
//         {
//             [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//         }
//         //[SVProgressHUD dismiss];
//         [weakSelf.m_tableView reloadData];
//     } failed:^(NSString *errorMsg)
//     
//     {
//         [SVProgressHUD showErrorWithStatus:@"失败"];
//         [weakSelf.m_tableView reloadData];
//     }];
//    
//}
//
///**
// *  踢出群
// *
// *  @param gid 群ID
// *  @param mid 成员ID
// *
// *  @return POST
// */
//-(void)getNetGetoutGroupgid:(NSString *)gid mid:(NSString *)mid
//{
//      [SVProgressHUD showWithStatus:@"提交中..."];
//    NSDictionary *info =[URLPath getNetGetoutGroupgidP:gid mid:mid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//     __weak GroupMemberViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData)
//     {
//         
//         
//         DLog(@"成功--pid-%@",respostData);
//         int rs=[[respostData safeObjectForKey:K_rs] intValue];
//         if (rs==1)
//         {
//             
////             NSArray *arr=[respostData objectForKey:K_data];
////             NSMutableArray  *modelArr=[GroupMemberModel mj_objectArrayWithKeyValuesArray:arr];
//             [weakSelf setNetData:mid type:2];
//             
//             [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
//             
//         }else
//         {
//             [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//         }
//         //[SVProgressHUD dismiss];
//         
//     } failed:^(NSString *errorMsg)
//     
//     {
//         [SVProgressHUD showErrorWithStatus:@"失败"];
//         
//     }];
//    
//}
//
///**
// *  重置数据
// *
// *  @param mid  用户id
// *  @param type 0 设置管理员 1取消\n管理员 2踢出群 3 取消\n禁言
// */
//-(void)setNetData:(NSString *)mid type:(int)type
//{
//    
//    
//    NSMutableArray * array = [[NSMutableArray alloc ]initWithCapacity:0];
//    [array addObjectsFromArray: self.m_dataArr];
//    if(type==2)
//    {
//        for (GroupMemberModel *model in array)
//        {
//                if ([model.m_id isEqualToString:mid])
//                {
//                    [self.m_dataArr removeObject:model];
//                     break;
//                }
//        }
//    }else
//    {
//        for (int i=0;i<array.count ;i++)
//        {
//            GroupMemberModel *model =[array objectAtIndex:i];
//            if (type==0)
//            {
//                if ([model.m_id isEqualToString:mid])
//                {
//                    model.m_isManger=@"2";
//                     [self.m_dataArr replaceObjectAtIndex:i withObject:model];
//                    break;
//                }
//            }
//            
//            
//            if (type==1)
//            {
//                if ([model.m_id isEqualToString:mid])
//                {
//                    model.m_isManger=@"0";
//                     [self.m_dataArr replaceObjectAtIndex:i withObject:model];
//                    break;
//                }
//                
//            }
//            if (type==3)
//            {
//                if ([model.m_id isEqualToString:mid])
//                {
//                    model.m_isforbid=@"0";
//                    model.m_endDate=nil;
//                    [self.m_dataArr replaceObjectAtIndex:i withObject:model];
//                    break;
//                }
//                
//            }
//        }
//
//    }
//        if ([self.delegate respondsToSelector:@selector(GroupMemberViewUpdata:)])
//    {
//        [self.delegate GroupMemberViewUpdata:self.m_dataArr];
//    }
//    [self.m_indexArray removeAllObjects];
////    [self.m_letterResultArr removeAllObjects];
//    [self.m_modelDataArr removeAllObjects];
//    [self.m_searchResultsArr removeAllObjects];
//    self.m_tableView.tag=10000;
//    [self.m_searchBar resignFirstResponder];
//    self.m_searchBar.text=@"";
//    //添加数据
//    
//    [self initData];
//
//}
//
//#pragma mark - private data
//
//- (void)_sortDataArray
//{
//
//    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
//    for (GroupMemberModel *model in self.m_dataArr)
//    {
//      
//        //取两个日期对象的时间间隔：
//        //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
//        NSTimeInterval cha=[model.m_endDate timeIntervalSinceDate:[[XSDTimeCalibration share]getServerDate]];
//        if (cha<1)
//        {
//            model.m_isforbid=@"0";
//        }else
//        {
//            model.m_isforbid=@"1";
//        }
//        [array addObject:model];
//    }
//    
//      //6.26 xiong
////    NSMutableArray *contactsSource = [NSMutableArray array];
//  
////    [contactsSource addObjectsFromArray: [[self MemberArray:array] objectForKey:@"member"]];
////    self.m_indexArray = [BMChineseSort IndexWithArray:contactsSource Key:@"m_nickName"];
////    self.m_modelDataArr = [BMChineseSort sortObjectArray:contactsSource Key:@"m_nickName"];
//
//    
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
@end
