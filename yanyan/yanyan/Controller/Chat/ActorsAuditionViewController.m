//
//  ActorsAuditionViewController.m
//  chat
//
//  Created by 高超 on 2017/5/12.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "ActorsAuditionViewController.h"
#import "RoleIntroduceTableViewCell.h"
#import "ActorsAuditionCell.h"
#import "AnswerModel.h"
#import "AnswersModel.h"
#import "RoleChoiceViewController.h"

@interface ActorsAuditionViewController ()

@end

@implementation ActorsAuditionViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    return self.m_model.m_answersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //去掉底部多余的表格线
        [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        //分割线样式
        tableView.separatorStyle = UITableViewScrollPositionNone ;
    if (indexPath.section == 0) {//说明
        
        static NSString * cellID = @"RoleIntroduceTableViewCell";
        RoleIntroduceTableViewCell * cell  = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
            
            cell = [[RoleIntroduceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//隐藏点击效果
        
         
       cell.m_ActorsModel = self.m_model;
        return cell;

//
    }else{//ActorsAuditionCell  答案选项
    
        static NSString * cellID = @"ActorsAuditionCell";
        ActorsAuditionCell * cell  = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
            
            cell = [[ActorsAuditionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//隐藏点击效果
        cell.tag = indexPath.row;
        
        cell.m_ActorsModel = self.m_model;
        
    AnswerModel * model =[ShareAppDelegate.m_ActorsAuditio objectForKey:self.m_model.m_EaseRoom];
    if (model && [model.m_question isEqualToString:self.m_model.m_question] ) {
    
    AnswersModel * answerModel = [self.m_model.m_answersArray safeObjectAtIndex:indexPath.row];
        
        if (model.m_pos == answerModel.m_pos) {//是否是当初用户选择的选项
        
        //动画
        cell.m_label.textColor = RGBBgNavColor;
        cell.m_optionsLabel.textColor = RGBBgNavColor;
        cell.m_passImage.hidden = NO;
        BOOL a;
        
        if (model.m_pos == self.m_model.m_ansRight) {//用户当初选择的是否 是对的
            //这里判断对错
            [cell.m_passImage setImage:ImageNamed(@"yes")];
            a = YES;
            
        }else{
            //这里判断对错
            [cell.m_passImage setImage:ImageNamed(@"no")];
            a = NO;
            
            [SVProgressHUD showErrorWithStatus:@"不了解角色无法进入哦"];

        }
                }
        }
               return cell;
        
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
    
        
        CGFloat a =  [self.m_tableView cellHeightForIndexPath:indexPath model:self.m_model keyPath:@"m_ActorsModel" cellClass:[RoleIntroduceTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
        return a;

//    }else if(indexPath.section == 1){
//        return 170;
//        
    }else{
        
         AnswersModel * answerModel = [self.m_model.m_answersArray safeObjectAtIndex:indexPath.row];
        
         CGFloat a = [self.m_tableView cellHeightForIndexPath:indexPath model:self.m_model keyPath:@"m_ActorsModel" cellClass:[ActorsAuditionCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
        
        if (![DTools isStringEmpty:answerModel.m_photo]) {//有图模式下
            if (a < 118) {
                a = 118;
            }
        }
        
        
        return a;
     
    }
//
        
//        if (indexPath.row == 0) {
//            return 75;
//        }
//        return 65;
//    }
    
//    return 0;
    
}

//点击代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerModel * model = [ShareAppDelegate.m_ActorsAuditio objectForKey:self.m_model.m_EaseRoom];
    if (model == nil) {
    
//
    if (indexPath.section == 1) {
        
     
        
         ActorsAuditionCell * cell = (ActorsAuditionCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        //记录
        model = [[AnswerModel alloc]init];
        model.m_EaseRoomId = self.m_model.m_EaseRoom;//roomid
        model.m_question = self.m_model.m_question;//题目内容
        AnswersModel * AnswerModel = [cell.m_ActorsModel.m_answersArray safeObjectAtIndex:indexPath.row];
        model.m_modelArrayNumber = (int)indexPath.row;//记录数组第几个
        model.m_SelectContent = AnswerModel.m_answer;
        model.m_pos = AnswerModel.m_pos;//用户选择了什么
        [ShareAppDelegate.m_ActorsAuditio setObject:model forKey:self.m_model.m_EaseRoom];//记录选择的
        //动画
        cell.m_label.textColor = RGBBgNavColor;
        cell.m_optionsLabel.textColor = RGBBgNavColor;
        cell.m_passImage.hidden = NO;
        
        
        BOOL a;
        
        if (AnswerModel.m_pos == self.m_model.m_ansRight) {
            //这里判断对错
            [cell.m_passImage setImage:ImageNamed(@"yes")];
            a = YES;
        }else{
            //这里判断对错
            [cell.m_passImage setImage:ImageNamed(@"no")];
            a = NO;
        }
    
        
        [self flashImage:cell.m_passImage push:a];
        
        
    }
    }
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Group" bundle:nil];
//    GroupDetailedViewController * groupDetaile = [storyboard instantiateViewControllerWithIdentifier:@"GroupDetailedViewController"];
//    GroupListModel *model=[self.m_dataArr safeObjectAtIndex:indexPath.row];
//    groupDetaile.m_gid=model.m_id;
//    [self.navigationController pushViewController:groupDetaile animated:YES];
}
-(void)flashImage:(UIImageView *)imageView push:(BOOL)bo
{
    imageView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.1
                     animations:^{
                         
                         imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                     }completion:^(BOOL finish){
                         
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              
                                              imageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                                              
                                          }completion:^(BOOL finish){
                                              
                                              [UIView animateWithDuration:0.1
                                                               animations:^{
                                                                   
                                                                  imageView.transform = CGAffineTransformMakeScale(1, 1);
                                                                   
                                                               }completion:^(BOOL finish){
                                                                   
                                                                   if (finish && bo)
                                                                   {
                                                                   //跳转角色选择界面
      RoleChoiceViewController * rolechoice = [[RoleChoiceViewController alloc]init];
    rolechoice.m_fromStatListandData = self.m_fromStatListandData;//吧从哪里跳转的BOOL传给下个界面
           rolechoice.m_roomID = self.m_model.m_roomID;
                                                                       
           rolechoice.m_easeId = self.m_model.m_EaseRoom;
                                                                       
       NSDictionary * dic = [ self.model mj_keyValues];
       rolechoice.model  = [NewsPlazaModel mj_objectWithKeyValues:dic];
         
           [self.navigationController pushViewController:rolechoice animated:YES];
                                                                       
                                                                   }
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   
                                                               }];
                                          }];
                     }];
    

    
    
    
}
- (void)viewDidLoad {
    
    
    [super viewDidLoad];

//    .widthIs(LCDW-30)
//    .heightIs([self getRealWidth:194]);
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(-10, 0, 32, 32
                                    )];
    [leftButton setBackgroundImage:ImageNamed(@"nav_back") forState:UIControlStateNormal
     ];
    [leftButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside
     ];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    UIBarButtonItem * lefBtn = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lefBtn];
    

    self.m_tableView.bounces = NO;//禁止tableView弹性效果
    self.title = @"演员试镜";
    [self addHead];
    
//       AnswerModel * model =[ShareAppDelegate.m_ActorsAuditio objectForKey:self.m_model.m_EaseRoom];
//    if (model && [model.m_question isEqualToString:self.m_model.m_question] ) {
//        
//        
////        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:model.m_modelArrayNumber inSection:1];
////        ActorsAuditionCell * cell = (ActorsAuditionCell*)[self.m_tableView cellForRowAtIndexPath:indexPath];
//
////        AnswersModel * answerModel = [self.m_model.m_answersArray safeObjectAtIndex:model.m_modelArrayNumber];
//        
////        if (model.m_pos == answerModel.m_pos) {//是否是当初用户选择的选项
//        
////            //动画
////            cell.m_label.textColor = RGBBgNavColor;
////            cell.m_optionsLabel.textColor = RGBBgNavColor;
////            cell.m_passImage.hidden = NO;
//            
//            if (model.m_pos == self.m_model.m_ansRight) {//用户当初选择的是否 是对的
//               //跳转视图
//                
//                //跳转角色选择界面
//                RoleChoiceViewController * rolechoice = [[RoleChoiceViewController alloc]init];
//                rolechoice.m_fromStatListandData = self.m_fromStatListandData;//吧从哪里跳转的BOOL传给下个界面
//                rolechoice.m_roomID = self.m_model.m_roomID;
//                
//                rolechoice.m_easeId = self.m_model.m_EaseRoom;
//                
//                NSDictionary * dic = [ self.model mj_keyValues];
//                rolechoice.model  = [NewsPlazaModel mj_objectWithKeyValues:dic];
//                
//                [self.navigationController pushViewController:rolechoice animated:YES];
//                
//            }
//    }
//    }

    
    
    
    
//    if ([DTools isStringEmpty:self.m_model.m_headImageUrl]) {
//     
//        UIView * m_view = [[UIView alloc]init];
//        CGFloat H = [m_view getRealWidth:194]+20;
//        
//        m_view.frame = CGRectMake(0, 0, LCDW, H);
//        
//        UIImageView * m_image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, LCDW - 30, [m_view getRealWidth:194])];
//        m_image.backgroundColor = [UIColor redColor];
//        
//        [m_view addSubview:m_image];
//        
//        self.m_tableView.tableHeaderView = m_view;
//        
//    }
    
}

//返回按钮
-(void)goBack:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)addHead
{
    
    UIView * m_view = [UIView new];
    
    UILabel * m_titleLabel = [UILabel new];
    m_titleLabel.textColor = RGBChatTextColor;
    //PingFangSC-Medium半粗体
    m_titleLabel.font =[UIFont fontWithName:@"PingFangSC-Medium" size:18.0f];;
    m_titleLabel.text = @"答对问题才有资格进入哦！";
    
//    UIImageView * m_headImage = [UIImageView new];
//    [m_headImage setImage:ImageNamed(@"bgm")];
    UIImageView * m_image = [UIImageView  new];
    m_image.contentMode = UIViewContentModeScaleAspectFit;
    m_image.clipsToBounds = YES;
//
    if ([DTools isStringEmpty:self.m_model.m_headImageUrl]) {//没有头视图
    [m_view sd_addSubviews:@[m_titleLabel]];
    
    
    
    m_view.sd_layout
    .widthIs(LCDW)
    .heightIs(24 + 20+24);//title 距离上面24  下面 24  字体高度20
    
    m_titleLabel.sd_layout
    .leftSpaceToView(m_view, 15)
    .rightSpaceToView(m_view, 15)
    .topSpaceToView(m_view, 24)
    .heightIs(20);
   

    }else{//有头视图
        
        
        [m_view sd_addSubviews:@[m_titleLabel,m_image]];
         m_view.sd_layout
        .widthIs(LCDW)
        .heightIs([m_view getRealWidth:194]+24 +24+20 +12);//head图高 + title 距离上面24  下面 24  字体高度20 + head距离TB距离

        m_titleLabel.sd_layout
        .leftSpaceToView(m_view, 15)
        .rightSpaceToView(m_view, 15)
        .topSpaceToView(m_view, 24)
        .heightIs(20);
        
        m_image.sd_layout
        .leftSpaceToView(m_view, 15)
        .rightSpaceToView(m_view, 15)
        .topSpaceToView(m_titleLabel, 24)
        .heightIs([m_image getRealWidth:194]);
        
        
        [m_image sd_setImageWithURL:[NSURL URLWithString:self.m_model.m_headImageUrl]];
        

        
    }
     self.m_tableView.tableHeaderView = m_view;
    
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
