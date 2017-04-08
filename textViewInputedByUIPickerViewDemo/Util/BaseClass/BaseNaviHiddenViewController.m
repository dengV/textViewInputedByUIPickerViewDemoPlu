//
//  BaseNaviHiddenViewController.m
//  TheStep
//
//  Created by dengzheyibu on 2017/2/20.
//  Copyright © 2017年 邓江洲. All rights reserved.
//

#import "BaseNaviHiddenViewController.h"

#import "BaseWhenNaviHiddenViewController.h"


@interface BaseNaviHiddenViewController ()<UINavigationControllerDelegate>

@end

@implementation BaseNaviHiddenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated ];
    self.navigationController.delegate = self;
}


#pragma mark - Action

- (BOOL) needHiddenBarViewController: (UIViewController *) viewCtrl
{
    BOOL doNeedHideNaviBar = NO;
    
    if([viewCtrl isKindOfClass: [BaseWhenNaviHiddenViewController class]]){
        
        doNeedHideNaviBar = YES;
    
    }
    

    return doNeedHideNaviBar ;
}


#pragma mark - UINavigationBarDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden: [self needHiddenBarViewController: viewController ] animated: animated ];



}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
