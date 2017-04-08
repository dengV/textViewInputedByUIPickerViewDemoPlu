//
//  ZheUtil.h
//  TheStep
//
//  Created by dengzheyibu on 2017/1/5.
//  Copyright © 2017年 邓江洲. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface ZheUtil : NSObject



+ (void )parseTFied:(UITextField *) txtField WithLeftViewName: (NSString *) imageName;

+ (void )parseTFields: (NSArray <UITextField *> *) txtFields WithRightViewNames: (NSArray <NSString *> *) imageNames;

#pragma mark - Time Picker Util
+ (BOOL)endDate: (NSString * ) endDateStr sholdBeyondStartDate: (NSString * ) startDateStr;

#pragma mark - Button Util


+ (UIButton *) createNaviButtonWithFrame: (CGRect) frame withBackgroundColor: (UIColor *) bgColor withNormalImage: (UIImage *) normalImage;

#pragma mark - Label Util

+ (UILabel *) createLabelTextLeft;

#pragma mark - UIToolBar Util

//+ (UIToolbar *)createAccessoryToolbar;

+ (UIView *)createAccessoryViewWithExeSel: (SEL ) exeSel withTarget: (id) tarObject withCancelSel: (SEL) cancelSel withExeBtnTag: (NSInteger ) exeTag;
#pragma mark - HEX Color  调 颜色

+ (UIColor *) colorWithHexString: (NSString *)color ;

@end
