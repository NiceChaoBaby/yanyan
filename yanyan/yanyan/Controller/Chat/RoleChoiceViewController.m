//
//  RoleChoiceViewController.m
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "RoleChoiceViewController.h"
#import "RoleDataViewController.h"
@interface RoleChoiceViewController ()<UITableViewDelegate,UITableViewDataSource,RolePlayTableViewCellDelegate>

@end

@implementation RoleChoiceViewController

-(UITableView *)m_tableView
{
    if (!_m_tableView) {
        
        _m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LCDW, LCDH) style:UITableViewStylePlain];
        _m_tableView.delegate = self;
        _m_tableView.dataSource = self;
        //去掉底部多余的表格线
        [_m_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        //分割线样式
        _m_tableView.separatorStyle = UITableViewScrollPositionTop;
//      
//        if ([_m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//            
//            [_m_tableView setSeparatorInset:UIEdgeInsetsMake(0, 55, 0, 0)];
//            
//        }
//       
//        if ([_m_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//            
//            [_m_tableView setLayoutMargins:UIEdgeInsetsMake(0, 55, 0, 0)];
//            
//        }
       
     
    }
    
    return _m_tableView;
    
}

-(NSMutableArray *)m_dataArray
{
    if (!_m_dataArray) {
        _m_dataArray  = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return _m_dataArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
      [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    //这段代码控制聊天室时间到了不让创建人发言
//    //自定义导航栏右边按钮
//    UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [rightButton2 setFrame: CGRectMake(0, 0, 32, 32)];
//    
//    [rightButton2 setImage:ImageNamed(@"chatroom_date_group.png") forState:UIControlStateNormal];
//    [rightButton2 setImage:ImageNamed(@"chatroom_date_group.png") forState:UIControlStateHighlighted];
//    [rightButton2 addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchDown];
//    self.navigationItem.rightBarButtonItems =[[NSArray alloc] initWithObjects: [[UIBarButtonItem alloc]initWithCustomView:rightButton2], nil];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(-10, 0, 32, 32
                         )];
    [leftButton setBackgroundImage:ImageNamed(@"nav_back") forState:UIControlStateNormal
     ];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside
     ];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    UIBarButtonItem * lefBtn = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lefBtn];

    
    
 NSDictionary * dic =  [URLPath getNetRolePlayRoleList:[NSString stringWithFormat:@"%d",self.m_roomID]];
    
    [self getNetRequestData:dic];
    self.title = @"选择角色";
       [self.view addSubview:self.m_tableView];
    
//    [self.m_tableView reloadData];
    
    
    // Do any additional setup after loading the view.
}
//返回按钮
-(void)goBack
{
    if (self.m_fromStatListandData) {
        //这里循环详情寻找详情类  从详情跳转的要返回详情
        for (int i = 0; i <self.navigationController.viewControllers.count ;i ++) {
            
            //比较是否是详情类   是的话直接跳转
            if ([self.navigationController.viewControllers[i] isMemberOfClass:[RoleDataViewController class]]) {
                [self.navigationController popToViewController:self.navigationController.viewControllers[i] animated:YES];
            }
        }
    }else{
        //这里直接跳转根视图 从列表跳转过来的
    [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)addData
{
    
//    RoleModel * model = [[RoleModel alloc]init];
//    model.m_userName = @"张三";
//    model.m_userImageUrl = @"http://b.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=f0c5c08030d3d539c16807c70fb7c566/8ad4b31c8701a18bbef9f231982f07082838feba.jpg";
//    model.m_roleInstructions = @"介绍介绍介绍介绍阿斯兰的发卡见识到了；发卡束带结发拉克丝的就发拉大锯发了卡死机法拉盛快递劫匪拉是宽度附近";
//    
//    RoleModel * model1 = [[RoleModel alloc]init];
//    model1.m_userName = @"李四";
//    model1.m_userImageUrl = @"http://www.qqxoo.com/uploads/allimg/170504/14002I561-10.jpg";
//    model1.m_roleInstructions = @"介绍介绍介绍介绍阿斯兰的发卡见识到了；发卡束带结发拉克丝的就发拉大锯发了卡死机法拉盛快递劫匪拉是宽度附近";
//    
//    
//    RoleModel * model2 = [[RoleModel alloc]init];
//    model2.m_userName = @"李四";
//    model2.m_userImageUrl = @"http://www.qqxoo.com/uploads/allimg/170504/14002I561-10.jpg";
//    model2.m_roleInstructions = @"介绍介绍介绍介绍阿斯兰的发卡见识到了；发卡束带结发拉克丝的就发拉大锯发了卡死机法拉盛快递劫匪拉是宽度附近";
//    
//    [self.m_dataArray addObject:model];
//    [self.m_dataArray addObject:model1];
//    [self.m_dataArray addObject:model2];
// 
    
}

#pragma mark --  网络请求角色名单

- (void)getNetRequestData:(NSDictionary *)info
{
    
       __weak RoleChoiceViewController * role = self;
     [[AFHTTPClient share]getMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
         
         NSInteger rs = [[respostData objectForKey:K_rs]integerValue];
         
         if (rs ==1) {
             
             [role.m_dataArray removeAllObjects];
             [role.m_dataArray addObjectsFromArray:[RoleIntroduceInfo mj_objectArrayWithKeyValuesArray:[respostData objectForKey:K_data]]];
             [role.m_tableView reloadData];
             
         }else{
             
               [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
             [self goBack];//请求错误返回根视图
         }
         
         
         
     } failed:^(NSString *errorMsg) {
         
              [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
          [self goBack];//请求错误返回根视图
            }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"RolePlayTableViewCell";
    RolePlayTableViewCell * cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[RolePlayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.m_rolemodel = [self.m_dataArray safeObjectAtIndex:indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoleIntroduceInfo * m_model = [self.m_dataArray safeObjectAtIndex:indexPath.row];
    
    return [self.m_tableView cellHeightForIndexPath:indexPath model:m_model keyPath:@"m_rolemodel" cellClass:[RolePlayTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
     RoleIntroduceInfo * m_model = [self.m_dataArray safeObjectAtIndex:indexPath.row];
     [[CharacterIntroduced shareInstance]addWaitingFigureView:m_model];
    
}
#pragma mark -- RolePlayTableViewCellDelegate
-(void)RolePlayTableViewCellDelegateState:(RoleIntroduceInfo *)m_rolemodel
{
    

    AnswerModel * model =[ShareAppDelegate.m_ActorsAuditio safeObjectForKey:self.m_easeId];
    
   
    model.m_rolemodel = [[RoleIntroduceInfo alloc]init];
    model.m_rolemodel.m_rdesc = m_rolemodel.m_rdesc;
    model.m_rolemodel.m_rname = m_rolemodel.m_rname;
    model.m_rolemodel.m_avatar = m_rolemodel.m_avatar;
    model.m_rolemodel.m_id = m_rolemodel.m_id;
    model.m_rolemodel.m_roomId = m_rolemodel.m_roomId;
    model.m_rolemodel.m_roleNumber = m_rolemodel.m_roleNumber;
    [ShareAppDelegate.m_ActorsAuditio setObject:model forKey:self.m_easeId];
    //6.26 xiong
//    //聊天中
//    int time = [DTools compareDate:[self tellMeTimeTwo] withDate:self.model.m_remain];
//    
//    if (time >0) {
//        
//     //跳转聊天室
//        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//       
//        ChatViewController *RoleChat=[[ChatViewController alloc] init];
//        //6.26 xiong
////        RoleChat.m_fromStatListandData = self.m_fromStatListandData;
////        RoleChat.m_chatRoomType = ChatRoomTypeRolePlay;
//        RoleChat.m_RoleDataID = [NSString stringWithFormat:@"%d",self.model.m_NewId];
//        ShareAppDelegate.m_roomId = self.model.m_easeId;
//        //房间name
//        [self strongRoomName:self.model.m_NewsName];
//        [accountDefaults setObject:self.model.m_userPhoto forKey:k_roomPoto];
//        [ShareAppDelegate.m_chatRoomDict setObject:RoleChat forKey:K_CHAT_ROOM_KEY];
//        [ShareAppDelegate.m_chatRoomDict setObject:[NSNumber numberWithBool:YES] forKey:K_TOPIC_BOOL];
//        [self.navigationController pushViewController:RoleChat animated:NO];
    
//    }else{
//        
//        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"新闻聊天室『%@』已经结束",self.model.m_NewsName] preferredStyle:UIAlertControllerStyleAlert];
//        //上面控制提示框的内容和标题
//        //下面控制提示框的按钮动作
//        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        //将内容标题加上动作 cancel
//        [alert addAction:cancel];
//        //然后在视图上显示提示框
//        [self presentViewController:alert animated:YES completion:nil];
//        
//        
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
