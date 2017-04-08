//
//  BaseWhenNaviHiddenViewController.h
//  TheStep
//
//  Created by 邓江洲 on 16/12/14.
//  Copyright © 2016年 邓江洲. All rights reserved.
//

typedef NS_ENUM( NSUInteger, BaseTypeMode){
    kBaseTypeModeNormal = 3 ,
    kBaseTypeModelResumeOnLine
};



#import "BaseNaviHiddenViewController.h"
@interface BaseWhenNaviHiddenViewController : BaseNaviHiddenViewController
@property (nonatomic, copy)  void(^backResumeRouteBlock)(NSInteger backRsmRouteType);
@property (nonatomic, strong) UIView * customNavigationView;

- (void)configWhenNaviHiddenViewWithTitle: (NSString *) titleString withTypeMode: (BaseTypeMode ) typeInt;
- (void)backToWhenNaviHidden;


@end
