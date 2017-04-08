//
//  UILabel+Util.m
//  TheStep
//
//  Created by dengzheyibu on 2016/12/11.
//  Copyright © 2016年 邓江洲. All rights reserved.
//

#import "UILabel+Util.h"

@implementation UILabel (Util)

+ (UILabel *)createNavigationTitleLabelZheWithFrame: (CGRect) frame withTitle: (NSString *) title
{
    UILabel * navigationLabel = [[UILabel alloc ] initWithFrame: frame ];
    navigationLabel.font = [UIFont systemFontOfSize: 18 ];
    navigationLabel.text = title;
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    if([title isEqualToString: @"我的简历" ]){
        
        navigationLabel.textColor = [UIColor whiteColor ];
        
    }else{
        navigationLabel.textColor = [ZheUtil colorWithHexString: @"#333333" ];
    }
    return navigationLabel;
}




@end
