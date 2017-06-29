//
//  RootViewController.m
//  storm
//
//  Created by dong on 15/7/7.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "DRootViewController.h"

@interface DRootViewController ()
@end

@implementation DRootViewController
@synthesize right;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//       [self.navigationController setNavigationBarHidden:NO animated:NO]; 
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.m_NetTask cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isLoyoutView=NO;
    
    self.right=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goBack:)];
    
    self.right.direction=UISwipeGestureRecognizerDirectionRight;

    [self.view addGestureRecognizer:self.right];
    
    
    //设置导航栏不透明
    self.view.backgroundColor = RGBBgColor;
    self.navigationController.navigationBar.translucent = NO;
    //修改状态栏 白色
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
 
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
   
    self.navigationController.navigationBar.barTintColor = RGBBgNavColor;
    
    //字体颜色
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
 
    self.navigationController.navigationBar.titleTextAttributes = dict;
    //一步设置导航栏字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];

    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    self.m_isNetSuccess=NO;
    
    

}
//
//-(void)goBack:(UIButton *)btn
//{
//     [self.navigationController popViewControllerAnimated:YES];
//
//}
-(void)onBack{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack:(UISwipeGestureRecognizer*)sender
{
    
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    
    
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
