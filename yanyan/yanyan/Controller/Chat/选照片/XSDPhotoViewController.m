//
//  XSDPhotoViewController.m
//  chat
//
//  Created by 熊申东 on 2017/2/7.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "XSDPhotoViewController.h"
#import "XSDCollectionViewCell.h"
#import "TZAssetModel.h"
#define HMCellIdentifier @"news"

@interface XSDPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray * m_firstStateImageArray;
    
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *m_collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_chooseNumberPhotoW;
@property (weak, nonatomic) IBOutlet UIButton *m_ChooseNumberPhoto;
@property (nonatomic, strong)  UIPageControl *pageContol;
//@property (nonatomic,strong)NSIndexPath * indexPath;
@property (nonatomic,assign)NSInteger currentIndex;
/**
 对勾按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *m_choolseBtn;
//@property (nonatomic, strong) NSArray *newses;
@end

@implementation XSDPhotoViewController

//- (NSArray *)newses
//{
//    
//    if (_newses == nil) {
//        _newses = @[@"111",@"222",@"333"];
//    }
//    return _newses;
//}
-(NSMutableArray *)m_allImageArray
{
    if (!_m_allImageArray) {
        _m_allImageArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return _m_allImageArray;
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];//导航栏为白色所以
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    
}
//-(void)viewDisAppear:(BOOL)animated
//{
//    
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
////    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];//导航栏为白色所以
////        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    
//}
-(void)viewWillDisappear:(BOOL)animated
{
   
//     [self.navigationController setNavigationBarHidden:NO animated:NO];
//     [[UIApplication sharedApplication] setStatusBarHidden:false];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
//    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    layout.minimumInteritemSpacing = 0;
//    layout.minimumLineSpacing = 0;
//    self.m_collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LCDW, LCDH_H) collectionViewLayout:layout];
//    self.m_collection.backgroundColor = [UIColor clearColor];
//    self.m_collection.delegate = self;
//    self.m_collection.dataSource = self;
//    self.automaticallyAdjustsScrollViewInsets = NO;//解决cellForItemAtIndexPath not called问题
    self.m_collection.scrollsToTop = NO;
    self.m_collection.showsHorizontalScrollIndicator = NO;
    self.m_collection.pagingEnabled=YES;
    self.m_collection.contentOffset = CGPointMake(0, 0);
    self.m_collection.contentSize = CGSizeMake(self.m_allImageArray.count * LCDW, 0);
    // 注册cell
//    [self.m_collection registerNib:[UINib nibWithNibName:@"XSDCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HMCellIdentifier];
    
    // 默认显示最中间的那组
    [self.m_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_number inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    TZAssetModel * model = [self.m_allImageArray objectAtIndex:_number];
    self.m_choolseBtn.selected = [self DetermineWhetherSelected:[DTools photoIdefer:model.asset]];
//    [self.view addSubview:self.m_collection];
    
    [self updateChoosePhotoNumber];
    m_firstStateImageArray = [[NSMutableArray alloc]initWithCapacity:0];
    [m_firstStateImageArray addObjectsFromArray:self.m_stateImageArray];
    
}



- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.m_collection indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0];
    [self.m_collection scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    return currentIndexPathReset;
}

///**
// *  下一页
// */
//- (void)nextPage
//{
//    // 1.马上显示回最中间那组的数据
//    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
//    
//    // 2.计算出下一个需要展示的位置
//    NSInteger nextItem = currentIndexPathReset.item + 1;
//    NSInteger nextSection = currentIndexPathReset.section;
//    if (nextItem == self.newses.count) {
//        nextItem = 0;
//        nextSection++;
//    }
//    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
//    
//    // 3.通过动画滚动到下一个位置
//    [self.m_collection scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//}

#pragma mark - UICollectionViewDataSource

/**
 *   滚动视图代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGFloat offSetWidth = scrollView.contentOffset.x;
   
//    NSLog(@"---- ------ ----  %f",offSetWidth);
    NSInteger currentIndex = offSetWidth /LCDW;
//
    if (currentIndex < _m_allImageArray.count && _currentIndex != currentIndex) {
        _currentIndex = currentIndex;
        NSLog(@"******  * * * * ****   %ld",(long)currentIndex);
          }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.m_allImageArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    XSDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HMCellIdentifier forIndexPath:indexPath];
    static NSString * identifer1 = @"XSDCollectionViewCell";
    UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
    [collectionView
     registerNib:nib forCellWithReuseIdentifier:identifer1];
    
    XSDCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer1 forIndexPath:indexPath];
    TZAssetModel * model = [self.m_allImageArray objectAtIndex:indexPath.row];
   [[TZImageManager manager]getPhotoWithAssetXSD:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
  
            cell.m_imageView.image= photo;
       
    }];
//        self.m_choolseBtn.selected = [self DetermineWhetherSelected:model.m_imageData URL:model.m_iamgeURL];
//    NSLog(@"1111");
    return cell;
}
// 返回值为item的大小类型为 CGSize 只有宽高的
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(LCDW, LCDH+20);
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"44444");
    if ([cell isKindOfClass:[XSDCollectionViewCell class]]) {
        [(XSDCollectionViewCell *)cell recoverSubviews];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"333333");
    
//    NSLog(@"%d",indexPath.row);
    TZAssetModel * model = [self.m_allImageArray objectAtIndex:_currentIndex];
    
  self.m_choolseBtn.selected = [self DetermineWhetherSelected: [[TZImageManager manager] getAssetIdentifier:model.asset]];
//    self.indexPath = indexPath;
    if ([cell isKindOfClass:[XSDCollectionViewCell class]]) {
        [(XSDCollectionViewCell *)cell recoverSubviews];
    }
}


#pragma mark  - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{            
    CGFloat offSetWidth = scrollView.contentOffset.x;
    offSetWidth = offSetWidth +  ((LCDW+20)*0.5);
    
    NSInteger currentIndex = offSetWidth / (LCDW + 20);
    
    NSLog(@"------- %ld   ********* %f",currentIndex,scrollView.contentOffset.x);
//
//    if ( _currentIndex != currentIndex) {
//        _currentIndex = currentIndex;
//        TopicimageModel * model = [self.m_allImageArray objectAtIndex:currentIndex];
//        self.m_choolseBtn.selected = [self DetermineWhetherSelected:model.m_imageData];
//   
//    }
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    NSLog(@"scrollViewDidEndDragging--松开");
   
}



//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
        return 0;
    
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
   
        return 0;
}



/**
 点击选择按钮
 */
- (IBAction)clickTouchChoolseBtn:(id)sender
{
    if (self.m_choolseBtn.selected) {
        TZAssetModel * model = self.m_allImageArray[_currentIndex];
        for (int i = 0; i < self.m_stateImageArray.count; i ++) {
            TZAssetModel * model1 = self.m_stateImageArray[i];
            if ([[[TZImageManager manager] getAssetIdentifier:model1.asset] isEqual:[[TZImageManager manager] getAssetIdentifier:model.asset]]) {
                [self.m_stateImageArray removeObjectAtIndex:i];
                self.m_choolseBtn.selected = NO;
                break;
            }
        }
        
    }else{
        if (self.m_stateImageArray.count >=3) {
            [DTools alertController:self title:nil message:@"最多只能选择3张图片哦，试着去掉点" handler:^(UIAlertAction *action) {
                
            }];
        }else{
        
        self.m_choolseBtn.selected = YES;
       
       [self.m_stateImageArray addObject:[self.m_allImageArray objectAtIndex:_currentIndex]];
    

        }
    }
    
    [self updateChoosePhotoNumber];
    
}

/**
 是否在选中图片中
 */
-(BOOL)DetermineWhetherSelected:(NSString *)data
{
    
    
    for ( TZAssetModel * model in self.m_stateImageArray)
    {
        
      
            if ([data isEqualToString: [[TZImageManager manager] getAssetIdentifier:model.asset]])
            {
                return YES;
            }
        
        
    }
    
    return NO;
    
}

/**
 更新右上角照片选择个数
 */
-(void)updateChoosePhotoNumber
{
    if (self.m_stateImageArray.count > 0) {
        self.m_ChooseNumberPhoto.hidden = NO;
        [self.m_ChooseNumberPhoto setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)self.m_stateImageArray.count] forState:UIControlStateNormal];
        self.m_chooseNumberPhotoW.constant = 30;
    }else{
        self.m_ChooseNumberPhoto.hidden = YES;
        [self.m_ChooseNumberPhoto setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)self.m_stateImageArray.count] forState:UIControlStateNormal];
        self.m_chooseNumberPhotoW.constant = 0;
        
        
    }
    
    
    
}
- (IBAction)clickBack:(id)sender
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:KTAKEROOTVIEW object:nil];
    
}

- (IBAction)m_goBack:(id)sender
{
   
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


