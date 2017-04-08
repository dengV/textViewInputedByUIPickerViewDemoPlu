//
//  ZheUtil.m
//  TheStep
//
//  Created by dengzheyibu on 2017/1/5.
//  Copyright © 2017年 邓江洲. All rights reserved.
//

#import "ZheUtil.h"

@implementation ZheUtil




+ (void )parseTFied:(UITextField *) txtField WithLeftViewName: (NSString *) imageName
{
    UIImageView * leftImageView = [[UIImageView alloc ] initWithFrame: CGRectMake(0, 0, 16 + 20 , 20) ];
    leftImageView.image = [UIImage imageNamed: imageName ];
    leftImageView.contentMode = UIViewContentModeCenter;
    txtField.leftViewMode = UITextFieldViewModeAlways;
    txtField.leftView = leftImageView;
}

+ (void )parseTFields: (NSArray <UITextField *> *) txtFields WithRightViewNames: (NSArray <NSString *> *) imageNames
{
    NSInteger i = 0;
    for (UITextField * tField in txtFields ) {
        UIImageView * rightImageView = [[UIImageView alloc ] initWithFrame: CGRectMake(0, 0, 16  , 9) ];//+ 20
        if (imageNames) {
            rightImageView.image = [UIImage imageNamed: imageNames[i] ];
        }else{
            rightImageView.image = [UIImage imageNamed: @"downIndicatorIcon" ];
        }
        rightImageView.contentMode = UIViewContentModeCenter;
        tField.rightViewMode = UITextFieldViewModeAlways;
        tField.rightView = rightImageView;
        i++;
    }
    
}


#pragma mark - Time Picker Util
+ (BOOL)endDate: (NSString * ) endDateStr sholdBeyondStartDate: (NSString * ) startDateStr
{
    BOOL isBeyoud;
    NSArray * startArr = [startDateStr componentsSeparatedByString: @"-" ];
    NSString * startYear = startArr[0];
    NSString * startMonth = startArr[1];
    NSArray * endArr = [endDateStr componentsSeparatedByString: @"-" ];
    NSString * endYear = endArr[0];
    NSString * endMonth = endArr[1];
    if( endYear.integerValue > startYear.integerValue ){
        isBeyoud = YES;
    }else if([ endYear isEqualToString: startYear ] && (endMonth.integerValue > startMonth.integerValue )){
        isBeyoud = YES;
    }else{
        isBeyoud = NO;
    }
    return isBeyoud;
}

#pragma mark - Button Util


+ (UIButton *)createNaviButtonWithFrame: (CGRect) frame withBackgroundColor: (UIColor *) bgColor withNormalImage: (UIImage *) normalImage
{
    UIButton * buttonNavi = [[UIButton alloc ] initWithFrame: frame] ;
    [buttonNavi setBackgroundColor: bgColor];
    if (normalImage) {
        [buttonNavi setImage: normalImage forState:UIControlStateNormal];
    }
    
    return buttonNavi;
}

#pragma mark - Label Util

+ (UILabel *)createLabelTextLeft
{
    UILabel * label = [[UILabel alloc ] init ];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize: 16 ];
    return label;

}


#pragma mark - AccessoryView Util


+ (UIView *)createAccessoryViewWithExeSel: (SEL ) exeSel withTarget: (id) tarObject withCancelSel: (SEL) cancelSel withExeBtnTag: (NSInteger ) exeTag
{
    
    UIView * tempView = [[UIView alloc ] initWithFrame: CGRectMake(0, 0, kScreenWidth,  50) ];
    tempView.backgroundColor = [ZheUtil colorWithHexString: @"#53C168" ];
    tempView.userInteractionEnabled = YES;
    
    UIButton * confirmBtn = [ZheUtil parseAccessoryBtnWithTitle: @"确定" withOriginX: kScreenWidth/2  ];
    [confirmBtn addTarget: tarObject action: exeSel forControlEvents: UIControlEventTouchUpInside ];
    if ( exeTag != 0) {
        confirmBtn.tag = exeTag;
    }
    
    [tempView addSubview: confirmBtn ];
    
    UIButton * cancelBtn = [ZheUtil parseAccessoryBtnWithTitle: @"取消" withOriginX: 0 ];
    
    [cancelBtn addTarget: tarObject action: cancelSel forControlEvents: UIControlEventTouchUpInside ];
    [tempView addSubview: cancelBtn ];
    
    return tempView;
}



+ (UIButton *) parseAccessoryBtnWithTitle: (NSString *) titleStr withOriginX: (CGFloat ) positionX
{
    UIButton * tempBtn = [UIButton buttonWithType: UIButtonTypeCustom ];
    tempBtn.frame = CGRectMake( positionX , 0, kScreenWidth/2, 50 ) ;
    tempBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [tempBtn setTitle: titleStr forState: UIControlStateNormal ];
    tempBtn.titleLabel.font = [UIFont systemFontOfSize: 15 ];
    [tempBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal ];


    return tempBtn;


}







#pragma mark - HEX Color  调 颜色

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



@end
