//
//  ChoosePhotosViewController.m
//  chat
//
//  Created by 高超 on 2017/2/22.
//  Copyright © 2017年 Dong. All rights reserved.
//
#import "CameraCollectionViewCell.h"
#import "PhoneAlbumTableViewCell.h"
#import "TZAssetModel.h"
#import "PhotoAlbumTitle.h"

#import "LookBigImageViewController.h"
#import "ChoosePhotosViewController.h"
#define CellWith (LCDW-6)/3
@interface ChoosePhotosViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,CameraCollectionViewDeleagete>
{
    BOOL isFist;//是否是第一次读取照片
}
/**
 *  下拉按钮
 */
@property(nonatomic,strong) PhotoAlbumTitle *m_titleBtn;
@property(nonatomic,strong) NSArray *m_photoArr;
@property(nonatomic,strong) NSMutableArray * m_firstArray;
/**
 *  表格照片数组
 */
@property(nonatomic,strong) NSMutableArray *m_imageArr;
/**
 *  全部照片数组
 */
@property(nonatomic,strong) NSMutableArray *m_imageDataArr;

///**
// *  全部照片url数组
// */
//@property(nonatomic,strong) NSMutableArray *m_imageUrlDataArr;
/**
 *  封面图
 */
@property(nonatomic,strong) NSMutableArray *m_posterImageArr;
/**
 *  表格
 */
@property(nonatomic,strong) UITableView *m_table;
/**
 *  照片数量
 */
//@property(nonatomic,strong) UILabel *m_photoNum;

@property (weak, nonatomic) IBOutlet UIButton *m_ChooseNumberPhoto;//个数按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_chooseNumberPhotoW;//个数宽度
@property (weak, nonatomic) IBOutlet UIButton *m_touchOriginalImage;//点击选择原图按钮
@property (weak, nonatomic) IBOutlet UILabel *m_allNumberM;//显示总大小Label
@property (weak, nonatomic) IBOutlet UIButton *m_SelectDisplay;//显示是否原图的图标按钮


@end

@implementation ChoosePhotosViewController
-(NSMutableArray *)m_firstArray
{
    if (!_m_firstArray) {
        _m_firstArray =[[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return _m_firstArray;
    
}
-(NSMutableArray *)m_imageDataArr
{
    if (!_m_imageDataArr) {
        _m_imageDataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return _m_imageDataArr;
}
-(NSMutableArray *)m_posterImageArr
{
    if (!_m_posterImageArr) {
        _m_posterImageArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return _m_posterImageArr;
}
-(NSMutableArray *)m_imageArr
{
    if (!_m_imageArr) {
        _m_imageArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _m_imageArr;
}
- (void)viewDidLoad
{
        [super viewDidLoad];
    
    //    [SVProgressHUD showWithStatus: maskType:SVProgressHUDMaskTypeClear];
    [self initTitle];
    [self.m_firstArray removeAllObjects];
    [self.m_firstArray addObjectsFromArray:self.m_chooseArray];
    
    [TZImageManager manager].photoPreviewMaxWidth = 600;
    [TZImageManager manager].columnNumber=3;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeRootView) name:KTAKEROOTVIEW object:nil];
 
    [self getImgs:@"相机胶卷"];
    
    //    [self initData];
}
//-(void)initData
//{
//
////    self.m_collectionView.backgroundColor=RGBBgCOLOR;
//    self.m_imageArr=[[NSMutableArray alloc] initWithCapacity:0];
//    self.m_imageDataArr=[[NSMutableArray alloc] initWithCapacity:0];
//    self.m_posterImageArr=[[NSMutableArray alloc] initWithCapacity:0];
//     self.m_imageUrlDataArr=[[NSMutableArray alloc] initWithCapacity:0];
//
////    UINib *nib = [UINib nibWithNibName:@"PhotoAlbumCollectionViewCell" bundle:nil];
////
////    [self.m_collectionView registerNib:nib forCellWithReuseIdentifier:@"PhotoAlbumCollectionViewCell"];
//
////    [self.m_imageArr removeAllObjects];
////
////    [self getImgs:@"相机胶卷"];
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];//导航栏为白色所以状态栏设为黑色
    
    isFist=YES;
    [self.m_collectionViews reloadData];
    [self updateChoosePhotoNumber];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //     [self.navigationController setNavigationBarHidden:NO animated:NO];
   
    //离开时还原白色状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}
#pragma mark -
#pragma mark 初始化视图
-(void)initTitle
{
    
    
    self.m_topNav.backgroundColor=[UIColor whiteColor];
    CGSize size=[self getString:@"相机胶卷" fontSize:18];
    self.m_titleBtn=[[PhotoAlbumTitle alloc] initWithFrame:CGRectMake((LCDW-size.width)/2, 20, size.width, 44)];
    [self.m_titleBtn setBackgroundColor:[UIColor clearColor]];
    [self.m_titleBtn.m_titleLab setText:@"相机胶卷"];
    self.m_titleBtn.m_titleLab.textColor = RGBChatTextColor;
    [self.m_titleBtn.m_imageBtn setImage:[UIImage imageNamed:@"btn_list_on"] forState:UIControlStateNormal];
    [self.m_titleBtn.m_imageBtn setSelected:NO];
    [self.m_titleBtn.m_imageBtn setImage:[UIImage imageNamed:@"btn_list_off"] forState:UIControlStateSelected];
    [self.m_titleBtn addTarget:self action:@selector(upArrow:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_topNav addSubview:self.m_titleBtn];
    
 
    
    
}

/**
 是否在选中图片中
 */
-(BOOL)DetermineWhetherSelected:(NSString *)data
{
    
    
    for ( TZAssetModel * model in self.m_chooseArray) {
        
        if (ISIOS8) {
            
            PHAsset *phAsset = (PHAsset *)model.asset;
            if ([data isEqualToString:phAsset.localIdentifier]) {
                return YES;
            }
            
        } else {
            ALAsset *alAsset = (ALAsset *)model.asset;
            NSURL *assetUrl = [alAsset valueForProperty:ALAssetPropertyAssetURL];
            if ([data isEqualToString: assetUrl.absoluteString]) {
                return YES;
            }
        }
        
    }
    
    return NO;
    
}
#pragma mark -- UICollectionDelegate,UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    self.m_photoNum.text=[NSString stringWithFormat:@"%lu张",(unsigned long)self.m_imageDataArr.count];
    return  self.m_imageDataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    CameraCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CameraCollectionViewCell" forIndexPath:indexPath];
    TZAssetModel * model = [self.m_imageDataArr objectAtIndex:indexPath.row];
    cell.m_indexPath = indexPath;
    NSString * str =   [cell refreshModel:model];
    cell.m_selectBtn.selected =  [self DetermineWhetherSelected:str];
    cell.backgroundColor=[UIColor whiteColor];
    cell.delegate = self;
    return cell;
    
}
- (void)getImage:(NSString *)urlStr imageView:(UIImageView *)imageView
{
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    
    LookBigImageViewController * photoView = [story instantiateViewControllerWithIdentifier:@"LookBigImageViewController"];
    [photoView.m_allImageArray addObjectsFromArray:self.m_imageDataArr];
    photoView.m_stateImageArray = self.m_chooseArray;
    photoView.number = indexPath.row;
    [photoView tellMeiSFirstPhoto:self.m_SelectDisplay.selected popViewtellMeFirst:^(BOOL isFirst,BOOL send) {
       
        self.m_SelectDisplay.selected = isFirst;
        
        if (send == YES) {//发送消息
            
          
            if ([self.delegate respondsToSelector:@selector(ChoosePhotosDelegateSendingPictures:)]) {
                [self.delegate ChoosePhotosDelegateSendingPictures:self.m_chooseArray];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            
        }else{
        
        
        
        if (self.m_SelectDisplay.selected) {
            
            [[TZImageManager manager] getPhotosBytesWithArray:self.m_chooseArray completion:^(NSString *totalBytes) {
                self.m_allNumberM.text =[NSString stringWithFormat:@"原图（%@）",totalBytes];//计数返回
                self.m_allNumberM.textColor = RGBChatTextColor;
            }];
            
            
        }else{
            
            self.m_allNumberM.text = @"原图";//计数返回
            self.m_allNumberM.textColor = RGBAssistColor;//字体更改


            
        }
            
        }
    }];
    [self.navigationController pushViewController:photoView animated:YES];
    
}


/**
 是否有照片
 */
-(void)IsTouchPhoto
{
    if (self.m_chooseArray.count > 0) {
          self.m_allNumberM.textColor = RGBChatTextColor;
    }else{
        
          self.m_allNumberM.textColor = RGBAssistColor;//字体更改
        
    }
    
    
}
/**
 *  设置图片方向
 *
 *  @param orientation 方向
 *
 *  @return 方向值
 */
-(int)setImageOrientation:(ALAssetOrientation)orientation
{
    int or;
    switch (orientation)
    {
        case 0:
            or=0;
            break;
        case 1:
            or=1;
            break;
        case 2:
            or=2;
            break;
        case 3:
            or=3;
            break;
        case 4:
            or=4;
            break;
        case 5:
            or=5;
            break;
        case 6:
            or=6;
            break;
        case 7:
            or=7;
            break;
            
            
        default:
            break;
    }
    return or;
}
/**
 *  修改图片的方向
 *
 *  @param aImage 图片
 *
 *  @return 图片
 */
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize size = CGSizeMake(CellWith,CellWith);
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1,0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}


#pragma mark -
#pragma mark -表格代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return self.m_imageArr.count;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PhoneAlbumTableViewCellIdentifier = @"PhoneAlbumTableViewCell";
    
    PhoneAlbumTableViewCell *cell = (PhoneAlbumTableViewCell*)[tableView dequeueReusableCellWithIdentifier:PhoneAlbumTableViewCellIdentifier];
    if (cell == nil)
    {
        cell= (PhoneAlbumTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PhoneAlbumTableViewCell" owner:self options:nil]  lastObject];
    }
    
    TZAlbumModel * model=[self.m_imageArr objectAtIndex:indexPath.row];
    cell.m_imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.m_imageView.clipsToBounds = YES;
    
    
    [[TZImageManager manager] getPostImageWithAlbumModel:model completion:^(UIImage *postImage) {
        cell.m_imageView.image = postImage;
    }];
    cell.m_titleLab.text=[NSString stringWithFormat:@"%@(%ld)",model.name,model.count];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self upArrow:self.m_titleBtn];
    TZAlbumModel * model=[self.m_imageArr objectAtIndex:indexPath.row];
    
    
    __weak typeof(self) weakSelf = self;
    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models2) {
        
        CGSize size=[weakSelf getString:model.name fontSize:17];
        [weakSelf.m_titleBtn setFrame:CGRectMake((LCDW-size.width)/2, 20, size.width, 44)];
        
        [weakSelf.m_titleBtn.m_titleLab setText:model.name];
        [weakSelf.m_collectionViews reloadData];
        [weakSelf.m_imageDataArr removeAllObjects];
        [weakSelf.m_imageDataArr addObjectsFromArray:models2];
    }];
    
}


#pragma mark -
#pragma mark 按钮事件
-(void)upArrow:(PhotoAlbumTitle *)sender
{
    if (sender.m_imageBtn.selected)
    {
        
        UIView *downView=(UIView *)[self.view viewWithTag:1000];
        UIButton *bgBtn=(UIButton *)[self.view viewWithTag:2000];
        [bgBtn removeFromSuperview];
        //结束动画
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [downView setHidden:NO];
            downView.alpha=0;
            [self.m_table setHidden:YES];
            downView.frame=CGRectMake(downView.frame.origin.x, 64, downView.frame.size.width, 0);
            
        } completion:^(BOOL finished)
         {
             
             [downView removeFromSuperview];
             
         }];
    }else
    {
        //下拉视图
        UIView *downView=[[UIView alloc] initWithFrame:CGRectMake(0, TITLES_H, LCDW, 0)];
        downView.backgroundColor=[UIColor whiteColor];
        downView.alpha=0;
        downView.tag=1000;
        [downView  setHidden:YES];
        [self.view addSubview:downView];
        
        //创建表格
        self.m_table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, LCDW, LCDH_H*0.75) style:UITableViewStylePlain];
        self.m_table.delegate=self;
        self.m_table.dataSource=self;
        
        
        UIButton *bgBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, TITLES_H, LCDW,LCDH_H)];
        [bgBtn setBackgroundColor:RGBACOLOR(0, 0, 0, 0.3)];
        [bgBtn addTarget:self action:@selector(clickBgBtn:) forControlEvents:UIControlEventTouchUpInside];
        bgBtn.tag=2000;
        [self.view insertSubview:bgBtn belowSubview:downView];
        
        
        //开始动画
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [downView setHidden:NO];
            downView.alpha=1;
            
            downView.frame=CGRectMake(downView.frame.origin.x, TITLES_H, downView.frame.size.width, LCDH_H*0.75);
        } completion:^(BOOL finished)
         {
             [downView addSubview:self.m_table];
             [self.m_table reloadData];
         }];
    }
    
    sender.m_imageBtn.selected=!sender.m_imageBtn.selected;
}

//-(void)backButton:(UIButton *)sender
//{
//  [self dismissViewControllerAnimated:NO completion:nil];
//  [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
//}


/**
 返回按钮
 
 */
- (IBAction)clickBackButton:(id)sender
{
    //因为拿过来的是权限数组 所以换回去的时候 要把初始数组给回去
    [self.m_chooseArray removeAllObjects];
    [self.m_chooseArray addObjectsFromArray:self.m_firstArray];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
    
}

/**
 确认按钮
 */
- (IBAction)ClickNextBtn:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(ChoosePhotosDelegateSendingPictures:)]) {
        [self.delegate ChoosePhotosDelegateSendingPictures:self.m_chooseArray];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
 
    
}

/**
 直接返回创建聊天室界面通知
 */
-(void)takeRootView
{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(void)clickBgBtn:(UIButton *)sender
{
    DLog(@"点击我了");
    [sender removeFromSuperview];
    //self.m_titleBtn.selected=!self.m_titleBtn.selected;
    [self upArrow:self.m_titleBtn];
}
- (BOOL)isCameraRollAlbum:(NSString *)albumName {
    
    NSString *versionStr = [[UIDevice currentDevice].systemVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (versionStr.length <= 1) {
        versionStr = [versionStr stringByAppendingString:@"00"];
    } else if (versionStr.length <= 2) {
        versionStr = [versionStr stringByAppendingString:@"0"];
    }
    CGFloat version = versionStr.floatValue;
    // 目前已知8.0.0 - 8.0.2系统，拍照后的图片会保存在最近添加中
    if (version >= 800 && version <= 802) {
        return [albumName isEqualToString:@"最近添加"] || [albumName isEqualToString:@"Recently Added"];
    } else {
        return [albumName isEqualToString:@"最近添加"]||[albumName isEqualToString:@"最近删除"]||[albumName isEqualToString:@"视频"]||[albumName isEqualToString:@"慢动作"] ||[albumName isEqualToString:@"已隐藏"];
        //        return YES;
    }
}
-(void)getImgs:(NSString *)typeName
{
    
    
    __weak typeof(self) weakSelf = self;
    [[TZImageManager manager] getAllAlbums:NO allowPickingImage:YES completion:^(NSArray<TZAlbumModel *> *models) {
        
        
        [weakSelf.m_imageArr removeAllObjects];
        [weakSelf.m_imageArr addObjectsFromArray:models];
        TZAlbumModel *tz=   models.firstObject;
        [weakSelf.m_table reloadData];
        
        
        [[TZImageManager manager] getAssetsFromFetchResult:tz.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models2) {
            
            
            
            CGSize size=[self getString:tz.name fontSize:17];
            [self.m_titleBtn setFrame:CGRectMake((LCDW-size.width)/2, 20, size.width, 44)];
            [self.m_titleBtn.m_titleLab setText:tz.name];
            
            
            
            [weakSelf.m_imageDataArr removeAllObjects];
            [weakSelf.m_imageDataArr addObjectsFromArray:models2];
            [weakSelf.m_collectionViews  reloadData];
            [SVProgressHUD dismiss];
            
        }];
    }];
}


/**
 *  得到标题长度
 *
 *  @param str      字符串
 *  @param fontSize 字体大小
 *
 *  @return
 */
-(CGSize)getString:(NSString *)str fontSize:(CGFloat)fontSize
{
    CGSize detailSize = [str sizeWithFont:[UIFont systemFamilyFontOfSize:fontSize] constrainedToSize:CGSizeMake(600, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    //加了图片大小15，图片和标题间距2
    detailSize.width= detailSize.width+17;
    return detailSize;
}
#pragma mark -- CameraCollectionViewDeleagete

-(void)CameraCollectionViewDeleageteChoosePhoto:(NSIndexPath *)indexPath Chools:(BOOL)chools
{
    
    
    
    if (chools) {
        if (self.m_chooseArray.count >= 3) {
            [DTools alertController:self title:nil message:@"最多只能选择3张图哦，试着去掉点" handler:^(UIAlertAction *action) {
                
            }];
            
        }else{
//                  NSString * str= [totalBytes substringToIndex:totalBytes.length-1];
            TZAssetModel * model1 = self.m_imageDataArr[indexPath.row];
            
            if (self.m_SelectDisplay.selected) {
                 model1.m_isOriginalImage = YES;
            }

            [self.m_chooseArray addObject:model1];
            
        }
        
    }else{
        
        TZAssetModel * model = self.m_imageDataArr[indexPath.row];
        for (int i = 0; i < self.m_chooseArray.count; i ++) {
            
            TZAssetModel * model1 = self.m_chooseArray[i];
           
            if ([[DTools photoIdefer:model1.asset] isEqualToString:[DTools photoIdefer:model.asset]]) {
                [self.m_chooseArray removeObjectAtIndex:i];
                
                break;
            }
            
        }
        
    }
    [self.m_collectionViews reloadItemsAtIndexPaths:@[indexPath]];
    [self updateChoosePhotoNumber];
    
    if (self.m_SelectDisplay.selected && self.m_chooseArray.count > 0) {
        
        [[TZImageManager manager] getPhotosBytesWithArray:self.m_chooseArray completion:^(NSString *totalBytes) {
            
            
      
            self.m_allNumberM.text =[NSString stringWithFormat:@"原图（%@）",totalBytes];//计数返回
            [self ChangeStates:self.m_chooseArray isYESorNO:YES];
            
        }];
    }else if(self.m_chooseArray.count == 0){
        
        self.m_SelectDisplay.selected = NO;//改为不选中
        self.m_allNumberM.text = @"原图";//计数返回
        self.m_allNumberM.textColor = RGBAssistColor;//字体更改
        
        [self ChangeStates:self.m_chooseArray isYESorNO:NO];
    }

    [self IsTouchPhoto];
}


/**
 替换是否原图

 @param array <#array description#>
 @param bo <#bo description#>
 */
-(void)ChangeStates:(NSMutableArray *)array isYESorNO:(BOOL)bo
{
    for (int i = 0; i < array.count; i ++) {
        
        TZAssetModel * model1 = array[i];
        
        model1.m_isOriginalImage = bo;
        
        [array replaceObjectAtIndex:i withObject:model1];
    }
    
    
    
}

/**
 更新右上角照片选择个数
 */
-(void)updateChoosePhotoNumber
{
    if (self.m_chooseArray.count > 0) {
        self.m_ChooseNumberPhoto.hidden = NO;
        [self.m_ChooseNumberPhoto setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)self.m_chooseArray.count] forState:UIControlStateNormal];
        self.m_chooseNumberPhotoW.constant = 30;
    }else{
        self.m_ChooseNumberPhoto.hidden = YES;
        [self.m_ChooseNumberPhoto setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)self.m_chooseArray.count] forState:UIControlStateNormal];
        self.m_chooseNumberPhotoW.constant = 0;
        
        
    }
    
    
    
}

/**
 选择原图按钮
 */
- (IBAction)clcikSelectOriginalImage:(id)sender
{
    
    if (self.m_SelectDisplay.selected) {
        self.m_SelectDisplay.selected = NO;//改为不选中
        self.m_allNumberM.text = @"原图";//计数返回
        self.m_allNumberM.textColor = RGBAssistColor;//字体更改

         if (self.m_chooseArray.count>0) {
             [self ChangeStates:self.m_chooseArray isYESorNO:NO];
         }

    }else{
       
        [[TZImageManager manager] getPhotosBytesWithArray:self.m_chooseArray completion:^(NSString *totalBytes) {
              self.m_SelectDisplay.selected = YES;//改为选中
            self.m_allNumberM.text =[NSString stringWithFormat:@"原图（%@）",totalBytes];//计数返回
            self.m_allNumberM.textColor = RGBChatTextColor;
            if (self.m_chooseArray.count>0) {
                [self ChangeStates:self.m_chooseArray isYESorNO:YES];
            }
            
        }];
    }
    
    [self IsTouchPhoto];
    
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
