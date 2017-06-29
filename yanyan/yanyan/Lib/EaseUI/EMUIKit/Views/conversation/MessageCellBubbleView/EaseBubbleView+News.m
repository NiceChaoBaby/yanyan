//
//  EaseBubbleView+News.m
//  chat
//
//  Created by dong on 16/6/13.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "EaseBubbleView+News.h"

@implementation EaseBubbleView (News)
- (void)_setupNewsBubbleMarginConstraints
{
    [self.marginConstraints removeAllObjects];
    
    NSLayoutConstraint *marginTopConstraint = [NSLayoutConstraint constraintWithItem:self.m_newsBgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
    NSLayoutConstraint *marginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.m_newsBgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    NSLayoutConstraint *marginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.m_newsBgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    NSLayoutConstraint *marginRightConstraint = [NSLayoutConstraint constraintWithItem:self.m_newsBgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
    
    
    [self.marginConstraints addObject:marginTopConstraint];
    [self.marginConstraints addObject:marginBottomConstraint];
    [self.marginConstraints addObject:marginLeftConstraint];
    [self.marginConstraints addObject:marginRightConstraint];
    
   // [self addConstraints:self.marginConstraints];

  
    
     
    
    [self addConstraints:self.marginConstraints];
}

- (void)_setupNewsBubbleConstraints
{
    [self _setupNewsBubbleMarginConstraints];
    
    //icon view
    
    float height=10;
    
    //icon view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsIconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.m_newsBgView attribute:NSLayoutAttributeTop multiplier:1.0 constant:height]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsIconView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.m_newsBgView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:EaseMessageCellPadding/2]];

    
      [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsIconView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.m_newsBgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-height]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsIconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];
    
    
    
    
     //self.newsNameLabel
       [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsNameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.m_newsBgView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseMessageCellPadding]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsNameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.newsIconView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseMessageCellPadding]];
 
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsNameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.m_newsBgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-height]];
    

    //self.newsClickLabel
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsClickLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.m_newsBgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-height]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.newsClickLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.newsNameLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5]];
}

#pragma mark - public

- (void)setupNewsBubbleView
{
    
    
    self.m_newsBgView = [[UIView alloc] init];
    self.m_newsBgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.m_newsBgView.backgroundColor = [UIColor whiteColor];
    [self.backgroundImageView addSubview:self.m_newsBgView];
    [DTools getCorner:self.m_newsBgView radius:6];
    [DTools getBorder:self.m_newsBgView Width:0.5 andColor:RGBAssistColor.CGColor];
    
    self.newsIconView = [[UIImageView alloc] init];
    self.newsIconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.newsIconView.backgroundColor = [UIColor clearColor];
    self.newsIconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.m_newsBgView addSubview:self.newsIconView];
//     [DTools getCorner:self.newsIconView radius:5];
    self.newsNameLabel = [[UILabel alloc] init];
    self.newsNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.newsNameLabel.backgroundColor = [UIColor clearColor];
    [self.newsNameLabel sizeToFit];
    self.newsNameLabel.font=[UIFont systemFontOfSize:16];
    self.newsNameLabel.numberOfLines =0;//上面两行设置多行显示
    [self.m_newsBgView addSubview:self.newsNameLabel];
    
    self.newsClickLabel = [[UILabel alloc] init];
    self.newsClickLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.newsClickLabel.backgroundColor = [UIColor clearColor];
    self.newsClickLabel.text=@"点击查看";
    self.newsClickLabel.textColor=RGBAssistColor;
    self.newsClickLabel.font=[UIFont systemFontOfSize:14];
 
    [self.m_newsBgView addSubview:self.newsClickLabel];
    
    [self _setupNewsBubbleConstraints];
}

- (void)updateNewsMargin:(UIEdgeInsets)margin
{
    if (_margin.top == margin.top && _margin.bottom == margin.bottom && _margin.left == margin.left && _margin.right == margin.right) {
        return;
    }
    _margin = margin;
    
    [self removeConstraints:self.marginConstraints];
    [self _setupNewsBubbleMarginConstraints];
}

@end
