//
//  PSCityPickerView.h
//  Diamond
//
//  Created by Pan on 15/8/12.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WorkCityPickerView;
@protocol WorkCityPickerViewDelegate <NSObject>
NS_ASSUME_NONNULL_BEGIN
- (void)cityPickerView: (WorkCityPickerView *)picker withFinishPickProvince: (NSString *)province withCity: (NSString *)city;

@end


@interface WorkCityPickerView : UIPickerView

@property (nonatomic, weak, nullable) id<WorkCityPickerViewDelegate> cityPickerDelegate;
@property (nonatomic, copy, readwrite) NSString *city;
@property (nonatomic, copy, readwrite) NSString *cityId;
NS_ASSUME_NONNULL_END

@end
