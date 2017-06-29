//
//  HotTVOneCommentsDetaTableViewCell.m
//  yanyan
//
//  Created by 高超 on 2017/6/29.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "HotTVOneCommentsDetaTableViewCell.h"
#import "HotTvCommentsCollectionViewCell.h"
@implementation HotTVOneCommentsDetaTableViewCell

/**
 用户头像
 */
-(UIImageView *)m_userPhoto
{
    if (!_m_userPhoto) {
        _m_userPhoto = [UIImageView new];
        _m_userPhoto.contentMode = UIViewContentModeScaleAspectFill;
        _m_userPhoto.clipsToBounds = YES;
        
    }
    
    return _m_userPhoto;
}


/**
 用户名
 */
-(UILabel *)m_userName
{
    if (!_m_userName) {
        _m_userName = [UILabel new];
    }
    
    return _m_userName;
}


/**
 发表时间
 */
-(UILabel *)m_time
{
    if (!_m_time) {
        _m_time = [UILabel new];
    }
    return _m_time;
}


/**
 评论
 */
-(UILabel *)m_commentLabel
{
    
    if (!_m_commentLabel) {
        
        _m_commentLabel = [UILabel new];
        _m_commentLabel.numberOfLines = 0;
    }
    
    return _m_commentLabel;
}

/**
 用户评论时加入的图片显示CollectionView
 */
-(UICollectionView *)m_collectionView
{
    if (!_m_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        //        layout.headerReferenceSize = CGSizeMake(self.contentView.frame.size.width, 100);
        //该方法也可以设置itemSize
        //        layout.itemSize =CGSizeMake(110, 150);
        
        //2.初始化collectionView
        _m_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LCDW, RW(460)) collectionViewLayout:layout];
        _m_collectionView.backgroundColor = [UIColor clearColor];
        
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_m_collectionView registerClass:[HotTvCommentsCollectionViewCell class] forCellWithReuseIdentifier:@"HotTvCommentsCollectionViewCell"];
        
        //4.设置代理
        _m_collectionView.delegate = self;
        _m_collectionView.dataSource = self;
        _m_collectionView.scrollEnabled = NO;
    }
    return _m_collectionView;
}

/*********************所评论电影信息View*****************************/

/**
 电影信息View
 */
-(UIView *)m_movieDataView
{
    if (!_m_movieDataView) {
        _m_movieDataView = [UIView new];
        _m_movieDataView.backgroundColor = RGBBgColor;
    }
    return _m_movieDataView;
}

/**
 电影名称
 */
-(UILabel *)m_MovieNameLabel
{
    if (!_m_MovieNameLabel) {
        _m_MovieNameLabel = [UILabel new];
        _m_MovieNameLabel.font = [UIFont systemFamilyFontOfSizeNoScale:16.0f];
        _m_MovieNameLabel.textColor = RGBAddAssistColor;
    }
    
    
    return _m_MovieNameLabel;
}

/**
 电影演员介绍
 */
-(UILabel *)m_movieDataLabel
{
    if (!_m_movieDataLabel) {
        _m_movieDataLabel= [UILabel new];
        _m_movieDataLabel.font = [UIFont systemFamilyFontOfSizeNoScale:14.0f];
        _m_movieDataLabel.textColor = RGBAddAssistColor;
    }
    
    return _m_movieDataLabel;
}
/**
 电影图片
 */
-(UIImageView *)m_moviePhoto
{
    if (!_m_moviePhoto) {
        
        _m_moviePhoto = [UIImageView new];
        _m_moviePhoto.contentMode = UIViewContentModeScaleAspectFill;
        _m_moviePhoto.clipsToBounds = YES;
        
    }
    
    return _m_moviePhoto;
}


/*******************底部工具栏  赞  评论    分享************************/

/**
 底部按钮View
 */
-(UIView *)m_downView
{
    if (!_m_downView) {
        _m_downView = [UIView new];
    }
    
    return _m_downView;
    
}
/**
 点赞按钮
 */
-(UIButton *)m_greatBtn
{
    if (!_m_greatBtn) {
        _m_greatBtn = [UIButton new];
    }
    
    return _m_greatBtn;
}

/**
 评论按钮
 */
-(UIButton *)m_commentBtn
{
    if (!_m_commentBtn) {
        _m_commentBtn = [UIButton new];
    }
    return _m_commentBtn;
}


/**
 分享
 */
-(UIButton *)m_shareBtn
{
    if (!_m_shareBtn) {
        _m_shareBtn = [UIButton new];
    }
    
    return _m_shareBtn;
    
}


/**
 用户评论所加入的图片
 */
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _imageArray;
}


// 重写构造方法 -- 只调用一次嘛 （套路来的！务必记住！）
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.m_movieDataView sd_addSubviews:@[self.m_MovieNameLabel,self.m_movieDataLabel,self.m_moviePhoto]];
        [self.m_downView sd_addSubviews:@[self.m_greatBtn,self.m_commentBtn]];
        [self.contentView sd_addSubviews:@[self.m_userPhoto,self.m_userName,self.m_time,self.m_commentLabel,self.m_collectionView,self.m_movieDataView,self.m_downView]];
        
        /**
         用户头像
         */
        self.m_userPhoto.sd_layout
        .leftSpaceToView(self.contentView, RW(30))
        .topSpaceToView(self.contentView, RW(30))
        .widthIs(RW(100))
        .heightIs(RW(100));
        
        /**
         用户名
         */
        self.m_userName.sd_layout
        .leftSpaceToView(self.m_userPhoto, RW(30))
        .topSpaceToView(self.contentView, RW(34))
        .rightSpaceToView(self.contentView, RW(30))
        .autoHeightRatio(0);
        
        /**
         发表时间
         */
        self.m_time.sd_layout
        .leftSpaceToView(self.m_userPhoto, RW(30))
        .topSpaceToView(self.m_userName, RW(10))
        .rightSpaceToView(self.contentView, RW(30))
        .autoHeightRatio(0);
        
        /**
         评论
         */
        self.m_commentLabel.sd_layout
        .leftSpaceToView(self.contentView, RW(30))
        .rightSpaceToView(self.contentView, RW(30))
        .topSpaceToView(self.m_time, RW(20))
        .autoHeightRatio(0);
        
        //用户添加的图片现在只有一张  先用Collection做 后期怕加图
        self.m_collectionView.sd_layout
        .topSpaceToView(self.m_commentLabel, RW(20))
        .leftSpaceToView(self.contentView, RW(30))
        .rightSpaceToView(self.contentView, RW(30))
        .heightIs(RW(460));
        
        
        /**
         电影信息View
         */
        self.m_movieDataView.sd_layout
        .leftSpaceToView(self.contentView, RW(30))
        .rightSpaceToView(self.contentView, RW(30))
        .topSpaceToView(self.m_collectionView, RW(20))
        //        .minHeightIs(RW(400))
        .autoHeightRatio(0);
        
        /**
         电影图片
         */
        self.m_moviePhoto.sd_layout
        .rightSpaceToView(self.m_movieDataView, RW(10))
        .topSpaceToView(self.m_movieDataView, RW(10))
        .bottomSpaceToView(self.m_movieDataView, RW(10))
        .widthIs(RW(100))
        ;
        
        /**
         电影名称
         */
        self.m_MovieNameLabel.sd_layout
        .leftSpaceToView(self.m_movieDataView, RW(10))
        .rightSpaceToView(self.m_moviePhoto, RW(10))
        .topSpaceToView(self.m_movieDataView, RW(10))
        .autoHeightRatio(0);
        
        /**
         电影演员介绍
         */
        self.m_movieDataLabel.sd_layout
        .leftSpaceToView(self.m_movieDataView, RW(10))
        .rightSpaceToView(self.m_moviePhoto, RW(10))
        .topSpaceToView(self.m_MovieNameLabel, RW(10))
        .autoHeightRatio(0);
        
        [self.m_movieDataView setupAutoHeightWithBottomView:self.m_movieDataLabel bottomMargin:RW(10)];
        
        //底部操作栏
        self.m_downView.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.m_movieDataView, RW(20))
        .heightIs(RW(100));
        
        
        //评论
        self.m_commentBtn.sd_layout
        .rightSpaceToView(self.m_downView, RW(40))
        .topSpaceToView(self.m_downView, 0)
        .heightIs(RW(100))
        .widthIs(RW(100));
        
        //点赞
        self.m_greatBtn.sd_layout
        .rightSpaceToView(self.m_commentBtn, 10)
        .topSpaceToView(self.m_downView, 0)
        .widthIs(RW(100))
        .heightIs(RW(100));
        
        //        [self.m_view setupAutoHeightWithBottomView:self.m_downView bottomMargin:0];
        [self setupAutoHeightWithBottomView:self.m_downView bottomMargin:0];
        
    }
    
    return self;
}


-(void)setM_hotCommentM:(HotCommentM *)m_hotCommentM
{
    
    //用户头像
    [self.m_userPhoto sd_setImageWithURL:[NSURL URLWithString:m_hotCommentM.m_userPhoto] placeholderImage:ImageNamed(@"")];
    //圆角
    self.m_userPhoto.layer.cornerRadius = (RW(100)/2);
    self.m_userPhoto.layer.masksToBounds = YES;
    //用户名
    self.m_userName.text = m_hotCommentM.m_userNmae;
    //用户评论时间
    self.m_time.text = m_hotCommentM.m_CommentTime;
    //用户评论内容
    self.m_commentLabel.text = m_hotCommentM.m_commentsContent;
    //用户点赞数
    [self.m_greatBtn setTitle:m_hotCommentM.m_ThumbUpCount forState:UIControlStateNormal];
    self.m_greatBtn.backgroundColor = [UIColor redColor];
    self.m_commentBtn.backgroundColor = [UIColor blueColor];
    //用户评论的电影名称
    self.m_MovieNameLabel.text = m_hotCommentM.m_moviewName;
    //用户评论的电影人员介绍
    self.m_movieDataLabel.text = m_hotCommentM.m_moviewData;
    //用户评论的电影封面图
    [self.m_moviePhoto sd_setImageWithURL:[NSURL URLWithString:m_hotCommentM.m_moviewImage]];
    //将用户评论时加入的图片 放到显示图片数组
    [self.imageArray addObject:m_hotCommentM.m_commentsImage];
    [self.m_collectionView reloadData];
}


#pragma mark - UIcollectionViewDelegate

//定义展示的UIcollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
    
    
    return self.imageArray.count;
}

//定义展示的Section的个数

-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView

{
    
    return 1  ;
    
}

//每个UICollectionView展示的内容

-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
    HotTvCommentsCollectionViewCell *cell = (HotTvCommentsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HotTvCommentsCollectionViewCell" forIndexPath:indexPath];
    
    [cell.m_imageView sd_setImageWithURL:[NSURL URLWithString:@"http://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F22%2F72%2F62%2F57c7ad7ba739a_1024.jpg&thumburl=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D4153768048%2C2702237%26fm%3D26%26gp%3D0.jpg"] placeholderImage:ImageNamed(@"")];
    //    [cell.m_imageView setImage:ImageNamed(@"1111aaaa.jpg")];
    
    cell.backgroundColor = [UIColor yellowColor];
    cell.m_imageView.backgroundColor = [UIColor redColor];
    return cell;
}

//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    
    
}
//定义每个UICollectionView 的大小

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    //    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    //    CGFloat length = [self.m_data[indexPath.row] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    return CGSizeMake(RW(344) , RW(460));
    
    
}

//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake(0,0,0,0);
    
    
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
