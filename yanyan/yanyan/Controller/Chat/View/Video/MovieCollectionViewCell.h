//
//  MovieCollectionViewCell.h
//  storm
//
//  Created by 高超 on 15/11/19.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *moviePhoto;
@property (weak, nonatomic) IBOutlet UILabel *time;
//@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *numberImage;
@property (weak, nonatomic) IBOutlet UIView *m_view;


@end
