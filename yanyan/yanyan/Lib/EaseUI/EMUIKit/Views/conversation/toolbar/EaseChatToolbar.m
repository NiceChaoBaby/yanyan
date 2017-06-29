//
//  EMChatToolbar.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/7/1.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseChatToolbar.h"

#import "EaseFaceView.h"
#import "EaseEmoji.h"
#import "EaseEmotionEscape.h"
#import "EaseEmotionManager.h"
#import "GCFlowLayout.h"
#import "GCCollectionViewCell.h"
#import "ChatMemberListModel.h"
@interface EaseChatToolbar()<UITextViewDelegate, EMFaceDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic) CGFloat version;

@property (strong, nonatomic) NSMutableArray *leftItems;
@property (strong, nonatomic) NSMutableArray *rightItems;

/**
 *  背景
 */
@property (strong, nonatomic) UIImageView *toolbarBackgroundImageView;
@property (strong, nonatomic) UIImageView *backgroundImageView;

/**
 *  底部扩展页面
 */
@property (nonatomic) BOOL isShowButtomView;
@property (strong, nonatomic) UIView *activityButtomView;//当前活跃的底部扩展页面

/**
 *  按钮、toolbarView
 */
@property (strong, nonatomic) UIView *toolbarView;

@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIButton *faceButton;
/**
 *  人物头像
 */
@property (nonatomic,strong) UIButton * m_NmuberBtn;//人数显示
@property (nonatomic,strong) GCFlowLayout * m_layout;//布局
@property (nonatomic,strong) UICollectionView * m_collectionView;//人物头像滚动

/**
 *  输入框
 */
@property (nonatomic) CGFloat previousTextViewContentHeight;//上一次inputTextView的contentSize.height
@property (nonatomic) NSLayoutConstraint *inputViewWidthItemsLeftConstraint;
@property (nonatomic) NSLayoutConstraint *inputViewWidthoutItemsLeftConstraint;

@end

@implementation EaseChatToolbar

@synthesize faceView = _faceView;
@synthesize moreView = _moreView;
@synthesize recordView = _recordView;
@synthesize recordHandleView = _recordHandleView;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame horizontalPadding:8 verticalPadding:5 inputViewMinHeight:36 inputViewMaxHeight:150 type:EMConversationTypeGroupChat];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                         type:(EMConversationType)type
{
    self = [self initWithFrame:frame horizontalPadding:8 verticalPadding:5 inputViewMinHeight:36 inputViewMaxHeight:150 type:type];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
            horizontalPadding:(CGFloat)horizontalPadding
              verticalPadding:(CGFloat)verticalPadding
           inputViewMinHeight:(CGFloat)inputViewMinHeight
           inputViewMaxHeight:(CGFloat)inputViewMaxHeight
                         type:(EMConversationType)type
{
    if (frame.size.height < (verticalPadding * 2 + inputViewMinHeight)) {
        frame.size.height = verticalPadding * 2 + inputViewMinHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
      
        _horizontalPadding = horizontalPadding;
        _verticalPadding = verticalPadding;
        _inputViewMinHeight = inputViewMinHeight;
        _inputViewMaxHeight = inputViewMaxHeight;
        _chatBarType = type;
        if(type==EMConversationTypeChatRoom){
            self.m_isChatRoom=YES;
        }else
        {
            self.m_isChatRoom=NO;
        }
        
        _leftItems = [NSMutableArray array];
        _rightItems = [NSMutableArray array];
        _version = [[[UIDevice currentDevice] systemVersion] floatValue];
        _activityButtomView = nil;
        _isShowButtomView = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [self _setupSubviews];
    }
    return self;
}

#pragma mark - setup subviews

- (void)_setupSubviews
{
    CGRect ret;
     if (self.m_isChatRoom) {
      ret = CGRectMake(0,44, LCDW, 46);
     }else{
         ret = self.bounds;
     }
    self.backgroundColor = [UIColor clearColor];
    //backgroundImageView
    _backgroundImageView = [[UIImageView alloc] initWithFrame:ret];
    _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _backgroundImageView.backgroundColor = [UIColor clearColor];
    _backgroundImageView.image = [[UIImage imageNamed:@"EaseUIResource.bundle/messageToolbarBg"] stretchableImageWithLeftCapWidth:0.5 topCapHeight:10];
    [self addSubview:_backgroundImageView];
    
    //toolbar
    _toolbarView = [[UIView alloc] initWithFrame:ret];
    _toolbarView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_toolbarView];
    
    _toolbarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _toolbarView.frame.size.width, _toolbarView.frame.size.height)];
    _toolbarBackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _toolbarBackgroundImageView.backgroundColor = [UIColor clearColor];
    [_toolbarView addSubview:_toolbarBackgroundImageView];
    UIImageView * imagelent = [[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMinX(_toolbarBackgroundImageView.frame), LCDW, 1)];
    imagelent.backgroundColor = RGBTopLineColor;
    [_toolbarView addSubview:imagelent];

    //输入框
    _inputTextView = [[EaseTextView alloc] initWithFrame:CGRectMake(self.horizontalPadding, self.verticalPadding+1, self.frame.size.width - self.verticalPadding * 2, self.frame.size.height - self.verticalPadding * 2-1)];
    _inputTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _inputTextView.scrollEnabled = YES;
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.enablesReturnKeyAutomatically = YES; // UITextView内部判断send按钮是否可以用
    _inputTextView.placeHolder = @"输入聊天内容";
    _inputTextView.delegate = self;
    _inputTextView.backgroundColor = [UIColor clearColor];
//    _inputTextView.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
//    _inputTextView.layer.borderWidth = 0.65f;
//    _inputTextView.layer.cornerRadius = 6.0f;
    _previousTextViewContentHeight = [self _getTextViewContentH:_inputTextView];
    [_toolbarView addSubview:_inputTextView];
    
    
     if (self.m_isChatRoom) {
    
    /**
     头像列表背景
     */
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LCDW, 44)];
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    
    self.m_NmuberBtn = [[UIButton alloc]initWithFrame:CGRectMake(9, 4, 36, 34)];
    self.m_NmuberBtn.backgroundColor = [UIColor clearColor];
    [self.m_NmuberBtn setTitleColor:RGBAddAssistColor forState:UIControlStateNormal];
    [self.m_NmuberBtn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [DTools getCorner:self.m_NmuberBtn radius:17];
         UIImageView * image = [[UIImageView alloc]initWithFrame:self.m_NmuberBtn.frame];
         [image setImage:ImageNamed(@"rectangle")];
         [bgView addSubview:image];
         
//    //设置边框
    self.m_NmuberBtn.titleLabel.font = [UIFont systemFontOfSize:20];
//    [self.m_NmuberBtn.layer setBorderColor:RGBAssistColor.CGColor];
//    [self.m_NmuberBtn.layer setBorderWidth:1];
//    [self.m_NmuberBtn.layer setMasksToBounds:YES];
//    [self.m_NmuberBtn setImage:ImageNamed(@"rectangle") forState:UIControlStateNormal];
    [bgView addSubview:self.m_NmuberBtn];
    
    
    /**
     人头像列表
     */
    self.m_layout = [[GCFlowLayout alloc]init];
    self.m_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.m_NmuberBtn.frame) + 10, 0, LCDW - (CGRectGetMaxX(self.m_NmuberBtn.frame) + 10), 44) collectionViewLayout:_m_layout];
    self.m_collectionView.backgroundColor = [UIColor clearColor];
    [self.m_collectionView setDelegate:self];
    [self.m_collectionView setDataSource:self];

    [bgView addSubview:self.m_collectionView];
    
//         UIImageView * imagelent = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(bgView.frame), CGRectGetMaxY(bgView.frame)-1, LCDW, 1)];
//         imagelent.backgroundColor = RGBTopLineColor;
//         [bgView addSubview:imagelent];
//         UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.m_NmuberBtn.frame), 0, 10, 44)];
//         image.backgroundColor = [UIColor whiteColor];
//         image.alpha = 0.5;
//         [bgView addSubview:image];
         
         
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDataPhoto) name:K_PEOPLEPHOTORELOATDATA object:nil];
    //当点击了新消息改变collection fream
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFreamAll) name:K_CHANGEFREAMALL object:nil];
    //有新消息改变collection fream
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFreamNoAll) name:K_CHANGEFREAMNOALL object:nil];
    
         
     }
    
    //转变输入样式
    UIButton *styleChangeButton = [[UIButton alloc] init];
    styleChangeButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [styleChangeButton setImage:[UIImage imageNamed:@"chatroom_voice"] forState:UIControlStateNormal];
    [styleChangeButton setImage:[UIImage imageNamed:@"chatroom_keyboard"] forState:UIControlStateSelected];
    [styleChangeButton addTarget:self action:@selector(styleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    EaseChatToolbarItem *styleItem = [[EaseChatToolbarItem alloc] initWithButton:styleChangeButton withView:self.recordHandleView];
    [self setInputViewLeftItems:@[styleItem]];
    
    //录制
  //  self.recordHandleView.m_recordButton = [[UIButton alloc] initWithFrame:self.inputTextView.frame];
   self.recordHandleView.m_recordButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.recordHandleView.m_recordButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.recordHandleView.m_recordButton setBackgroundImage:ImageNamed(@"chatroom_speak")  forState:UIControlStateNormal];
    [self.recordHandleView.m_recordButton setBackgroundImage:ImageNamed(@"chatroom_speak")  forState:UIControlStateHighlighted];
//    [self.recordHandleView.m_recordButton setTitle:kTouchToRecord forState:UIControlStateNormal];
//    [self.recordHandleView.m_recordButton setTitle:kTouchToFinish forState:UIControlStateHighlighted];
    self.recordHandleView.m_recordButton.hidden = YES;
    self.recordHandleView.m_recordButton.isIgnore=YES;
    
//    UIControlEventTouchDown
//    单点触摸按下事件：用户点触屏幕，或者又有新手指落下的时候。
    [self.recordHandleView.m_recordButton addTarget:self action:@selector(recordButtonTouchDown) forControlEvents:UIControlEventTouchDown];

    //    UIControlEventTouchDragOutside
//    当一次触摸在控件窗口之外拖动时。
    [self.recordHandleView.m_recordButton addTarget:self action:@selector(recordButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    
//    UIControlEventTouchDragInside
//    当一次触摸在控件窗口内拖动时。
    [self.recordHandleView.m_recordButton addTarget:self action:@selector(recordButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    //    UIControlEventTouchDragExit
    //    当一次触摸从控件窗口内部拖动到外部时。
    [self.recordHandleView.m_recordButton addTarget:self action:@selector(recordDragOutside) forControlEvents:UIControlEventTouchDragExit];

    //    UIControlEventTouchDragEnter
//    当一次触摸从控件窗口之外拖动到内部时。
    [self.recordHandleView.m_recordButton addTarget:self action:@selector(recordDragInside) forControlEvents:UIControlEventTouchDragEnter];
    //    UIControlEventTouchDragInside
    //    当一次触摸在控件窗口内拖动时。UIControlEventTouchCancel
    [self.recordHandleView.m_recordButton addTarget:self action:@selector(recordButtonTouchCancel) forControlEvents:UIControlEventTouchCancel];
    self.recordHandleView.m_recordButton.hidden = NO;
   // [self.toolbarView addSubview:self.recordButton];
    
    //表情
    self.faceButton = [[UIButton alloc] init];
    self.faceButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.faceButton setImage:[UIImage imageNamed:@"chatroom_emoticons"] forState:UIControlStateNormal];
    [self.faceButton setImage:[UIImage imageNamed:@"chatroom_emoticons"] forState:UIControlStateHighlighted];
    [self.faceButton setImage:[UIImage imageNamed:@"chatroom_keyboard"] forState:UIControlStateSelected];
    [self.faceButton addTarget:self action:@selector(faceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    EaseChatToolbarItem *faceItem = [[EaseChatToolbarItem alloc] initWithButton:self.faceButton withView:self.faceView];
    
    //更多
    self.moreButton = [[UIButton alloc] init];
    self.moreButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.moreButton setImage:[UIImage imageNamed:@"chatroom_more"] forState:UIControlStateNormal];
    [self.moreButton setImage:[UIImage imageNamed:@"chatroom_more"] forState:UIControlStateHighlighted];
    [self.moreButton setImage:[UIImage imageNamed:@"chatroom_keyboard"] forState:UIControlStateSelected];
    [self.moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    EaseChatToolbarItem *moreItem = [[EaseChatToolbarItem alloc] initWithButton:self.moreButton withView:self.moreView];
    
    [self setInputViewRightItems:@[faceItem, moreItem]];
    
    
    
   
  
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _delegate = nil;
    _inputTextView.delegate = nil;
    _inputTextView = nil;
}

#pragma mark - getter

- (UIView *)recordView
{
    if (_recordView == nil) {
        _recordView = [[EaseRecordView alloc] initWithFrame:CGRectMake(90, 130, 140, 140)];
    }
    
    return _recordView;
}

- (UIView *)faceView
{
    if (_faceView == nil) {
        _faceView = [[EaseFaceView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_toolbarView.frame), self.frame.size.width, 180)];
        [(EaseFaceView *)_faceView setDelegate:self];
        _faceView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0];
        _faceView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _faceView;
}

- (UIView *)moreView
{
    if (_moreView == nil) {
        _moreView = [[EaseChatBarMoreView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_toolbarView.frame), self.frame.size.width, 80) type:self.chatBarType];
        _moreView.backgroundColor =RGBBgColor;
        _moreView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _moreView;
}
- (UIView *)recordHandleView
{
    if (_recordHandleView == nil) {
        _recordHandleView = [[EaseRecordHandleView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_toolbarView.frame), self.frame.size.width, 80)];
        _recordHandleView.backgroundColor = RGBBgColor;
        _recordHandleView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    
    return _recordHandleView;
}

#pragma mark - setter

- (void)setDelegate:(id<EMChatToolbarDelegate>)delegate
{
    _delegate = delegate;
    if ([_moreView isKindOfClass:[EaseChatBarMoreView class]]) {
        [(EaseChatBarMoreView *)_moreView setDelegate:delegate];
    }
}

- (void)setRecordView:(UIView *)recordView
{
    if(_recordView != recordView){
        _recordView = recordView;
    }
}

- (void)setMoreView:(UIView *)moreView
{
    if (_moreView != moreView) {
        _moreView = moreView;
        
        for (EaseChatToolbarItem *item in self.rightItems) {
            if (item.button == self.moreButton) {
                item.button2View = _moreView;
                break;
            }
        }
    }
}

- (void)setFaceView:(UIView *)faceView
{
    if (_faceView != faceView) {
        _faceView = faceView;
        
        for (EaseChatToolbarItem *item in self.rightItems) {
            if (item.button == self.faceButton) {
                item.button2View = _faceView;
                break;
            }
        }
    }
}
- (void)setRecordHandleView:(EaseRecordHandleView *)recordHandleView
{
    if (_recordHandleView != recordHandleView) {
        _recordHandleView = recordHandleView;
        
        for (EaseChatToolbarItem *item in self.leftItems) {
            if (item.button == self.recordHandleView.m_recordButton) {
                item.button2View = _recordHandleView;
                break;
            }
        }
    }
}
- (NSArray*)inputViewLeftItems
{
    return self.leftItems;
}

- (void)setInputViewLeftItems:(NSArray *)inputViewLeftItems
{
    for (EaseChatToolbarItem *item in self.leftItems) {
        [item.button removeFromSuperview];
        [item.button2View removeFromSuperview];
    }
    [self.leftItems removeAllObjects];
    
    CGFloat oX = self.horizontalPadding;
    CGFloat itemHeight = self.toolbarView.frame.size.height - self.verticalPadding * 2;
    for (id item in inputViewLeftItems) {
        if ([item isKindOfClass:[EaseChatToolbarItem class]]) {
            EaseChatToolbarItem *chatItem = (EaseChatToolbarItem *)item;
            if (chatItem.button) {
                CGRect itemFrame = chatItem.button.frame;
                if (itemFrame.size.height == 0) {
                    itemFrame.size.height = itemHeight;
                }
                
                if (itemFrame.size.width == 0) {
                    itemFrame.size.width = itemFrame.size.height;
                }
                
                itemFrame.origin.x = oX;
                itemFrame.origin.y = (self.toolbarView.frame.size.height - itemFrame.size.height) / 2;
                chatItem.button.frame = itemFrame;
                oX += (itemFrame.size.width + self.horizontalPadding);
                
                [self.toolbarView addSubview:chatItem.button];
                [self.leftItems addObject:item];
            }
        }
    }
    
    CGRect inputFrame = self.inputTextView.frame;
    CGFloat value = inputFrame.origin.x - oX;
    inputFrame.origin.x = oX;
    inputFrame.size.width += value;
    self.inputTextView.frame = inputFrame;
    
//    CGRect recordFrame = self.recordButton.frame;
//    recordFrame.origin.x = inputFrame.origin.x;
//    recordFrame.size.width = inputFrame.size.width;
//    self.recordButton.frame = recordFrame;
}

- (NSArray*)inputViewRightItems
{
    return self.rightItems;
}

- (void)setInputViewRightItems:(NSArray *)inputViewRightItems
{
    for (EaseChatToolbarItem *item in self.rightItems) {
        [item.button removeFromSuperview];
        [item.button2View removeFromSuperview];
    }
    [self.rightItems removeAllObjects];
    
    CGFloat oMaxX = self.toolbarView.frame.size.width - self.horizontalPadding;
    CGFloat itemHeight = self.toolbarView.frame.size.height - self.verticalPadding * 2;
    if ([inputViewRightItems count] > 0) {
        for (NSInteger i = (inputViewRightItems.count - 1); i >= 0; i--) {
            id item = [inputViewRightItems objectAtIndex:i];
            if ([item isKindOfClass:[EaseChatToolbarItem class]]) {
                EaseChatToolbarItem *chatItem = (EaseChatToolbarItem *)item;
                if (chatItem.button) {
                    CGRect itemFrame = chatItem.button.frame;
                    if (itemFrame.size.height == 0) {
                        itemFrame.size.height = itemHeight;
                    }
                    
                    if (itemFrame.size.width == 0) {
                        itemFrame.size.width = itemFrame.size.height;
                    }
                    
                    oMaxX -= itemFrame.size.width;
                    itemFrame.origin.x = oMaxX;
                    itemFrame.origin.y = (self.toolbarView.frame.size.height - itemFrame.size.height) / 2;
                    chatItem.button.frame = itemFrame;
                    oMaxX -= self.horizontalPadding;
                    
                    [self.toolbarView addSubview:chatItem.button];
                    [self.rightItems addObject:item];
                }
            }
        }
    }
    
    CGRect inputFrame = self.inputTextView.frame;
    CGFloat value = oMaxX - CGRectGetMaxX(inputFrame);
    inputFrame.size.width += value;
    self.inputTextView.frame = inputFrame;
    
//    CGRect recordFrame = self.recordButton.frame;
//    recordFrame.origin.x = inputFrame.origin.x;
//    recordFrame.size.width = inputFrame.size.width;
//    self.recordButton.frame = recordFrame;
}

#pragma mark - private input view

- (CGFloat)_getTextViewContentH:(UITextView *)textView
{
    if (self.version >= 7.0)
    {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    } else {
        return textView.contentSize.height;
    }
}

- (void)_willShowInputTextViewToHeight:(CGFloat)toHeight
{
    if (toHeight < self.inputViewMinHeight) {
        toHeight = self.inputViewMinHeight;
    }
    if (toHeight > self.inputViewMaxHeight) {
        toHeight = self.inputViewMaxHeight;
    }
    
    if (toHeight == _previousTextViewContentHeight)
    {
        return;
    }
    else{
        CGFloat changeHeight = toHeight - _previousTextViewContentHeight;
        
        CGRect rect = self.frame;
        rect.size.height += changeHeight;
        rect.origin.y -= changeHeight;
        self.frame = rect;
        
        rect = self.toolbarView.frame;
        rect.size.height += changeHeight;
        self.toolbarView.frame = rect;
        
        if (self.version < 7.0) {
            [self.inputTextView setContentOffset:CGPointMake(0.0f, (self.inputTextView.contentSize.height - self.inputTextView.frame.size.height) / 2) animated:YES];
        }
        _previousTextViewContentHeight = toHeight;
        
        if (_delegate && [_delegate respondsToSelector:@selector(chatToolbarDidChangeFrameToHeight:)]) {
            [_delegate chatToolbarDidChangeFrameToHeight:self.frame.size.height];
        }
    }
}

#pragma mark - private bottom view

- (void)_willShowBottomHeight:(CGFloat)bottomHeight
{
    CGRect fromFrame = self.frame;
    CGFloat toHeight;
    if (self.m_isChatRoom) {
        
    toHeight = self.toolbarView.frame.size.height + bottomHeight +44;
    }else{
        toHeight = self.toolbarView.frame.size.height + bottomHeight;
    }
    CGRect toFrame = CGRectMake(fromFrame.origin.x, fromFrame.origin.y + (fromFrame.size.height - toHeight), fromFrame.size.width, toHeight);
    
    //如果需要将所有扩展页面都隐藏，而此时已经隐藏了所有扩展页面，则不进行任何操作
    if(bottomHeight == 0 && self.frame.size.height == self.toolbarView.frame.size.height)
    {
        return;
    }
    
    if (bottomHeight == 0) {
        self.isShowButtomView = NO;
    }
    else{
        self.isShowButtomView = YES;
    }
    
    self.frame = toFrame;
    
    if (_delegate && [_delegate respondsToSelector:@selector(chatToolbarDidChangeFrameToHeight:)]) {
        
        
        [_delegate chatToolbarDidChangeFrameToHeight:toHeight];
    }
}

- (void)_willShowBottomView:(UIView *)bottomView
{
    if (![self.activityButtomView isEqual:bottomView]) {
        CGFloat bottomHeight = bottomView ? bottomView.frame.size.height : 0;
        
        if (bottomHeight == 0) {
            [[NSNotificationCenter defaultCenter]postNotificationName:K_PutDownNews object:nil];
        }else{
            
            [[NSNotificationCenter defaultCenter]postNotificationName:K_PackUpNews object:nil];
            
        }
        
        [self _willShowBottomHeight:bottomHeight];
        
        if (bottomView) {
            CGRect rect = bottomView.frame;
            rect.origin.y = CGRectGetMaxY(self.toolbarView.frame);
            bottomView.frame = rect;
            [self addSubview:bottomView];
        }
        
        if (self.activityButtomView) {
            [self.activityButtomView removeFromSuperview];
        }
        self.activityButtomView = bottomView;
    }
}

- (void)_willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        //一定要把self.activityButtomView置为空
        [self _willShowBottomHeight:toFrame.size.height];
        if (self.activityButtomView) {
            [self.activityButtomView removeFromSuperview];
        }
        self.activityButtomView = nil;
    }
    else if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        [self _willShowBottomHeight:0];
    }
    else{
        [self _willShowBottomHeight:toFrame.size.height];
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(inputTextViewWillBeginEditing:)]) {
        [self.delegate inputTextViewWillBeginEditing:self.inputTextView];
    }
    
    for (EaseChatToolbarItem *item in self.leftItems) {
        item.button.selected = NO;
    }
    
    for (EaseChatToolbarItem *item in self.rightItems) {
        item.button.selected = NO;
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
    
    if ([self.delegate respondsToSelector:@selector(inputTextViewDidBeginEditing:)]) {
        [self.delegate inputTextViewDidBeginEditing:self.inputTextView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(didSendText:)]) {
//            [self.delegate didSendText:textView.text];
            [self sendFace];
            self.inputTextView.text = @"";
            [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.inputTextView]];;
        }
        
        return NO;
    } else if ([text isEqualToString:@"@"]) {
            if ([self.delegate respondsToSelector:@selector(didInputAtInLocation:)]) {
                if ([self.delegate didInputAtInLocation:range.location]) {
                    [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.inputTextView]];
                    return NO;
                }
            }
        }
        else if ([text length] == 0) {
            //delete one character
            if (range.length == 1 && [self.delegate respondsToSelector:@selector(didDeleteCharacterFromLocation:)]) {
                return ![self.delegate didDeleteCharacterFromLocation:range.location];
            }
        }
        return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self _willShowInputTextViewToHeight:[self _getTextViewContentH:textView]];
}

#pragma mark - DXFaceDelegate

- (void)selectedFacialView:(NSString *)str isDelete:(BOOL)isDelete
{
    NSString *chatText = self.inputTextView.text;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.inputTextView.attributedText];
    
    if (!isDelete && str.length > 0) {
        if (self.version >= 7.0) {
            NSRange range = [self.inputTextView selectedRange];
            [attr insertAttributedString:[[EaseEmotionEscape sharedInstance] attStringFromTextForInputView:str textFont:self.inputTextView.font] atIndex:range.location];
            self.inputTextView.attributedText = attr;
        } else {
            self.inputTextView.text = @"";
            self.inputTextView.text = [NSString stringWithFormat:@"%@%@",chatText,str];
        }
    }
    else {
        if (self.version >= 7.0) {
            if (chatText.length > 0) {
                NSInteger length = 1;
                if (chatText.length >= 2) {
                    NSString *subStr = [chatText substringFromIndex:chatText.length-2];
                    if ([EaseEmoji stringContainsEmoji:subStr]) {
                        length = 2;
                    }
                }
                self.inputTextView.attributedText = [self backspaceText:attr length:length];
            }
        } else {
            if (chatText.length >= 2)
            {
                NSString *subStr = [chatText substringFromIndex:chatText.length-2];
                if ([(EaseFaceView *)self.faceView stringIsFace:subStr]) {
                    self.inputTextView.text = [chatText substringToIndex:chatText.length-2];
                    [self textViewDidChange:self.inputTextView];
                    return;
                }
            }
            
            if (chatText.length > 0) {
                self.inputTextView.text = [chatText substringToIndex:chatText.length-1];
            }
        }
    }
    
    [self textViewDidChange:self.inputTextView];
}
-(NSMutableAttributedString*)backspaceText:(NSMutableAttributedString*) attr length:(NSInteger)length
{
    NSRange range = [self.inputTextView selectedRange];
    if (range.location == 0) {
        return attr;
    }
    [attr deleteCharactersInRange:NSMakeRange(range.location - length, length)];
    return attr;
}

- (void)sendFace
{
    NSString *chatText = self.inputTextView.text;
    if (chatText.length > 0) {
        if ([self.delegate respondsToSelector:@selector(didSendText:)]) {
            
            if (![_inputTextView.text isEqualToString:@""]) {
                
                //转义回来
                NSMutableString *attStr = [[NSMutableString alloc] initWithString:self.inputTextView.attributedText.string];
                [_inputTextView.attributedText enumerateAttribute:NSAttachmentAttributeName
                                                          inRange:NSMakeRange(0, self.inputTextView.attributedText.length)
                                                          options:NSAttributedStringEnumerationReverse
                                                       usingBlock:^(id value, NSRange range, BOOL *stop)
                 {
                     if (value) {
                         EMTextAttachment* attachment = (EMTextAttachment*)value;
                         NSString *str = [NSString stringWithFormat:@"%@",attachment.imageName];
                         [attStr replaceCharactersInRange:range withString:str];
                     }
                 }];
                [self.delegate didSendText:attStr];
                self.inputTextView.text = @"";
                [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.inputTextView]];;
            }
        }
    }
}

- (void)sendFaceWithEmotion:(EaseEmotion *)emotion
{
    if (emotion) {
        if ([self.delegate respondsToSelector:@selector(didSendText:withExt:)]) {
            [self.delegate didSendText:emotion.emotionTitle withExt:@{EASEUI_EMOTION_DEFAULT_EXT:emotion}];
            [self _willShowInputTextViewToHeight:[self _getTextViewContentH:self.inputTextView]];;
        }
    }
}

#pragma mark - UIKeyboardNotification

- (void)chatKeyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    void(^animations)() = ^{
        [self _willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:nil];
}

#pragma mark - action

- (void)styleButtonAction:(id)sender
{
//    UIButton *button = (UIButton *)sender;
//    button.selected = !button.selected;
//    if (button.selected) {
//        for (EaseChatToolbarItem *item in self.rightItems) {
//            item.button.selected = NO;
//        }
//        
//        for (EaseChatToolbarItem *item in self.leftItems) {
//            if (item.button != button) {
//                item.button.selected = NO;
//            }
//        }
//        
//        //录音状态下，不显示底部扩展页面
//        [self _willShowBottomView:nil];
//        
//        //将inputTextView内容置空，以使toolbarView回到最小高度
//        self.inputTextView.text = @"";
//        [self textViewDidChange:self.inputTextView];
//        [self.inputTextView resignFirstResponder];
//    }
//    else{
//        //键盘也算一种底部扩展页面
//        [self.inputTextView becomeFirstResponder];
//    }
//    
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.recordButton.hidden = !button.selected;
//        self.inputTextView.hidden = button.selected;
//    } completion:nil];
    
    
    UIButton *button = (UIButton *)sender;
    if(!button.selected)
    {
        [[AVAudioSession sharedInstance]requestRecordPermission:^(BOOL granted) {
            
            if (!granted)
                
            {
                // [ViewUtilalertViewWithString:NSLocalizedString(@"麦克风功能未开启",nil)];
            }
            
            else
                
            {
                
            }
        }];
    }

    button.selected = !button.selected;
    
    EaseChatToolbarItem *moreItem = nil;
    for (EaseChatToolbarItem *item in self.leftItems) {
        if (item.button == button){
            moreItem = item;
            continue;
        }
        
        item.button.selected = NO;
    }
    
    for (EaseChatToolbarItem *item in self.rightItems) {
        item.button.selected = NO;
    }
    
    if (button.selected) {
        //如果处于文字输入状态，使文字输入框失去焦点
        [self.inputTextView resignFirstResponder];
        
        [self _willShowBottomView:moreItem.button2View];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //self.recordButton.hidden = button.selected;
            self.inputTextView.hidden = !button.selected;
        } completion:nil];
    }
    else
    {
        [self.inputTextView becomeFirstResponder];
    }

}

- (void)faceButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    
    EaseChatToolbarItem *faceItem = nil;
    for (EaseChatToolbarItem *item in self.rightItems) {
        if (item.button == button){
            faceItem = item;
            continue;
        }
        
        item.button.selected = NO;
    }
    
    for (EaseChatToolbarItem *item in self.leftItems) {
        item.button.selected = NO;
    }
    
    if (button.selected) {
        //如果处于文字输入状态，使文字输入框失去焦点
        [self.inputTextView resignFirstResponder];
        
        [self _willShowBottomView:faceItem.button2View];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //self.recordButton.hidden = button.selected;
            self.inputTextView.hidden = !button.selected;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [self.inputTextView becomeFirstResponder];
    }
}

- (void)moreButtonAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    
    EaseChatToolbarItem *moreItem = nil;
    for (EaseChatToolbarItem *item in self.rightItems) {
        if (item.button == button){
            moreItem = item;
            continue;
        }
        
        item.button.selected = NO;
    }
    
    for (EaseChatToolbarItem *item in self.leftItems) {
        item.button.selected = NO;
    }
    
    if (button.selected) {
        //如果处于文字输入状态，使文字输入框失去焦点
        [self.inputTextView resignFirstResponder];
        
        [self _willShowBottomView:moreItem.button2View];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // self.recordButton.hidden = button.selected;
            self.inputTextView.hidden = !button.selected;
        } completion:nil];
    }
    else
    {
        [self.inputTextView becomeFirstResponder];
    }
}

- (void)recordButtonTouchDown
{
   
            if (_delegate && [_delegate respondsToSelector:@selector(didStartRecordingVoiceAction:)]) {
                [_delegate didStartRecordingVoiceAction:self.recordView];
            }
       
    
}

- (void)recordButtonTouchUpOutside
{
    if (_delegate && [_delegate respondsToSelector:@selector(didCancelRecordingVoiceAction:)])
    {
        [_delegate didCancelRecordingVoiceAction:self.recordView];
    }
}

- (void)recordButtonTouchUpInside
{
   self.recordHandleView.m_recordButton.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(didFinishRecoingVoiceAction:)])
    {
        [self.delegate didFinishRecoingVoiceAction:self.recordView];
    }
   self.recordHandleView.m_recordButton.enabled = YES;
}

- (void)recordDragOutside
{
    if ([self.delegate respondsToSelector:@selector(didDragOutsideAction:)])
    {
        [self.delegate didDragOutsideAction:self.recordView];
    }
}

- (void)recordDragInside
{
    if ([self.delegate respondsToSelector:@selector(didDragInsideAction:)])
    {
        [self.delegate didDragInsideAction:self.recordView];
    }
}
- (void)recordButtonTouchCancel
{
//    if ([self.delegate respondsToSelector:@selector(didDragInsideAction:)])
//    {
//        [self.delegate didDragInsideAction:self.recordView];
    DLog(@"recordButtonTouchCancel=====走吗");
//    }
}

#pragma mark - public


/**
 默认高度

 @param type 聊天类型
 @return float
 */
+ (CGFloat)defaultHeight:(EMConversationType) type
{
    if (type==EMConversationTypeChatRoom) {
    
    return 5 * 2 + 36 + 44;
     }else{
         return 5 * 2 + 36;
     }
}

/**
 *  停止编辑
 */
- (BOOL)endEditing:(BOOL)force
{
    BOOL result = [super endEditing:force];
    
//    for (EaseChatToolbarItem *item in self.leftItems) {
//        item.button.selected = NO;
//    }
    
    for (EaseChatToolbarItem *item in self.rightItems) {
        item.button.selected = NO;
    }
    [self _willShowBottomView:nil];
    
    return result;
}

/**
 *  取消触摸录音键
 */
- (void)cancelTouchRecord
{
    if ([_recordView isKindOfClass:[EaseRecordView class]]) {
        [(EaseRecordView *)_recordView recordButtonTouchUpInside];
        [_recordView removeFromSuperview];
    }
}

- (void)willShowBottomView:(UIView *)bottomView
{
    [self _willShowBottomView:bottomView];
}

#pragma mark - UIcollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
}
//定义展示的UIcollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
        [self.m_NmuberBtn setTitle:[NSString stringWithFormat:@"%ld",ShareAppDelegate.m_ChatNumberPeople.count] forState:UIControlStateNormal];
   
//    return 30;
        return ShareAppDelegate.m_ChatNumberPeople.count;
}

//定义展示的Section的个数

-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView

{
    
    return 1  ;
    
}

//每个UICollectionView展示的内容

-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
    static NSString * identifer1 = @"GCCollectionViewCell";
    UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
    [collectionView
     registerNib:nib forCellWithReuseIdentifier:identifer1];
    
    GCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer1 forIndexPath:indexPath];
         ChatMemberListModel * model = ShareAppDelegate.m_ChatNumberPeople[indexPath.row];
    if ([DTools isStringEmpty:model.m_Roleavatar]) {
         [cell.m_UserImagePhoto sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage)];
    }else{
        
         [cell.m_UserImagePhoto sd_setImageWithURL:[NSURL URLWithString:model.m_Roleavatar] placeholderImage:ImageNamed(K_avaterPHImage)];
    }
    
//    cell.m_UserImagePhoto.backgroundColor = [UIColor purpleColor];
    return cell;
}

//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter]postNotificationName:K_TOUCHPHOTOVIEW object:nil];
}





//定义每个UICollectionView 的大小

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    //    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    //    CGFloat length = [self.m_data[indexPath.row] boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
    //    CGFloat W = (LCDW - 60)/4;
    return CGSizeMake(36 , 36);
    
    
}


//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake(4, 4,4,4);
    
    
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
    
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
    
}



#pragma mark -- 通知和按钮方法

-(void)reloadDataPhoto
{
    
    [self.m_collectionView reloadData];
}

-(void)changeFreamAll
{
    self.m_collectionView.frame = CGRectMake(CGRectGetMaxX(self.m_NmuberBtn.frame) + 10, 0, LCDW -( CGRectGetMaxX(self.m_NmuberBtn.frame) +10), 44);
    
}
-(void)changeFreamNoAll
{
    self.m_collectionView.frame = CGRectMake(CGRectGetMaxX(self.m_NmuberBtn.frame) + 10, 0, LCDW - (CGRectGetMaxX(self.m_NmuberBtn.frame)+10) - 70, 44);
    
}

-(void)touchBtn:(UIButton *)btn
{
//    [[NSNotificationCenter defaultCenter]postNotificationName:K_NewMessage object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:K_TOUCHPHOTOVIEW object:nil];
}
@end
