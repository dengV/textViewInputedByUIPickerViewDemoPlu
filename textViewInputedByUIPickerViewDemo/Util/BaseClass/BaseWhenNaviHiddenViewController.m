//
//  BaseWhenNaviHiddenViewController.m
//  TheStep
//
//  Created by 邓江洲 on 16/12/14.
//  Copyright © 2016年 邓江洲. All rights reserved.
//

#import "UILabel+Util.h"
#import "BaseWhenNaviHiddenViewController.h"

@interface BaseWhenNaviHiddenViewController ()

@property (nonatomic, strong) UIButton * leftButtonCustomNavi;

@end

@implementation BaseWhenNaviHiddenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor ];
    
}







- (void)configWhenNaviHiddenViewWithTitle: (NSString *) titleString withTypeMode: (BaseTypeMode ) typeInt
{
    self.customNavigationView = [[UIView alloc ] initWithFrame: CGRectMake(0, 0, kScreenWidth, 64)];
    
    [self.view addSubview: self.customNavigationView ];
    [self.customNavigationView addSubview: [UILabel createNavigationTitleLabelZheWithFrame: CGRectMake(kScreenWidth/2 - 120, 30, 240, 20) withTitle: titleString ]];
    if([titleString isEqualToString: @"我的这一步"  ] || [titleString isEqualToString: @"我的简历"  ]){}else{
        UIView * separatorView = [[UIView alloc ] initWithFrame: CGRectMake(0, 63, kScreenWidth, 1) ];
        separatorView.backgroundColor = [ZheUtil colorWithHexString: @"#DDDDDD" ];
        [self.view addSubview: separatorView ];
    
    }
    if(typeInt == kBaseTypeModeNormal ){
        self.leftButtonCustomNavi = [ZheUtil createNaviButtonWithFrame: CGRectMake(0, 20, 50, 44)  withBackgroundColor: [UIColor clearColor] withNormalImage: [UIImage imageNamed:@"navBackIcon"] ];
    }else if(typeInt == kBaseTypeModelResumeOnLine ){
        self.leftButtonCustomNavi = [ZheUtil createNaviButtonWithFrame: CGRectMake(10, 32, 22, 22)  withBackgroundColor: [UIColor clearColor] withNormalImage: [UIImage imageNamed:@"navBackIconResumeOn"] ];
        //CGRectMake(15, 32, 12, 22)
    }
    
    [self.leftButtonCustomNavi addTarget: self action: @selector(backToWhenNaviHidden) forControlEvents: UIControlEventTouchUpInside ];
    [self.customNavigationView addSubview: self.leftButtonCustomNavi ];
    
    
    
}


- (void)backToWhenNaviHidden
{
    if(self.backResumeRouteBlock ){
        self.backResumeRouteBlock(5);
    
    }
    [self.navigationController popViewControllerAnimated: YES ];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
