#import "VideoViewController.h"



#import <AVFoundation/AVBase.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVCaptureSession.h>
#import <CoreMedia/CMSampleBuffer.h>
#import <QuartzCore/CALayer.h>
#import <dispatch/dispatch.h>

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import<MobileCoreServices/MobileCoreServices.h>


#import "TTCounterLabel.h"
#import "VideoModel.h"
//#import "LocalVideoViewController.h"
//#import "EditorsVideoViewController.h"
typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);
typedef NS_ENUM(NSInteger, kTTCounter){
    kTTCounterRunning = 0,
    kTTCounterStopped,
    kTTCounterReset,
    kTTCounterEnded
};

//这个为找到沙盒根目录
#define KCachesPath   \
[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//在根目录下创建一个文件夹名叫VideoPathUrl
#define VideoPath \
[NSString stringWithFormat:@"%@/VideoPathUrl",KCachesPath]

//流程就应该是：
//device（获取设备，这里为camera）-->capture input（用device初始化一个capture input）;capture（初始化一个capture output）-->session（把input和output加入到session，然后startrunning）-->video（用out生成一个video）
@interface VideoViewController ()<AVCaptureFileOutputRecordingDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CustomProgressDelegate,UIAlertViewDelegate,TTCounterLabelDelegate>//视频文件输出代理

@property (strong,nonatomic) AVCaptureSession *captureSession;//负责输入和输出设备之间的数据传递
@property (strong,nonatomic) AVCaptureDeviceInput *captureDeviceInput;//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;//相机拍摄预览图层
@property (assign,nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifier;//后台任务标识
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIButton *takeButton;//拍照按钮
@property (weak, nonatomic) IBOutlet UIImageView *focusCursor; //聚焦光标
@property (weak, nonatomic) IBOutlet UIButton *m_captureBtn;//录像按钮


@property (strong, nonatomic) NSTimer *progressTimer; //时间定时器
@property (assign, nonatomic) CGFloat m_float; //时间定时器
@property (assign, nonatomic) int m_addTag; //进度tag

@property (strong, nonatomic) NSMutableArray *m_avUrlArr; //进度tag
@property (strong, nonatomic) NSMutableArray *m_timeArr; //进度tag
@property (strong, nonatomic) NSString *m_startTime; //开始时间
@property (weak, nonatomic)IBOutlet  TTCounterLabel *m_progressTimeLab; //进度时间Lab
@property (assign,nonatomic) BOOL isAdd;//是否添加视频url到数组
@property (nonatomic, assign) unsigned long m_startCurrentValue;//开始时的当前时间
@property (nonatomic, strong) NSURL *m_url;//url
@property (nonatomic, assign) BOOL m_isDelete;//是否删除数据

@property(nonatomic,assign)CMTime allTime;//总时间

@property (assign, nonatomic) int m_audeoTag; //tag


@property(nonatomic,strong)NSMutableArray *trackArr;
/**
 *  对勾按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *m_tickBtn;
/**
 *  删除按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *m_deleteBtn;
/**
 *  照片按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *m_photoBtn;
@end
//capture 拍摄
@implementation VideoViewController

#pragma mark - 控制器视图方法
- (void)viewDidLoad {
    [super viewDidLoad];
   
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backHome)
    
    
}
-(void)createView
{
    //给按钮添加手势
    UILongPressGestureRecognizer *longPressGR =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleLongPress2:)];
    longPressGR.allowableMovement=NO;
    longPressGR.minimumPressDuration = 0.005;
    [self.m_captureBtn addGestureRecognizer:longPressGR];
    
    
    //进度条
    CustomProgress *customProgress =[[CustomProgress alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.m_progressView.frame), CGRectGetHeight(self.m_progressView.frame))];
    [self.m_progressView addSubview:customProgress];
    //3秒处的刻度
    UIView *tempView=[[UIView alloc] initWithFrame:CGRectMake(LCDW/15*3, 0, 3,CGRectGetHeight(self.m_progressView.frame))];
    tempView.backgroundColor=RGBACOLOR(102, 102, 102, 1);
    [self.m_progressView addSubview:tempView];
   
}

-(void)initData
{
    self.m_audeoTag=2000;
    self.m_addTag=1000;
    self.trackArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.m_avUrlArr=[[NSMutableArray alloc] initWithCapacity:0];
    
    self.m_timeArr=[[NSMutableArray alloc] initWithCapacity:0];
    
    self.isAdd=YES;
    
    self.m_progressTimeLab.countdownDelegate=self;
    [self.m_progressTimeLab reset];
    self.m_isDelete=NO;
}

-(void)loadView
{
    [super loadView];
    // 设置全屏 隐藏状态栏 for IOS6
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

// 隐藏状态栏 for IOS7
- (BOOL)prefersStatusBarHidden;
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    if (self.m_progressTimeLab.currentValue==0)
    {
     
        [self.m_tickBtn setHidden:YES];
    }else
    {
        [self.m_tickBtn setHidden:NO];
    }
    //设置闪关灯
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOff];
    [device unlockForConfiguration];
    self.m_flashBtn.tag=AVCaptureTorchModeOff;
    [self.m_flashBtn setImage:[UIImage imageNamed:@"record_flash"] forState:UIControlStateNormal];
    [self.m_flashBtn setTitle:@"off"forState:UIControlStateNormal];
    
     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    self.navigationController.navigationBarHidden=YES;
  
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
  /*  AVCaptureSession 可以设置 sessionPreset 属性，这个决定了视频输入每一帧图像质量的大小。
    
    AVCaptureSessionPreset320x240
    AVCaptureSessionPreset352x288
    AVCaptureSessionPreset640x480
    AVCaptureSessionPreset960x540
    AVCaptureSessionPreset1280x720
    AVCaptureSessionPreset1920x1080
    以上列举了部分的属性值，分别代表输入图片质量大小，一般来说AVCaptureSessionPreset640x480就够使用，但是如果要保证较小的二维码图片能快速扫描，最好设置高些，如AVCaptureSessionPreset1920x1080(就是我们常说的1080p).
   */
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
    }
    //获得输入设备
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    if (!captureDevice) {
        DLog(@"取得后置摄像头时出现问题.");
        return;
    }
    
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice=[[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
    _captureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:captureDevice error:&error];
    if (error) {
        DLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    AVCaptureDeviceInput *audioCaptureDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:audioCaptureDevice error:&error];
    if (error) {
        DLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    
    //初始化设备输出对象，用于获得输出数据
    _captureMovieFileOutput=[[AVCaptureMovieFileOutput alloc]init];
//    我是做视频音频图像处理这块的。前段时间做一个视频录制的功能，结果很奇怪，只要录制时间超过10s视频就会没声了。当时反复检查是不是Audioinput或者AudioOutput没添加。最后才发现原因在于AVCaptureMovieFileOutput 的movieFragmentInterval属性。它的默认值就是10秒。将这个值禁用即可解决：
 
    _captureMovieFileOutput.movieFragmentInterval = kCMTimeInvalid;

    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput])
    {
        [_captureSession addInput:_captureDeviceInput];
        [_captureSession addInput:audioCaptureDeviceInput];
        
        AVCaptureConnection *captureConnection=[_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        
        if ([captureConnection isVideoStabilizationSupported ])
        {
            captureConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
        }
    }
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
        CALayer *layer=self.viewContainer.layer;
    layer.masksToBounds=NO;
  
//    _captureVideoPreviewLayer.frame=layer.bounds;
    
    _captureVideoPreviewLayer.frame=CGRectMake(0, 0, LCDW, LCDW);
    DLog(@"layer.bounds---%@",NSStringFromCGRect(layer.bounds));
    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    //将视频预览层添加到界面中
    [layer addSublayer:_captureVideoPreviewLayer];
   // [layer insertSublayer:_captureVideoPreviewLayer below:self.focusCursor.layer];
    
   
    [self addNotificationToCaptureDevice:captureDevice];
    [self addGenstureRecognizer];
    
    [self createView];
    [self initData];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.captureSession startRunning];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
    //隐藏状态栏
    [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.captureSession stopRunning];
}

-(void)dealloc{
    [self removeNotification];
}
#pragma mark - UI方法
#pragma mark 视频录制
//响应的事件
-(void)handleLongPress2:(UILongPressGestureRecognizer *)gestureRecognizer{
    
//    UIButton *button=(UIButton*)[(UILongPressGestureRecognizer *)sender view];
  
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
        
    {
          [self restoreSet];
        DLog(@"开始录制");
        
        //根据设备输出获得连接
        AVCaptureConnection *captureConnection=[self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        //根据连接取得设备输出的数据.
        if ([[UIDevice currentDevice] isMultitaskingSupported])
        {
              // 通过调试，发现，iOS给了我们额外的10分钟（600s）来执行这个任务。
            self.backgroundTaskIdentifier=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
        }
        
        //预览图层和视频方向保持一致
        captureConnection.videoOrientation=[self.captureVideoPreviewLayer connection].videoOrientation;
        NSString *path=[NSString stringWithFormat:@"myMovie%i.mp4",self.m_addTag];
        NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:path];
        DLog(@"save path is :%@",outputFielPath);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        if([fileManager removeItemAtPath:outputFielPath error:&error] == NO)
        {
            DLog(@"Failed to remove path %@, ERROR = %@",outputFielPath,error);
        }
        NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
        [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
         [self moveProgress];
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"ss:SSS"];
        
        NSString *  locationString=[dateformatter stringFromDate:senddate];
       self.m_startTime= [self getCurrentTime];
        DLog(@"startlocationString:%@",locationString);
        
       
       
        if (self.m_progressTimeLab.currentValue>=15*1000.00)
        {
            
            
            //停止录制   结束定时器
             [self.captureMovieFileOutput stopRecording];//停止录制
            
             [self.m_progressTimeLab stop];
            CustomProgress *customProgress=(CustomProgress*) [self.m_progressView viewWithTag:self.m_addTag];
            [customProgress endTime];
            return;
        }else
        {
             [self.m_progressTimeLab start];
        }
        self.m_startCurrentValue=self.m_progressTimeLab.currentValue;
        
        DLog(@"currentValue=======:%lu",self.m_startCurrentValue);
        [self.m_timeArr addObject:[NSNumber numberWithLong:self.m_startCurrentValue]];
      
      
        
            [self.m_tickBtn setHidden:NO];
       
        [self.m_photoBtn setHidden:YES];
         [self.m_deleteBtn setHidden:NO];
       
      
        
    }
    
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
        
    {
        [self.m_progressTimeLab stop];
        
       
      
        
        CustomProgress *customProgress=(CustomProgress*) [self.m_progressView viewWithTag:self.m_addTag];
        [customProgress endTime];
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"ss:SSS"];
        
        //打印 没用 --系统结束时间
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        
        DLog(@"endlocationString:%@",locationString);
          [self.captureMovieFileOutput stopRecording];//停止录制
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
        NSDate *date1 = [formatter dateFromString:self.m_startTime];
        //NSDate *date2 = [NSDate date];
        //这是个打印录制时间长短
        NSTimeInterval aTimer = [date1 timeIntervalSinceNow];
         DLog(@"aTimer:%f",aTimer);

        DLog(@"停止录制");
        
    }

}
/**
 *  回到初始状态
 */
-(void)restoreSet
{
   
    self.m_isDelete=NO;
    [self.m_deleteBtn setSelected:NO];
    CustomProgress *customProgress=(CustomProgress*) [self.m_progressView viewWithTag:self.m_addTag];
    [customProgress.progressView setBackgroundColor:RGBACOLOR(41, 110, 180, 1)];
}
-(NSString *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
   
    return dateTime;
}
#pragma mark 切换前后摄像头
- (IBAction)toggleButtonClick:(UIButton *)sender
{
     [self restoreSet];
    AVCaptureDevice *currentDevice=[self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition=[currentDevice position];
    [self removeNotificationFromCaptureDevice:currentDevice];
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition=AVCaptureDevicePositionFront;
    //Unspecified未指明的，Front前面的
    if (currentPosition==AVCaptureDevicePositionUnspecified||currentPosition==AVCaptureDevicePositionFront)
    {
        toChangePosition=AVCaptureDevicePositionBack;
    }
    
    toChangeDevice=[self getCameraDeviceWithPosition:toChangePosition];
    [self addNotificationToCaptureDevice:toChangeDevice];
    //获得要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput=[[AVCaptureDeviceInput alloc]initWithDevice:toChangeDevice error:nil];
    
    //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原有输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput])
    {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput=toChangeDeviceInput;
    }
    //提交会话配置
    [self.captureSession commitConfiguration];
    
}

#pragma mark - 视频输出代理
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    DLog(@"开始录制...");
  
   
}
//修改进度
- (void) moveProgress

{
    
    self.m_float=0;
    //上一次的进度条
    CustomProgress *customProgressOld=(CustomProgress*) [self.m_progressView viewWithTag:self.m_addTag];
    CustomProgress *customProgress;
    if (customProgressOld)
    {
        DLog(@"%f",CGRectGetMaxX(customProgressOld.frame));
        //创建进度条
        customProgress=[[CustomProgress alloc] initWithFrame:CGRectMake(CGRectGetMaxX(customProgressOld.frame)-customProgressOld.frame.size.height/2, 0, LCDW, CGRectGetHeight(customProgressOld.frame))];
    }else
    {
       customProgress =[[CustomProgress alloc] initWithFrame:self.m_progressView.bounds];
    }
    self.m_addTag++;
     [customProgress setProgress:self.m_float];
    customProgress.delegate=self;
    customProgress.tag=self.m_addTag;
     DLog(@"self.m_addTagself.m_addTag-----%i",self.m_addTag);
    [self.m_progressView addSubview:customProgress];
    
}

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    DLog(@"视频录制完成----错误原因：%@",error.localizedFailureReason);
   
    DLog(@"address --- %@",[outputFileURL absoluteString]);
   
    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:outputFileURL options:nil];
    
    CMTime audioDuration = audioAsset.duration;
    
    float audioDurationSeconds =CMTimeGetSeconds(audioDuration);
//    NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:outputFileURL error:nil].fileSize;
      NSData *videoData = [NSData dataWithContentsOfFile:[outputFileURL path] options: 0 error:&error];
     DLog(@"time --- %f",audioDurationSeconds);
    DLog(@"length ---- %lu",(unsigned long)videoData.length);
    if (audioDurationSeconds < 1 || videoData.length == 0) {
        
        self.m_progressTimeLab.startValue=[[self.m_timeArr lastObject] intValue];
        [self.m_timeArr removeLastObject];
        // [[self.m_progressView viewWithTag:self.m_addTag] removeFromSuperview];
        CustomProgress *customProgress=(CustomProgress*) [self.m_progressView viewWithTag:self.m_addTag];
        [customProgress setHidden:YES];
        [customProgress endTime];
        customProgress.tag=0;
        
        
        self.m_addTag--;
        
        [self removeDir:self.m_addTag];
        self.m_isDelete=NO;
        [self.m_deleteBtn setSelected:NO];
    }else{

    
    if (self.isAdd)
    {
        [self.m_avUrlArr addObject:outputFileURL];
    }
  
//    UISaveVideoAtPathToSavedPhotosAlbum([outputFileURL relativePath], self,@selector(video:didFinishSavingWithError:contextInfo:), nil);
    self.m_url=outputFileURL;
    }
}
//视频保存方法
- (void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
      
        DLog(@"Video Saving Failed");
    } else {
       
                   DLog(@"Saved To Photo Album");
            }
}
//删除文件及文件夹
-(void)removeDir:(int) addTags
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *tempDir = NSTemporaryDirectory();
   
     NSString *path=[tempDir stringByAppendingString:[NSString stringWithFormat:@"myMovie%i.mp4",addTags]];
    NSError *error;
    if([fileManager removeItemAtPath:path error:&error] == NO){
        DLog(@"Failed to remove path %@, ERROR = %@",path,error);
    }
}
    

#pragma mark - 通知
/**
 *  给输入设备添加通知
 */
-(void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice
{
    //注意添加区域改变捕获通知必须首先设置设备允许捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice)
    {
        captureDevice.subjectAreaChangeMonitoringEnabled=YES;
    }];
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    //捕获区域发生改变
    [notificationCenter addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
-(void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice
{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}
/**
 *  移除所有通知
 */
-(void)removeNotification{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}

-(void)addNotificationToCaptureSession:(AVCaptureSession *)captureSession{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    //会话出错
    [notificationCenter addObserver:self selector:@selector(sessionRuntimeError:) name:AVCaptureSessionRuntimeErrorNotification object:captureSession];
}

/**
 *  设备连接成功
 *
 *  @param notification 通知对象
 */
-(void)deviceConnected:(NSNotification *)notification{
    DLog(@"设备已连接...");
}
/**
 *  设备连接断开
 *
 *  @param notification 通知对象
 */
-(void)deviceDisconnected:(NSNotification *)notification{
    DLog(@"设备已断开.");
}
/**
 *  捕获区域改变
 *
 *  @param notification 通知对象
 */
-(void)areaChange:(NSNotification *)notification{
    DLog(@"捕获区域改变...");
}

/**
 *  会话出错
 *
 *  @param notification 通知对象
 */
-(void)sessionRuntimeError:(NSNotification *)notification{
    DLog(@"会话发生错误.");
}

#pragma mark - 私有方法

/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position]==position) {
            return camera;
        }
    }
    return nil;
}

/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */
-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
    AVCaptureDevice *captureDevice= [self.captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
        DLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}

/**
 *  设置闪光灯模式
 *
 *  @param flashMode 闪光灯模式
 */
-(void)setFlashMode:(AVCaptureFlashMode )flashMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFlashModeSupported:flashMode]) {
            [captureDevice setFlashMode:flashMode];
        }
    }];
}
/**
 *  设置聚焦模式
 *
 *  @param focusMode 聚焦模式
 */
-(void)setFocusMode:(AVCaptureFocusMode )focusMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
    }];
}
/**
 *  设置曝光模式
 *
 *  @param exposureMode 曝光模式
 */
-(void)setExposureMode:(AVCaptureExposureMode)exposureMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
    }];
}
/**
 *  设置聚焦点
 *
 *  @param point 聚焦点
 */
-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
    }];
}

/**
 *  添加点按手势，点按时聚焦
 */
-(void)addGenstureRecognizer{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [self.viewContainer addGestureRecognizer:tapGesture];
}
-(void)tapScreen:(UITapGestureRecognizer *)tapGesture{
    CGPoint point= [tapGesture locationInView:self.viewContainer];
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint= [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorWithPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{
    self.focusCursor.center=point;
    self.focusCursor.transform=CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursor.alpha=1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusCursor.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusCursor.alpha=0;
        
    }];
}


#pragma mark -
#pragma mark  按钮事件
/**
 *  返回
 *
 *  @param sender
 */
- (IBAction)Esc:(id)sender
{
    if (self.m_avUrlArr.count>0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"确定放弃这段视频吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];

    }else
    {
        //[self deleteTempFile];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
      // [self dismissModalViewControllerAnimated];
}
/**
 *  进入相册
 *
 *  @param sender
 */
- (IBAction)clickPhotoBtn:(UIButton *)sender
{
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Camera" bundle:nil];
//    LocalVideoViewController * temp = [storyboard instantiateViewControllerWithIdentifier:@"LocalVideoViewController"];
//    temp.pushTag=1;
//    [self.navigationController pushViewController:temp animated:YES];
//    
//    //将要跳转的时候让导航栏显示
//    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)clickPushBtn:(UIButton *)sender
{
    
    
    if (sender.selected)
    {
        
        
        [SVProgressHUD showWithStatus:@"正在处理..."];
        [self restoreSet];
       
         [self Composition:self.m_avUrlArr];
        
}
   
}
- (IBAction)clickFlashModelBtn:(UIButton *)sender
{
    AVCaptureTorchMode torchMode=AVCaptureTorchModeAuto;
    
  
    switch (sender.tag)
    {
        case AVCaptureTorchModeOn:
           torchMode = AVCaptureTorchModeAuto;
             sender.tag=AVCaptureFlashModeAuto;
            break;
        case AVCaptureTorchModeOff:
           torchMode = AVCaptureTorchModeOn;
             sender.tag=AVCaptureFlashModeOn;
            break;
        case AVCaptureTorchModeAuto:
            torchMode = AVCaptureTorchModeOff;
             sender.tag=AVCaptureFlashModeOff;
            break;
        default:
            break;
    }

    switch (sender.tag)
    {
        case AVCaptureFlashModeOn:
            
            [self.m_flashBtn setImage:[UIImage imageNamed:@"record_flash"] forState:UIControlStateNormal];
            [self.m_flashBtn setTitle:@"on"forState:UIControlStateNormal];
            break;
        case AVCaptureFlashModeOff:
           
            [self.m_flashBtn setImage:[UIImage imageNamed:@"record_flash"] forState:UIControlStateNormal];
            [self.m_flashBtn setTitle:@"off"forState:UIControlStateNormal];
            break;
        case AVCaptureFlashModeAuto:
           
            [self.m_flashBtn setImage:[UIImage imageNamed:@"record_flash"] forState:UIControlStateNormal];
            [self.m_flashBtn setTitle:@"auto"forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        [device lockForConfiguration:nil];
        [device setTorchMode:torchMode];
        [device unlockForConfiguration];
   // });

    //控制设备闪光灯开启关闭自动状态
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    [device lockForConfiguration:nil];
//    device.flashMode= (AVCaptureFlashMode)sender.tag;
//    [device unlockForConfiguration];
    //这样写有bug会照成开启时闪光灯一直亮着
    // [_camera flashWithMode: (AVCaptureFlashMode)sender.tag];
}

//必须是fileURL
//截取将会是视频的中间部分
//这里假设拍摄出来的视频总是高大于宽的

/*!
 @method mergeAndExportVideosAtFileURLs:
 
 @param fileURLArray
 包含所有视频分段的文件URL数组，必须是[NSURL fileURLWithString:...]得到的
 
 @discussion
 将所有分段视频合成为一段完整视频，并且裁剪为正方形
 */
- (void)Composition:(NSArray *)fileURLArray
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        
        CGSize renderSize = CGSizeMake(0, 0);
        
        NSMutableArray *layerInstructionArray = [[NSMutableArray alloc] init];
        
        AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
        
        CMTime totalDuration = kCMTimeZero;
        
        //先去assetTrack 也为了取renderSize
        NSMutableArray *assetTrackArray = [[NSMutableArray alloc] init];
        NSMutableArray *assetArray = [[NSMutableArray alloc] init];
        for (NSURL *fileURL in fileURLArray) {
            AVAsset *asset = [AVAsset assetWithURL:fileURL];
            
            if (!asset) {
                continue;
            }
            //导致  [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
//        ofTrack:[[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]崩溃的原因 : *** -[__NSArrayM objectAtIndex:]: index 0 beyond bounds for empty array
            //崩溃
            if([asset tracksWithMediaType:AVMediaTypeAudio].count>0)
            {
             [assetArray addObject:asset];
            }
            if([asset tracksWithMediaType:AVMediaTypeVideo].count>0)
            {
                
                AVAssetTrack *assetTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] safeObjectAtIndex:0];
                [assetTrackArray addObject:assetTrack];
                
                renderSize.width = MAX(renderSize.width, assetTrack.naturalSize.height);
                renderSize.height = MAX(renderSize.height, assetTrack.naturalSize.width);
            }

            
           
        }
        
        CGFloat renderW = MIN(renderSize.width, renderSize.height);
       
        for (int i = 0; i < [assetArray count] && i < [assetTrackArray count]; i++) {
            
            AVAsset *asset = [assetArray objectAtIndex:i];
            AVAssetTrack *assetTrack = [assetTrackArray objectAtIndex:i];
            
            AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
            [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                                ofTrack:[[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                                 atTime:totalDuration
                                  error:nil];
            
            AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
            
            [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                                ofTrack:assetTrack
                                 atTime:totalDuration
                                  error:&error];
            
            //fix orientationissue
            AVMutableVideoCompositionLayerInstruction *layerInstruciton = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
            
            totalDuration = CMTimeAdd(totalDuration, asset.duration);
            
            CGFloat rate;
            rate = renderW / MIN(assetTrack.naturalSize.width, assetTrack.naturalSize.height);
            
            CGAffineTransform layerTransform = CGAffineTransformMake(assetTrack.preferredTransform.a, assetTrack.preferredTransform.b, assetTrack.preferredTransform.c, assetTrack.preferredTransform.d, assetTrack.preferredTransform.tx * rate, assetTrack.preferredTransform.ty * rate);
            
            layerTransform = CGAffineTransformConcat(layerTransform, CGAffineTransformMake(1, 0, 0, 1, 0, -(assetTrack.naturalSize.width - assetTrack.naturalSize.height) / 2.0));//向上移动取中部影响
            layerTransform = CGAffineTransformScale(layerTransform, rate, rate);//放缩，解决前后摄像结果大小不对称
            
            [layerInstruciton setTransform:layerTransform atTime:kCMTimeZero];
            [layerInstruciton setOpacity:0.0 atTime:totalDuration];
            
            //data
            [layerInstructionArray addObject:layerInstruciton];
        }
        
       // 保存到临时文件里
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths safeObjectAtIndex:0];
        
        NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"%@",K_FileName_Record]];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isExist=[fileManager fileExistsAtPath:myPathDocs];
        
        if (!isExist)
        {
            BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:myPathDocs withIntermediateDirectories:YES attributes:nil error:nil];
            NSAssert(bo,@"创建目录失败");
        }
       
        
        
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        int videoTag=[[accountDefaults objectForKey:K_FileName_RecordVideoTag] intValue];
        
        
        
        videoTag++;
      
       [accountDefaults setObject:[NSNumber numberWithInt:videoTag] forKey:K_FileName_RecordVideoTag];
     
        NSString *myPathDocs2 =  [myPathDocs stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"%@%i.mp4",K_FileName_RecordVideoName,videoTag]];
        BOOL isExist2=[fileManager fileExistsAtPath:myPathDocs2];
        //判断合成的视频名称是否相同   如果相同先删除再合成
        if (isExist2)
        {
            if([fileManager removeItemAtPath:myPathDocs2 error:&error] == NO)
            {
                DLog(@"Failed to remove path %@, ERROR = %@",myPathDocs2,error);
            }
        }
        
            NSURL *url = [NSURL fileURLWithPath:myPathDocs2];
        
            DLog(@"URL:-  %@", [url description]);
       

         self.m_audeoTag++;
        //export
        AVMutableVideoCompositionInstruction *mainInstruciton = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        mainInstruciton.timeRange = CMTimeRangeMake(kCMTimeZero, totalDuration);
        mainInstruciton.layerInstructions = layerInstructionArray;
        AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
        mainCompositionInst.instructions = @[mainInstruciton];
        mainCompositionInst.frameDuration = CMTimeMake(1, 30);
        mainCompositionInst.renderSize = CGSizeMake(renderW, renderW);
        DLog(@"renderWrenderWrenderW==================%.f",renderW);
        
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
        exporter.videoComposition = mainCompositionInst;
        exporter.outputURL = url;
        exporter.outputFileType = AVFileTypeMPEG4;
        exporter.shouldOptimizeForNetworkUse = YES;
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
              
                [self exportDidFinish:exporter];
            });
        }];
    });
}

-(void)exportDidFinish:(AVAssetExportSession*)session {
    
    DLog(@"exportDidFinish");
    
    DLog(@"session = %d",(int)session.status);
    if (session.status == AVAssetExportSessionStatusCompleted)
    {
        
        NSURL *outputURL = session.outputURL;
        [SVProgressHUD dismiss];
       //    UISaveVideoAtPathToSavedPhotosAlbum([outputURL relativePath], self,@selector(video:didFinishSavingWithError:contextInfo:), nil);
  
        //视频信息Model
        VideoModel * model = [[VideoModel alloc]init];
        model.m_url = outputURL;
        model.m_width = @"480";
        model.m_high  = @"480";
        model.m_time  =[self TimeMovieUrl:outputURL];
        model.m_image =[self thumbnailImageForVideo:outputURL atTime:1];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if ([self.delegate respondsToSelector:@selector(VideoViewSure:)])
        {
            [self.delegate VideoViewSure:outputURL];
   
        }
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"处理失败==%@",[session.error localizedFailureReason]]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [SVProgressHUD dismiss];
        [alert show];
    }
    
}


//获取视频某一针图像
- (UIImage *) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        DLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef]: nil;
    
    return thumbnailImage;
}



-(NSString *)TimeMovieUrl:(NSURL *)url
{
    AVAsset * asset = [AVAsset assetWithURL:url];
    
    Float64 duration = CMTimeGetSeconds([asset duration]);
    
    NSString * str = [NSString stringWithFormat:@"%f",duration];
    
    
    return str;
    
}





#pragma mark - 保存路径
- (NSString*)getLibarayPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* path = [paths objectAtIndex:0];
    
    NSString *movDirectory = [path stringByAppendingPathComponent:@"tmpMovMix"];
    NSError *error;
    if([fileManager removeItemAtPath:movDirectory error:&error] == NO)
    {
        DLog(@"Failed to remove path %@, ERROR = %@",path,error);
    }
    
    [fileManager createDirectoryAtPath:movDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    return movDirectory;
}
#pragma mark -删除临时文件
-(void)deleteTempFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path=[NSString stringWithFormat:@"mergeVideo%i.mp4",self.m_audeoTag-1];
    NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:path];
    NSError *error;
    if([fileManager removeItemAtPath:outputFielPath error:&error] == NO)
    {
        DLog(@"Failed to remove path %@, ERROR = %@",outputFielPath,error);
    }
    
    
    for (int i=1000;i<=self.m_addTag; i++)
    {
        NSString *path=[NSString stringWithFormat:@"myMovie%i.mp4",i];
        NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:path];
        NSError *error;
        if([fileManager removeItemAtPath:outputFielPath error:&error] == NO)
        {
            DLog(@"Failed to remove path %@, ERROR = %@",outputFielPath,error);
        }
    }
    //删除录制合成好的视频，通过isSave判断是否删除
    if(true)
    {
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
       
        int tag=  [[accountDefaults objectForKey:K_FileName_RecordVideoTag] intValue];
       
        NSString *path=[NSString stringWithFormat:@"%@/%@%i.mp4",K_FileName_Record,K_FileName_RecordVideoName,tag];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths safeObjectAtIndex:0];
        NSString *outputFielPath=[documentsDirectory stringByAppendingString:path];
        NSError *error;
        if([fileManager removeItemAtPath:outputFielPath error:&error] == NO)
        {
                DLog(@"Failed to remove path %@, ERROR = %@",outputFielPath,error);
        }
        
       
    }
}
#pragma mark - 根据asset累加得到duration
- (CMTime)addAllAVAssetDuration:(AVURLAsset *)item andNum:(int) i{
    
    if (i == 0) {
        self.allTime = CMTimeAdd(kCMTimeZero, item.duration);
    }else{
        self.allTime = CMTimeAdd(self.allTime, item.duration);
    }
    
    return self.allTime;
}
- (IBAction)clickDeleteBtn:(UIButton *)sender
{
    if(self.m_isDelete)
    {
        DLog(@"m_avUrlArr====%lu-------m_addTag===%i",(unsigned long)self.m_avUrlArr.count,self.m_addTag);
        if (self.m_addTag==1000)
        {
            return;
        }
        //切换按钮状态
        if (self.m_addTag==1001)
        {
            
            
            
            [self.m_deleteBtn setHidden:YES];
            [self.m_photoBtn setHidden:NO];
            [self.m_tickBtn setSelected:NO];
           
            [self.m_tickBtn setHidden:YES];
        }
        //删除数据源
       [self.m_avUrlArr removeLastObject];
        
        self.m_progressTimeLab.startValue=[[self.m_timeArr lastObject] intValue];
        [self.m_timeArr removeLastObject];
      // [[self.m_progressView viewWithTag:self.m_addTag] removeFromSuperview];
        CustomProgress *customProgress=(CustomProgress*) [self.m_progressView viewWithTag:self.m_addTag];
        [customProgress setHidden:YES];
        [customProgress endTime];
        customProgress.tag=0;
        self.m_addTag--;
        
  [self removeDir:self.m_addTag];
        self.m_isDelete=NO;
        [self.m_deleteBtn setSelected:NO];
    }else
    {
        self.m_isDelete=YES;
        [self.m_deleteBtn setSelected:YES];
         CustomProgress *customProgress=(CustomProgress*) [self.m_progressView viewWithTag:self.m_addTag];
         [customProgress.progressView setBackgroundColor:RGBACOLOR(45, 86, 128, 1)];
        
    }
    
}


 -(UIImage *)getImage:(NSURL *)videoURL
{
    
    //视频地址
    
//    NSURL *url = [[NSURL alloc] initWithString:videoURL];//initFileURLWithPath:videoURL] autorelease];
    
    
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];//
    
    //获取视频时长，单位：秒
    
    DLog(@"%llu",urlAsset.duration.value/urlAsset.duration.timescale);
    
   
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    
    
    
    generator.appliesPreferredTrackTransform = YES;
    
    generator.maximumSize = CGSizeMake(1136, 640);
    
    
    
    NSError *error = nil;
    
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
    
    UIImage *image = [UIImage imageWithCGImage: img];
    
    return image;  
    
}
#pragma mark -
#pragma mark -alert代理

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self deleteTempFile];
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1:
            
            break;
        default:
            break;
    }
    
}
-(void)backHome
{
    [self deleteTempFile];
    [self dismissViewControllerAnimated:YES completion:nil];
    //发送消息
//    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:K_Drafts object:nil userInfo:nil]];   
    
    
    
}
#pragma mark - TTCounterLabelDelegate

- (void)countdownDidEnd
{
    [self.captureMovieFileOutput stopRecording];//停止录制
    [self.m_progressTimeLab stop];
    CustomProgress *customProgress=(CustomProgress*) [self.m_progressView viewWithTag:self.m_addTag];
    [customProgress endTime];
    
    [self clickPushBtn:nil];
}
-(void)thirdEnd
{
    [self.m_tickBtn setSelected:YES];
}
#pragma mark -
#pragma mark DefineCameraViewControllerDelegate
-(void)concel
{
   [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


@end
