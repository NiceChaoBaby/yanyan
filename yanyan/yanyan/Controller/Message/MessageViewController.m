//
//  MessageViewController.m
//  yanyan
//
//  Created by xiong on 2017/6/28.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCells.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * m_tableView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消息";
    [self initSD];
    self.m_tableView.tableHeaderView=[self myHeaderView];
    // Do any additional setup after loading the view.
}
-(UITableView *)m_tableView
{
    if (!_m_tableView) {
        _m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,LCDW ,LCDH_H) style:UITableViewStylePlain];
        _m_tableView.delegate = self;
        _m_tableView.dataSource = self;
        [_m_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        _m_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine ;
        _m_tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0,0);
         [self.view addSubview:_m_tableView];
    }
    
    return _m_tableView;
}
-(void)initSD
{

   
    self.m_tableView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    
}
-(UIView *)myHeaderView
{
    UIView *headerView=[UIView new];
    headerView.backgroundColor=[UIColor clearColor];
    
    UIView *cell1=[UIView new];
    cell1.backgroundColor=[UIColor clearColor];
    UIImageView *imgTitle1=[UIImageView new];
    imgTitle1.image=ImageNamed(@"avatar");
    [DTools getCorner:imgTitle1 radius:RW(50)];
    [cell1 addSubview:imgTitle1];
    
    UILabel *labRed1=[UILabel new];
    labRed1.backgroundColor=[UIColor redColor];
    [DTools getCorner:labRed1 radius:RW(10)];
    [cell1 addSubview:labRed1];
    
    UILabel *labTitle1=[UILabel new];
    labTitle1.text=@"收到的评论";
    labTitle1.textColor=[UIColor blackColor];
    labTitle1.font=[UIFont systemFontOfSize:15];
    [cell1 addSubview:labTitle1];
    
    UIImageView *imgArrow1=[UIImageView new];
    imgArrow1.image=ImageNamed(@"avatar");
    [cell1 addSubview:imgArrow1];
    UIView *line1=[UIView new];
    line1.backgroundColor=RGBLineColor;
    [cell1 addSubview:line1];
    
    UIView *cell2=[UIView new];
    cell2.backgroundColor=[UIColor clearColor];
    
    UIImageView *imgTitle2=[UIImageView new];
    imgTitle2.image=ImageNamed(@"avatar");
    [DTools getCorner:imgTitle2 radius:RW(50)];
    [cell2 addSubview:imgTitle2];
    
    UILabel *labRed2=[UILabel new];
    labRed2.backgroundColor=[UIColor redColor];
    [DTools getCorner:labRed2 radius:RW(10)];
    [cell2 addSubview:labRed2];
    
    UILabel *labTitle2=[UILabel new];
    labTitle2.text=@"获赞";
    labTitle2.textColor=[UIColor blackColor];
    labTitle2.font=[UIFont systemFontOfSize:15];
    [cell2 addSubview:labTitle2];
    
    UIImageView *imgArrow2=[UIImageView new];
     imgArrow2.image=ImageNamed(@"avatar");
    [cell2 addSubview:imgArrow2];
    
    UIView *line2=[UIView new];
    line2.backgroundColor=RGBLineColor;
    [cell2 addSubview:line2];
    
    UIView *cell3=[UIView new];
    cell3.backgroundColor=[UIColor clearColor];
    UIImageView *imgTitle3=[UIImageView new];
    imgTitle3.image=ImageNamed(@"avatar");
    [DTools getCorner:imgTitle3 radius:RW(50)];
    [cell3 addSubview:imgTitle3];
   
    UILabel *labTitle3=[UILabel new];
    labTitle3.text=@"关注我的";
    labTitle3.textColor=[UIColor blackColor];
    labTitle3.font=[UIFont systemFontOfSize:15];
    [cell3 addSubview:labTitle3];
    UIImageView *imgArrow3=[UIImageView new];
    imgArrow3.image=ImageNamed(@"avatar");
    [cell3 addSubview:imgArrow3];
    UIView *line3=[UIView new];
    line3.backgroundColor=RGBLineColor;
    [cell3 addSubview:line3];
    
    [headerView  sd_addSubviews:@[cell1,cell2,cell3]];
    
    headerView.sd_layout
    .heightIs(RW(420))
    .widthIs(LCDW);
    
    cell1.sd_layout
    .topSpaceToView(headerView,0)
    .rightSpaceToView(headerView, 0)
    .leftSpaceToView(headerView, 0)
    .heightIs(RW(140));
    
    imgTitle1.sd_layout
    .centerYEqualToView(cell1)
    .leftSpaceToView(cell1,RW(20))
    .heightIs(RW(100))
    .widthIs(RW(100));
    
    labRed1.sd_layout
    .leftSpaceToView(imgTitle1,RW(-20))
    .topEqualToView(imgTitle1)
    .offset(RW(10))
    .heightIs(RW(20))
    .widthEqualToHeight();
    
  
    
    labTitle1.sd_layout
    .leftSpaceToView(imgTitle1, RW(30))
    .autoHeightRatio(0)
    .centerYEqualToView(cell1);
    
    
    imgArrow1.sd_layout
    .rightSpaceToView(cell1, RW(30))
    .centerYEqualToView(cell1)
    .heightIs(RW(40))
    .widthEqualToHeight();
    
    line1.sd_layout
    .widthIs(LCDW)
    .bottomEqualToView(cell1)
    .heightIs(RW(1));
    
    cell2.sd_layout
    .topSpaceToView(cell1,0)
    .rightSpaceToView(headerView, 0)
    .leftSpaceToView(headerView, 0)
    .heightIs(RW(140));
    
    imgTitle2.sd_layout
    .centerYEqualToView(cell2)
     .leftSpaceToView(cell2,RW(20))
    .heightIs(RW(100))
    .widthIs(RW(100));
    
    labRed2.sd_layout
    .leftSpaceToView(imgTitle2,RW(-20))
    .topEqualToView(imgTitle2)
    .offset(RW(10))
    .heightIs(RW(20))
    .widthEqualToHeight();
    
    labTitle2.sd_layout
    .leftSpaceToView(imgTitle2, RW(30))
     .autoHeightRatio(0)
    .centerYEqualToView(cell2);
    
    imgArrow2.sd_layout
    .rightSpaceToView(cell2, RW(30))
    .centerYEqualToView(cell2)
    .heightIs(RW(40))
    .widthEqualToHeight();
    
    line2.sd_layout
    .widthIs(LCDW)
    .bottomEqualToView(cell2)
    .heightIs(RW(1));
    
    cell3.sd_layout
    .topSpaceToView(cell2,0)
    .rightSpaceToView(headerView, 0)
    .leftSpaceToView(headerView, 0)
    .heightIs(RW(140));
    
    imgTitle3.sd_layout
    .centerYEqualToView(cell3)
     .leftSpaceToView(cell3,RW(20))
    .heightIs(RW(100))
    .widthIs(RW(100));
    
  
    
    labTitle3.sd_layout
    .leftSpaceToView(imgTitle3, RW(30))
     .autoHeightRatio(0)
    .centerYEqualToView(cell3);
    
    imgArrow3.sd_layout
    .rightSpaceToView(cell1, RW(30))
    .centerYEqualToView(cell1)
    .heightIs(RW(40))
    .widthEqualToHeight();
    
    
    line3.sd_layout
    .widthIs(LCDW)
    .bottomEqualToView(cell3)
    .heightIs(RW(1));
    
    return headerView;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//默认是1
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //加载Xib
    static NSString * identifer = @"MessageTableViewCell";
    MessageTableViewCells *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出 //
    if (cell == nil) {
        
        // 是  TableViewCell 不是之前的系统的 UITableViewCell
        cell = [[MessageTableViewCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
//      MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
//    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.textLabel.text=@"毛线";
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RW(140);
    
}


//点击代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
