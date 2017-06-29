//
//  ActorListViewController.m
//  yanyan
//
//  Created by 高超 on 2017/6/28.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "ActorListViewController.h"

#import "AcorlistCollectionViewCell.h"
#import "CharacterIntroducedGC.h"
@interface ActorListViewController ()

@end

@implementation ActorListViewController

-(UICollectionView *)m_collectionView
{
    if (!_m_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置headerView的尺寸大小
        layout.headerReferenceSize = CGSizeMake(0, 0);
        //该方法也可以设置itemSize
        //        layout.itemSize =CGSizeMake(110, 150);
        
        //2.初始化collectionView
        _m_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LCDW, LCDHH) collectionViewLayout:layout];
        _m_collectionView.backgroundColor = [UIColor clearColor];
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_m_collectionView registerClass:[AcorlistCollectionViewCell class] forCellWithReuseIdentifier:@"AcorlistCollectionViewCell"];
        
        //4.设置代理
        _m_collectionView.delegate = self;
        _m_collectionView.dataSource = self;
        //去掉滚动条
        _m_collectionView.showsVerticalScrollIndicator = NO;
        _m_collectionView.showsHorizontalScrollIndicator = NO;
        //        _m_collectionView.scrollEnabled = NO;
        
        
    }
    return _m_collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.m_collectionView];
    // Do any additional setup after loading the view.
}

#pragma mark - UIcollectionViewDelegate

//定义展示的UIcollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
    
    
    return 100;
}

//定义展示的Section的个数

-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView

{
    
    return 1  ;
    
}

//每个UICollectionView展示的内容

-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
    AcorlistCollectionViewCell *cell = (AcorlistCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AcorlistCollectionViewCell" forIndexPath:indexPath];
    
    [cell.m_MoviewPeopleImage sd_setImageWithURL:[NSURL URLWithString:@"http://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F22%2F72%2F62%2F57c7ad7ba739a_1024.jpg&thumburl=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D4153768048%2C2702237%26fm%3D26%26gp%3D0.jpg"] placeholderImage:ImageNamed(@"")];
    cell.m_movePeopleName.text = @"炫酷吊炸天";
    cell.m_roleIntroduceName.text = @"超人";
    //    [cell.m_imageView setImage:ImageNamed(@"1111aaaa.jpg")];
    
    //    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    RoleIntroduceInfo * m_model =[[RoleIntroduceInfo alloc]init];
    m_model.m_rname = @"吊炸天";
    m_model.m_id = 10;
    m_model.m_avatar = @"http://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F22%2F72%2F62%2F57c7ad7ba739a_1024.jpg&thumburl=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D4153768048%2C2702237%26fm%3D26%26gp%3D0.jpg";
    m_model.m_rdesc = @"撒了发牢骚解放啦看似简单弗兰克就阿斯利康的房间拉是宽度附近沙龙的看法就阿斯利康的放假啊顺路快递发就阿斯利康的解放路开始就发了卡死机发了卡死机发流口水就弗兰克撒娇发了卡萨丁就发了卡萨丁就发卡量圣诞节发了卡死机发抗裂砂浆多路阀发卡量圣诞节发拉是宽度附近上课了点击发送考虑到房间里的苦咖啡来得及弗兰克记录卡结束啦扩所付军绿扩扩军军军奥绿扩军军军军军军军军军绿军扩军绿绿扩扩扩扩扩扩扩扩扩扩扩卡绿绿所扩付军所绿付扩军所上放了扩付付绿绿绿绿绿绿绿绿绿绿扩军绿绿绿绿绿绿绿绿绿绿扩扩所绿";
    [[CharacterIntroducedGC shareInstance]addWaitingFigureView:m_model];
    
    
    
}

//定义每个UICollectionView 的大小

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    //    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    //    CGFloat length = [self.m_data[indexPath.row] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    
    CGFloat a = (LCDW - RW(100))/4;
    return CGSizeMake(a , RW(300));
    
    
}


//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake(RW(10),RW(20),RW(30),RW(20));
    
    
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return RW(30);
    
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return RW(20);
    
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
