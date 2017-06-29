//
//  HotTVViewController.m
//  yanyan
//
//  Created by xiong on 2017/6/21.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "HotTVViewController.h"
#import "HotTvIntroduceCell.h"//影视介绍
#import "HotTVRoleTableViewCell.h"//影视人物
#import "HotTVCommentsTableViewCell.h"//影视评论

#import "ActorListViewController.h"
#import "HotCommentM.h"//电影评论Model
#import "MovieIntroduced.h"//电影介绍Model
#import "HotTVDetailsViewController.h"
@interface HotTVViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * m_tableView;
@property(nonatomic,strong)HotCommentM * m_commentModel;
@property(nonatomic,strong)MovieIntroduced * m_movieIntroduced;

@end

@implementation HotTVViewController

-(UITableView *)m_tableView
{
    if (!_m_tableView) {
        _m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,LCDW ,LCDH_H-64) style:UITableViewStylePlain];
        _m_tableView.delegate = self;
        _m_tableView.dataSource = self;
        [_m_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _m_tableView.separatorStyle = UITableViewScrollPositionNone ;
    }
    
    return _m_tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    
}
/**********算Label有几行***********
 
 
 先计算总文字的高度，然后再除以每行文字的高度。
 总文字的高度：CGFloat  textH = [label.text  boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
 每行文字的高度：CGFloat lineHeight = label.font.lineHeight;
 行数：NSInteger  lineCount = textH / lineHeight;
 
 ********/



- (void)viewDidLoad {
    
      [super viewDidLoad];
    [self.view addSubview:self.m_tableView];
    self.m_tableView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 64)
    .bottomSpaceToView(self.view, 0);

    [self addData];
   self.m_tableView.tableHeaderView = [self addHeader];
    // Do any additional setup after loading the view.
}
//添加头视图
-(UIView *)addHeader
{
    
    NSString * url = @"https://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=https%3A%2F%2Ftimgsa.baidu.com%2Ftimg%3Fimage%26quality%3D80%26size%3Db9999_10000%26sec%3D1498627759377%26di%3Dbf00bcceaa55c4cddf0f5ef173e8412a%26imgtype%3D0%26src%3Dhttp%253A%252F%252Fwww.hntqb.com%252Fresfile%252F2017-06-09%252FA22%252F357200_wangf_1496923689532_b.jpg&thumburl=https%3A%2F%2Fss1.bdstatic.com%2F70cFvXSh_Q1YnxGkpoWK1HF6hhy%2Fit%2Fu%3D118306726%2C726359955%26fm%3D11%26gp%3D0.jpg";
  
    //底图
    UIView * m_Hview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LCDW, RW(490))];
//    m_Hview.backgroundColor = [UIColor yellowColor];
    //模态背景图
    UIImageView * m_BimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LCDW, RW(320))];
    m_BimageView.contentMode = UIViewContentModeCenter;
    m_BimageView.clipsToBounds = YES;

    //影视封面
    UIImageView * m_FimageView =[[UIImageView alloc]initWithFrame:CGRectMake(RW(40), RW(20), RW(200),CGRectGetHeight(m_BimageView.frame)-RW(20))];
    m_FimageView.contentMode = UIViewContentModeScaleAspectFill;
    m_FimageView.clipsToBounds = YES;
    [m_FimageView sd_setImageWithURL:[NSURL URLWithString:url]];
    [m_BimageView sd_setImageWithURL:[NSURL URLWithString:url]];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //必须给effcetView的frame赋值,因为UIVisualEffectView是一个加到UIIamgeView上的子视图.
    effectView.frame =CGRectMake(0, 0, LCDW, CGRectGetHeight(m_BimageView.frame));
    //    effectView.contentView
    [m_BimageView addSubview:effectView];
    [m_BimageView addSubview:m_FimageView];
    
     CGFloat W =  LCDW - CGRectGetMaxX(m_FimageView.frame)-RW(80);
    //电影名字
    UILabel * m_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_FimageView.frame)+RW(40), CGRectGetMinY(m_FimageView.frame)+RW(10),W, RW(40))];
    m_nameLabel.textColor = [UIColor whiteColor];
    m_nameLabel.font = [UIFont systemFontOfSize:16];
    m_nameLabel.numberOfLines = 1;
    m_nameLabel.text = @"新木乃伊";
    [m_BimageView addSubview:m_nameLabel];
  
    //演员名称
    UILabel * m_actorlabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_FimageView.frame)+RW(40), CGRectGetMaxY(m_nameLabel.frame)+RW(20),W, RW(100))];
    m_actorlabel.textColor = [UIColor whiteColor];
    m_actorlabel.font = [UIFont systemFontOfSize:14];
    m_actorlabel.numberOfLines = 2;
    m_actorlabel.text = @"演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/演员名称/";
    [m_actorlabel sizeToFit];
    [m_BimageView addSubview:m_actorlabel];
    
    //电影类型
    UILabel * actionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_FimageView.frame)+RW(40),  CGRectGetMaxY(m_actorlabel.frame)+RW(10),W, RW(40))];
    actionLabel.textColor = [UIColor whiteColor];
    actionLabel.font = [UIFont systemFontOfSize:14];
    actionLabel.numberOfLines = 2;
    actionLabel.text = @"动作/奇幻/冒险";
    [m_BimageView addSubview:actionLabel];
    
    //上映时间
    UILabel * numberTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_FimageView.frame)+RW(40),  CGRectGetMaxY(actionLabel.frame)+RW(10),W, RW(40))];
    numberTime.textColor = [UIColor whiteColor];
    numberTime.font = [UIFont systemFontOfSize:14];
    numberTime.numberOfLines = 1;
    numberTime.text = @"2000-08-08";
    [m_BimageView addSubview:numberTime];
    [m_Hview addSubview:m_BimageView];
    
    //进入角色聊天室按钮
    UIButton * m_RoleChat = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(m_BimageView.frame)+RW(60), LCDW-RW(60), RW(80))];
    m_RoleChat.backgroundColor = [UIColor redColor];
    [m_RoleChat setTitle:@"角色聊天" forState:UIControlStateNormal];
    [m_RoleChat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    m_RoleChat.layer.cornerRadius = RW(40);
    m_RoleChat.layer.masksToBounds = YES;
    [m_RoleChat addTarget:self action:@selector(addChatRoom:) forControlEvents:UIControlEventTouchUpInside];
    [m_Hview addSubview:m_RoleChat];
    
    
    return m_Hview;
   
}

/**
 进入聊天室

 @param btn <#btn description#>
 */
-(void)addChatRoom:(UIButton *)btn
{
    
    
}
//加载数据
-(void)addData
{
    self.m_commentModel = [[HotCommentM alloc]init];
    self.m_commentModel.m_userNmae = @"哈哈哈哈";
    self.m_commentModel.m_commentsContent = @"撒了发牢骚解放啦看似简单弗兰克就阿斯利康的房间拉是宽度附近沙龙的看法就阿斯利康的放假啊顺路快递发就阿斯利康的解放路开始就发了卡死机发了卡死机发流口水就弗兰克撒娇发了卡萨丁就发了卡萨丁就发卡量圣诞节发了卡死机发抗裂砂浆多路阀发卡量圣诞节发拉是宽度附近上课了点击发送考虑到房间里的苦咖啡来得及弗兰克记录卡结束啦扩所付军绿扩扩军军军奥绿扩军军军军军军军军军绿军扩军绿绿扩扩扩扩扩扩扩扩扩扩扩卡绿绿所扩付军所绿付扩军所上放了扩付付绿绿绿绿绿绿绿绿绿绿扩军绿绿绿绿绿绿绿绿绿绿扩扩所绿";
    self.m_commentModel.m_ThumbUpCount = @"11";
    self.m_commentModel.m_CommentTime = @"1个小时前";
    self.m_commentModel.m_userPhoto = @"http://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F22%2F72%2F62%2F57c7ad7ba739a_1024.jpg&thumburl=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D4153768048%2C2702237%26fm%3D26%26gp%3D0.jpg";
    self.m_commentModel.m_commentsImage = @"http://img2.imgtn.bdimg.com/it/u=928861582,28679776&fm=26&gp=0.jpg";
    self.m_movieIntroduced = [[MovieIntroduced alloc]init];
    self.m_movieIntroduced.m_MovieIntroduced = @"撒了发牢骚解放啦看似简单弗兰克就阿斯利康的房间拉是宽度附近沙龙的看法就阿斯利康的放假啊顺路快递发就阿斯利康的解放路开始就发了卡死机发了卡死机发流口水就弗兰克撒娇发了卡萨丁就发了卡萨丁就发卡量圣诞节发了卡死机发抗裂砂浆多路阀发卡量圣诞节发拉是宽度附近上课了点击发送考虑到房间里的苦咖啡来得及弗兰克记录卡结束啦扩所付军绿扩扩军军军奥绿扩军军军军军军军军军绿军扩军绿绿扩扩扩扩扩扩扩扩扩扩扩卡绿绿所扩付军所绿付扩军所上放了扩付付绿绿绿绿绿绿绿绿绿绿扩军绿绿绿绿绿绿绿绿绿绿扩扩所绿撒了发牢骚解放啦看似简单弗兰克就阿斯利康的房间拉是宽度附近沙龙的看法就阿斯利康的放假啊顺路快递发就阿斯利康的解放路开始就发了卡死机发了卡死机发流口水就弗兰克撒娇发了卡萨丁就发了卡萨丁就发卡量圣诞节发了卡死机发抗裂砂浆多路阀发卡量圣诞节发拉是宽度附近上课了点击发送考虑到房间里的苦咖啡来得及弗兰克记录卡结束啦扩所付军绿扩扩军军军奥绿扩军军军军军军军军军绿军扩军绿绿扩扩扩扩扩扩扩扩扩扩扩卡绿绿所扩付军所绿付扩军所上放了扩付付绿绿绿绿绿绿绿绿绿绿扩军绿绿绿绿绿绿绿绿绿绿扩扩所绿";
    self.m_movieIntroduced.isOpening = NO;
    self.m_movieIntroduced.shouldShowMoreButton = YES;
}


/**
 进入更多演员信息方法
 */
-(void)moreBtnPeopel:(UIButton *)btn
{
    ActorListViewController * m_actorlist = [[ActorListViewController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:m_actorlist animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.m_tableView)
    {
        CGFloat sectionHeaderHeight = RW(100); //区头高度
        if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >=0) {
            scrollView.contentInset = UIEdgeInsetsMake(- scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {//
        return 1;
    }
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 0;
    }
    return RW(70);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LCDW, RW(70))];
//    view.backgroundColor = [UIColor blueColor];
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(RW(10), RW(20), RW(10),30)];
    image.backgroundColor = [UIColor yellowColor];
   
   [view addSubview:image];
 
   UILabel * m_label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+10, RW(20), RW(LCDW - RW(30)-RW(10)-RW(20)), 30)];
        
   m_label.textColor = [UIColor blackColor];
    if (section == 1) {
          m_label.text =@"影人信息";
               [view addSubview:m_label];
        UIButton * MoreBtn = [UIButton new];
        [MoreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [MoreBtn setTitleColor:RGBAddAssistColor forState:UIControlStateNormal];
       
        MoreBtn.backgroundColor = [UIColor clearColor];
        [MoreBtn addTarget:self action:@selector(moreBtnPeopel:) forControlEvents:UIControlEventTouchUpInside];
     
        [view addSubview:MoreBtn];
        MoreBtn.sd_layout
        .rightSpaceToView(view, 10)
        .topSpaceToView(view, RW(20))
        .leftSpaceToView(m_label, 0)
        .heightIs(30)
        .widthIs(100);
   
         [MoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0,0,-(CGRectGetWidth(MoreBtn.frame)-40))];
    }else{
        
          m_label.text =@"热门评论（99）";
          [view addSubview:m_label];
    }
 
  
      return view;
        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
      CGFloat a = [self.m_tableView cellHeightForIndexPath:indexPath model:self.m_movieIntroduced keyPath:@"m_movieIntroduced" cellClass:[HotTvIntroduceCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
        
        NSLog(@"--------- %f ---------",a);
        // 2.2 根据模型取得cell高度
        return a;
        
        
    }else if (indexPath.section == 1){
         return RW(280);
       
    }else if (indexPath.section == 2){
//
        // 2.2 根据模型取得cell高度
        return [self.m_tableView cellHeightForIndexPath:indexPath model:self.m_commentModel keyPath:@"m_hotCommentM" cellClass:[HotTVCommentsTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
        
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid;
    if (indexPath.section == 0) {//影视介绍------------------------
        cellid = @"HotTvIntroduceCell";
         HotTvIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
//        HotTvIntroduceCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出 //
//        if (cell == nil) {
//            
//            // 是  TableViewCell 不是之前的系统的 UITableViewCell
//            cell = [[HotTvIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath = indexPath;
        
        __weak typeof(self) weakSelf = self;
        if (!cell.moreButtonClickedBlock) {
            [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
                self.m_movieIntroduced.isOpening = !self.m_movieIntroduced.isOpening;
                [weakSelf.m_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }];
        }

        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        ///////////////////////////////////////////////////////////////////////
        cell.m_movieIntroduced =self.m_movieIntroduced;
        return cell;
        
    }else if (indexPath.section == 1){//影视角色---------------------
        
        cellid = @"HotTVRoleTableViewCell";
        
        HotTVRoleTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出 //
        if (cell == nil) {
            
            // 是  TableViewCell 不是之前的系统的 UITableViewCell
            cell = [[HotTVRoleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        ///////////////////////////////////////////////////////////////////////
        return cell;

        
        
//
    }else if (indexPath.section == 2){//影视评论-----------------------
    
        
        cellid = @"HotTVCommentsTableViewCell";
        
        HotTVCommentsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出 //
        if (cell == nil) {
            
            // 是  TableViewCell 不是之前的系统的 UITableViewCell
            cell = [[HotTVCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        ///////////////////////////////////////////////////////////////////////
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.m_hotCommentM = self.m_commentModel;
        return cell;

        
        
    }

    return nil;
}

//点击代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotTVDetailsViewController * hot = [[HotTVDetailsViewController alloc]init];
    [self.navigationController pushViewController:hot animated:YES];
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
