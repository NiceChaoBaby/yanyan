//
//  EaseBubbleView+Share.m
//  chat
//
//  Created by dong on 16/4/27.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "EaseBubbleView+Share.h"

@implementation EaseBubbleView (Share)
#pragma mark - private

- (void)_setupShareBubbleMarginConstraints
{
    
    
     [self.marginConstraints removeAllObjects];
    
    //name label
    NSLayoutConstraint *contentWithMarginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.m_contentLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.margin.bottom];
    NSLayoutConstraint *contentWithMarginRightConstraint = [NSLayoutConstraint constraintWithItem:self.m_contentLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    
     NSLayoutConstraint *contentWithMarginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.m_contentLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
    NSLayoutConstraint *contentWithMarginHeightConstraint = [NSLayoutConstraint constraintWithItem:self.m_contentLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:self.m_descLabelHeight];
    
    
    [self.marginConstraints addObject:contentWithMarginBottomConstraint];
    [self.marginConstraints addObject:contentWithMarginRightConstraint];
    [self.marginConstraints addObject:contentWithMarginLeftConstraint];
    [self.marginConstraints addObject:contentWithMarginHeightConstraint];
    
    
    NSLayoutConstraint *marginTopConstraint = [NSLayoutConstraint constraintWithItem:self.m_bgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.margin.top];
    NSLayoutConstraint *marginBottomConstraint = [NSLayoutConstraint constraintWithItem:self.m_bgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.m_contentLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:-self.margin.bottom/4];
    NSLayoutConstraint *marginLeftConstraint = [NSLayoutConstraint constraintWithItem:self.m_bgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.margin.right];
    NSLayoutConstraint *marginRightConstraint = [NSLayoutConstraint constraintWithItem:self.m_bgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.margin.left];
    
   
    [self.marginConstraints addObject:marginTopConstraint];
    [self.marginConstraints addObject:marginBottomConstraint];
    [self.marginConstraints addObject:marginLeftConstraint];
    [self.marginConstraints addObject:marginRightConstraint];
    
    [self addConstraints:self.marginConstraints];
    
   }

- (void)_setupShareBubbleConstraints
{
    [self _setupShareBubbleMarginConstraints];
    
    //icon view
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_avatarImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.m_bgView attribute:NSLayoutAttributeTop multiplier:1.0 constant:9]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_avatarImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.m_bgView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:EaseMessageCellPadding/2]];
//     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_avatarImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.m_bgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.m_avatarImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:60]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.m_avatarImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseMessageCellPadding/2]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.m_bgView attribute:NSLayoutAttributeTop multiplier:1.0 constant:EaseMessageCellPadding]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.m_bgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-EaseMessageCellPadding/2]];
//     [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.m_bgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:EaseMessageCellPadding]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_descLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.m_titleLabel attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_descLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.m_titleLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.m_descLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.m_titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:2]];
}

#pragma mark - public

- (void)setupShareBubbleView
{
    
    self.m_bgView = [[UIView alloc] init];
    self.m_bgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.m_bgView.backgroundColor = [UIColor whiteColor];
    [self.backgroundImageView addSubview:self.m_bgView];
    [DTools getCorner:self.m_bgView radius:6];
    [DTools getBorder:self.m_bgView Width:0.5 andColor:RGBAssistColor.CGColor];
    
    self.m_avatarImageView = [[UIImageView alloc] init];
    self.m_avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.m_avatarImageView.backgroundColor = [UIColor clearColor];
    self.m_avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    [self.m_bgView addSubview:self.m_avatarImageView];
    
    self.m_titleLabel = [[UILabel alloc] init];
    self.m_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.m_titleLabel.backgroundColor = [UIColor clearColor];
    self.m_titleLabel.font=[UIFont systemFontOfSize:16];
    self.m_titleLabel.textColor=RGBAddAssistColor;
    self.m_titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.m_titleLabel.numberOfLines =2;//上面两行设置多行显示
    [self.m_bgView addSubview:self.m_titleLabel];
    
    self.m_descLabel = [[UILabel alloc] init];
    self.m_descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.m_descLabel.backgroundColor = [UIColor clearColor];
    self.m_descLabel.font=[UIFont systemFontOfSize:13];
    self.m_descLabel.textColor=RGBAssistColor;
    self.m_descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.m_descLabel.numberOfLines =2;//上面两行设置多行显示
    [self.m_bgView addSubview:self.m_descLabel];
    
    
    
    self.m_contentLabel = [[UILabel alloc] init];
    self.m_contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.m_contentLabel.backgroundColor = [UIColor clearColor];
    self.m_contentLabel.font=[UIFont systemFontOfSize:16];
    self.m_contentLabel.textColor=RGBAddAssistColor;
    self.m_contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.m_contentLabel.numberOfLines =0;//上面两行设置多行显示
    [self.backgroundImageView addSubview:self.m_contentLabel];
    
    [self _setupShareBubbleConstraints];
}

- (void)updateShareMargin:(UIEdgeInsets)margin
{
    if (_margin.top == margin.top && _margin.bottom == margin.bottom && _margin.left == margin.left && _margin.right == margin.right) {
        return;
    }
    _margin = margin;
    
    [self removeConstraints:self.marginConstraints];
    
    
    [self _setupShareBubbleMarginConstraints];
}

@end
