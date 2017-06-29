//
//  JJBaseTabBarController.m
//
//  Created by dong on 15/7/6.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "JJBaseTabBarController.h"
//Color
#define COLOR_ORANGE RGBACOLOR(46, 86, 142, 1)
#define COLOR_DEFAULT  [UIColor blueColor]
#define COLOR_BG_LINE ColorFromHexRGB(0xF0F0F0)
//定义UIImage对象
#define ImageNamed(imageName) [UIImage imageNamed:imageName]

#import "MovieFanViewController.h"
#import "HotTVViewController.h"
#import "MyViewController.h"
#import "MessageViewController.h"

@interface JJBaseTabBarController ()<UITabBarControllerDelegate>{
   
    NSUInteger oldIndex;
    

}
@property(nonatomic,strong) //聊热剧
UIViewController *controller_hotTV;
@property(nonatomic,strong)//影迷圈
UIViewController *controller_movieFan;
@property(nonatomic,strong)//好友
UIViewController *controller_message;
@property(nonatomic,strong)//我的
UIViewController *controller_my;
@property (assign,nonatomic) int m_bage;
@property (assign,nonatomic) int result;
@property(nonatomic,assign) int unreadCountAdressBook;//未读数
@property(nonatomic,assign) int unreadCountMessage;//未读数
@property(nonatomic,assign) int unreadCountMy;//未读数
@end
@implementation JJBaseTabBarController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.delegate=self;
    //图标选中颜色颜色
    self.tabBar.tintColor = RGBACOLOR(228, 175, 22, 1);
    self.tabBar.translucent = NO;
//    self.tabBar.barTintColor =RGB_Nav;
    //设置tabbar字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_ORANGE,                                                                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
 self.tabBar.accessibilityIdentifier = @"tabbar";
    
    self.controller_hotTV    = [self controllerWithInfo:[[HotTVViewController alloc]init] title:@"热聊剧"
                                                           normalImageName:@"tabbar_near"
                                                         selectedImageName:@"tabbar_near_click"tag:0];

    self.controller_movieFan  = [self controllerWithInfo:[[MovieFanViewController alloc]init] title:@"影迷圈"
                                                               normalImageName:@"tabbar_msg"
                                                             selectedImageName:@"tabbar_msg_click" tag:1];
    
    self.controller_message  = [self controllerWithInfo:[[MessageViewController alloc]init] title:@"消息"
                                                            normalImageName:@"tabbar_addressbook"
                                                          selectedImageName:@"tabbar_addressbook_click" tag:2];
    

    
   self.controller_my      = [self controllerWithInfo:[[MyViewController alloc]init] title:@"我的"
                                                           normalImageName:@"tabbar_my"
                                                         selectedImageName:@"tabbar_my_click"tag:3];
    

    
        self.viewControllers = @[self.controller_hotTV,
                                 self.controller_movieFan,
                                 self.controller_message,
                                self.controller_my];
    
 
    //隐藏背景线，设置背景颜色关键代码
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
   [[UITabBar appearance] setBackgroundColor:[UIColor redColor]];
    
    
    

   
 
    
}



/**
 *  创建TabBarController子viewController
 *  @param controller             controller
 *  @param title             tabBarItem title
 *  @param normalImageName   正常状态下图标名称
 *  @param selectedImageName 选中状态下图标名称
 *
 *  @return UIViewController
 */
-(UIViewController*)controllerWithInfo:(UIViewController *)controller title:(NSString*)title
                                 normalImageName:(NSString*)normalImageName
                               selectedImageName:(NSString*)selectedImageName tag:(int)tag
{

   
    controller.tabBarItem.title         = NSLocalizedString(title, nil);
    controller.tabBarItem.image         = [ImageNamed(normalImageName)
                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont systemFontOfSize:12],NSFontAttributeName,
                                                       nil] forState:UIControlStateNormal];
    controller.tabBarItem.selectedImage = [ImageNamed(selectedImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.titlePositionAdjustment=UIOffsetMake(0, -3);
    controller.tabBarItem.tag = tag;
    controller.tabBarItem.accessibilityIdentifier = title;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
    
   
    return navi;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger tabIndex = [self.tabBar.items indexOfObject:self.tabBar.selectedItem];
    NSLog(@"tabIndex---%lu",(unsigned long)tabIndex);
   
  
}
-(void)clickCenterButton:(UIButton *)sender
{
//    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Camera" bundle:nil];
//    
//    //            页面跳转继续重置密码
//    PhotoAlbumViewController *next=[storyboard instantiateViewControllerWithIdentifier:@"PhotoAlbumViewController"];
//    next.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self presentViewController:next animated:YES completion:nil];
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
}

///**
// 控制tab的消息数量
// 
// @param tabIndex tabIndex
// @param bageValue 消息数
// */
//-(void)setTabBarItemBadgeValue1:(int)tabIndex bageValue:(int)bageValue
//{
////    UITabBar *tabBar = self.tabBarController.tabBar;
//   
//    switch (tabIndex) {
//        case 0:
//      
//            break;
//        case 1:
//            
//            break;
//            
//        case 2:
//        {
//            
//          
//            if (self.m_bage>99) {
//                self.controller_message.tabBarItem.badgeValue=@"99+";
//            }else
//            {
//                if (self.m_bage>0) {
//                   self.controller_message.tabBarItem.badgeValue = StringFormat(@"%i",self.m_bage);
//                }else
//                {
//                    self.controller_message.tabBarItem.badgeValue=nil;
//                    // 清除右上角数字
//                    //                    self.parentViewController.tabBarItem.badgeValue= nil;
//                }
//                
//            }
//        }
//            break;
//            
//        case 3:
//        {
//           // UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:3];
//            if (self.m_bage>99) {
//                self.controller_addressBook.tabBarItem.badgeValue=@"99+";
//            }else
//            {
//                if (self.m_bage>0) {
//                    self.controller_addressBook.tabBarItem.badgeValue = StringFormat(@"%i",self.m_bage);
//                }else
//                {
//                    self.controller_addressBook.tabBarItem.badgeValue=nil;
//                }
//                
//            }
//        }
//            break;
//        case 4:
//        {
//            //            UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:4];
//            
//            if (self.m_bage>0) {
//                //控制小红点
//                [self.tabBarController.tabBar showBadgeOnItemIndex:4];
//            }else
//            {
//                //控制小红点
//                [self.tabBarController.tabBar hideBadgeOnItemIndex:4];
//            }
//            
//            
//        }
//            break;
//        default:
//            break;
//    }
//}

@end











