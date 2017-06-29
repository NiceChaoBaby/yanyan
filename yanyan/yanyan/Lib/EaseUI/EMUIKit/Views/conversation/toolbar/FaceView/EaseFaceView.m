/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "EaseFaceView.h"

#import "EaseEmotionManager.h"
#import "UIImage+UIColor.h"
#define kButtomNum 5

@interface EaseFaceView ()<UIScrollViewDelegate>
{
    UIScrollView *_bottomScrollView;
    NSInteger _currentSelectIndex;
    NSArray *_emotionManagers;
    UIPageControl *_bottomPageView;
}

@property (nonatomic, strong) EaseFacialView *facialView;

@end

@implementation EaseFaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.facialView];
        [self _setupButtom];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview) {
        [self reloadEmotionData];
    }
}

#pragma mark - private

- (EaseFacialView*)facialView
{
    if (_facialView == nil) {
        _facialView = [[EaseFacialView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 140)];
        _facialView.delegate = self;
      
    }
    return _facialView;
}

- (void)_setupButtom
{
    _currentSelectIndex = 1000;
    _bottomPageView =[[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_facialView.frame), LCDW, 10)
                      ];
    _bottomPageView.numberOfPages = 4;
    _bottomPageView.currentPage = 0;
    [_bottomPageView addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    _bottomPageView.backgroundColor=[UIColor clearColor];
    [_bottomPageView setPageIndicatorTintColor:RGBAssistColor];
    [_bottomPageView setCurrentPageIndicatorTintColor:RGBAddAssistColor];
    [self addSubview:_bottomPageView];
    _bottomScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(_bottomPageView.frame), 4 * CGRectGetWidth(_facialView.frame)/5, self.frame.size.height - CGRectGetHeight(_facialView.frame)-10)];
//    _bottomScrollView.backgroundColor=[UIColor clearColor];
    _bottomScrollView.showsHorizontalScrollIndicator = NO;
    _bottomScrollView.delegate=self;
    [self addSubview:_bottomScrollView];

    
    
    [self _setupButtonScrollView];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake((kButtomNum-1)*CGRectGetWidth(_facialView.frame)/kButtomNum, CGRectGetMaxY(_bottomPageView.frame), CGRectGetWidth(_facialView.frame)/kButtomNum, CGRectGetHeight(_bottomScrollView.frame));
    [sendButton setBackgroundColor:[UIColor colorWithRed:30 / 255.0 green:167 / 255.0 blue:252 / 255.0 alpha:1.0]];
    [sendButton setTitle:NSEaseLocalizedString(@"send", @"Send") forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendFace) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendButton];
}

- (void)_setupButtonScrollView
{
    NSInteger number = [_emotionManagers count];
    if (number <= 1) {
        return;
    }
    
    for (UIView *view in [_bottomScrollView subviews]) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < number; i++) {
        UIButton *defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        defaultButton.frame = CGRectMake(i * CGRectGetWidth(_bottomScrollView.frame)/(kButtomNum-1), 0, CGRectGetWidth(_bottomScrollView.frame)/(kButtomNum-1), CGRectGetHeight(_bottomScrollView.frame));
        EaseEmotionManager *emotionManager = [_emotionManagers objectAtIndex:i];
        if (emotionManager.emotionType == EMEmotionDefault) {
//            EaseEmotion *emotion = [emotionManager.emotions objectAtIndex:0];
//            [defaultButton setTitle:emotion.emotionThumbnail forState:UIControlStateNormal];
            [defaultButton setImage:ImageNamed(@"emojilogo") forState:UIControlStateNormal];
             [defaultButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
            [defaultButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            defaultButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [defaultButton setSelected:YES];
            
        } else {
            [defaultButton setImage:ImageNamed(@"emojilogo2") forState:UIControlStateNormal];
            [defaultButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [defaultButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
            defaultButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
//        [defaultButton setBackgroundColor:[UIColor clearColor]];
//        defaultButton.layer.borderWidth = 0.5;
//        defaultButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [defaultButton addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];
        defaultButton.tag = 1000 + i;
        [_bottomScrollView addSubview:defaultButton];
    }
    [_bottomScrollView setContentSize:CGSizeMake(number*CGRectGetWidth(_bottomScrollView.frame)/(kButtomNum-1), CGRectGetHeight(_bottomScrollView.frame))];
    
    [self reloadEmotionData];
}

- (void)_clearupButtomScrollView
{
    for (UIView *view in [_bottomScrollView subviews]) {
        [view removeFromSuperview];
    }
}

#pragma mark - action

- (void)didSelect:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    UIButton *lastBtn = (UIButton*)[_bottomScrollView viewWithTag:_currentSelectIndex];
    lastBtn.selected = NO;
    
    _currentSelectIndex = btn.tag;
    btn.selected = YES;
    NSInteger index = btn.tag - 1000;
    [_facialView loadFacialViewWithPage:index];
    _bottomPageView.currentPage=0;
}

- (void)reloadEmotionData
{
    NSInteger index = _currentSelectIndex - 1000;
    if (index < [_emotionManagers count]) {
        [_facialView loadFacialView:_emotionManagers size:CGSizeMake(30, 30)];
    }
}

#pragma mark - FacialViewDelegate

-(void)selectedFacialView:(NSString*)str{
    if (_delegate) {
        [_delegate selectedFacialView:str isDelete:NO];
    }
}

-(void)deleteSelected:(NSString *)str{
    if (_delegate) {
        [_delegate selectedFacialView:str isDelete:YES];
    }
}

- (void)sendFace
{
    if (_delegate) {
        [_delegate sendFace];
    }
}

- (void)sendFace:(EaseEmotion *)emotion
{
    if (_delegate) {
        [_delegate sendFaceWithEmotion:emotion];
    }
}

#pragma mark - public

- (BOOL)stringIsFace:(NSString *)string
{
    if ([_facialView.faces containsObject:string]) {
        return YES;
    }
    
    return NO;
}

- (void)setEmotionManagers:(NSArray *)emotionManagers
{
    _emotionManagers = emotionManagers;
    for (EaseEmotionManager *emotionManager in _emotionManagers) {
        if (emotionManager.emotionType != EMEmotionGif) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:emotionManager.emotions];
            NSInteger maxRow = emotionManager.emotionRow;
            NSInteger maxCol = emotionManager.emotionCol;
            NSInteger count = 1;
            while (1) {
                NSInteger index = maxRow * maxCol * count - 1;
                if (index >= [array count]) {
                    [array addObject:@""];
                    break;
                } else {
                    [array insertObject:@"" atIndex:index];
                }
                count++;
            }
            emotionManager.emotions = array;
        }
    }
    [self _setupButtonScrollView];
}
#pragma mark -EaseFacialViewDelegate
-(void)easeFacialScrollViewOffset:(UIScrollView *)scroll
{
     int i=scroll.contentOffset.x/CGRectGetWidth(self.frame);
    if(i>3)
    {
         UIButton *lastBtn = (UIButton*)[_bottomScrollView viewWithTag:1001];
        
            [lastBtn setSelected:YES];
         _currentSelectIndex = lastBtn.tag;
        UIButton *lastBtn2 = (UIButton*)[_bottomScrollView viewWithTag:1000];
        
        [lastBtn2 setSelected:NO];
        
    }else
    {
        UIButton *lastBtn = (UIButton*)[_bottomScrollView viewWithTag:1000];
        [lastBtn setSelected:YES];
         _currentSelectIndex = lastBtn.tag;
        UIButton *lastBtn2 = (UIButton*)[_bottomScrollView viewWithTag:1001];
        
        [lastBtn2 setSelected:NO];
    }
    CGFloat width=scroll.frame.size.width;
    if (fmodf(scroll.contentOffset.x,width)==0) {
        NSInteger page= scroll.contentOffset.x/width;
        if(page>=4)
        {
            page-=4;
        }
        _bottomPageView.currentPage=page;
    }
}
-(void)changePage:(UIPageControl *)page
{
    
}
@end
