//
//  MovieFanViewController.m
//  yanyan
//
//  Created by xiong on 2017/6/21.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "MovieFanViewController.h"
#import "HotCommentM.h"
#import "HotTVDetailsTableViewCell.h"
@interface MovieFanViewController ()
@property(nonatomic,strong)HotCommentM * m_commentModel;
@end

@implementation MovieFanViewController

-(UITableView *)m_tableView
{
    if (!_m_tableView) {
        _m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,LCDW ,LCDH_H) style:UITableViewStylePlain];
        _m_tableView.delegate = self;
        _m_tableView.dataSource = self;
        [_m_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _m_tableView.separatorStyle = UITableViewScrollPositionNone ;
    }
    
    return _m_tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.m_tableView];
    self.m_tableView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    [self addData];
    
    // Do any additional setup after loading the view.
}

-(void)addData
{
    self.m_commentModel = [[HotCommentM alloc]init];
    self.m_commentModel.m_userNmae = @"哈哈哈哈";
    self.m_commentModel.m_commentsContent = @"撒了发牢骚解放啦看似简单弗兰克就阿斯利康的房间拉是宽度附近沙龙的看法就阿斯利康的放假啊顺路快递发就阿斯利康的解放路开始就发了卡死机发了卡死机发流口水就弗兰克撒娇发了卡萨丁就发了卡萨丁就发卡量圣诞节发了卡死机发抗裂砂浆多路阀发卡量圣诞节发拉是宽度附近上课了点击发送考虑到房间里的苦咖啡来得及弗兰克记录卡结束啦扩所付军绿扩扩军军军奥绿扩军军军军军军军军军绿军扩军绿绿扩扩扩扩扩扩扩扩扩扩扩卡绿绿所扩付军所绿付扩军所上放了扩付付绿绿绿绿绿绿绿绿绿绿扩军绿绿绿绿绿绿绿绿绿绿扩扩所绿";
    self.m_commentModel.m_ThumbUpCount = @"11";
    self.m_commentModel.m_CommentTime = @"1个小时前";
    self.m_commentModel.m_userPhoto = @"http://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F22%2F72%2F62%2F57c7ad7ba739a_1024.jpg&thumburl=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D4153768048%2C2702237%26fm%3D26%26gp%3D0.jpg";
    self.m_commentModel.m_commentsImage = @"http://img2.imgtn.bdimg.com/it/u=928861582,28679776&fm=26&gp=0.jpg";
    self.m_commentModel.m_moviewName = @"新木乃伊";
    self.m_commentModel.m_moviewData = @"名字名字、名字名字、名字名字、名字名字、名字名字、名字名字、";
    self.m_commentModel.m_moviewImage = @"https://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=https%3A%2F%2Ftimgsa.baidu.com%2Ftimg%3Fimage%26quality%3D80%26size%3Db9999_10000%26sec%3D1498627759377%26di%3Dbf00bcceaa55c4cddf0f5ef173e8412a%26imgtype%3D0%26src%3Dhttp%253A%252F%252Fwww.hntqb.com%252Fresfile%252F2017-06-09%252FA22%252F357200_wangf_1496923689532_b.jpg&thumburl=https%3A%2F%2Fss1.bdstatic.com%2F70cFvXSh_Q1YnxGkpoWK1HF6hhy%2Fit%2Fu%3D118306726%2C726359955%26fm%3D11%26gp%3D0.jpg";
    
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.m_tableView cellHeightForIndexPath:indexPath model:self.m_commentModel keyPath:@"m_hotCommentM" cellClass:[HotTVDetailsTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellid = @"HotTVDetailsTableViewCell";
    
    HotTVDetailsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出 //
    if (cell == nil) {
        
        // 是  TableViewCell 不是之前的系统的 UITableViewCell
        cell = [[HotTVDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.m_hotCommentM = self.m_commentModel;
    return cell;
}

//点击代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Group" bundle:nil];
    //
    //    GroupDetailedViewController * groupDetaile = [storyboard instantiateViewControllerWithIdentifier:@"GroupDetailedViewController"];
    //    GroupListModel *model=[self.m_dataArr safeObjectAtIndex:indexPath.row];
    //    groupDetaile.m_gid=model.m_id;
    //    [self.navigationController pushViewController:groupDetaile animated:YES];
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
