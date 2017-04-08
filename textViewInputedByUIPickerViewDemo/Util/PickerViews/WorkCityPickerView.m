//
//  PSCityPickerView.m
//  Diamond
//
//  Created by Pan on 15/8/12.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "WorkCityPickerView.h"


@interface WorkCityPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>


@property (nonatomic, copy, readwrite) NSString *province;

@property (nonatomic, copy) NSArray *allCityInfo;
@property (nonatomic, copy) NSArray *provinceArr;/**< 省名称数组*/
@property (nonatomic, copy) NSArray *cityArr;/**< 市名称数组*/
@property (nonatomic, copy) NSDictionary *currentProvinceDic;
@end

@implementation WorkCityPickerView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor whiteColor ];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    //包含2列
    return 2;
}

//该方法返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return [self.provinceArr count];
        case 1: return [self.cityArr count];
       
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = (UILabel *) view;
    if (!titleLabel)
    {
        titleLabel = [self labelForPickerView];
    }
    titleLabel.text = [self titleForComponent:component row:row];
    return titleLabel;
}

//选择指定列、指定列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        NSDictionary *provinceDic = self.allCityInfo[row];
        NSString * kProvince = [[provinceDic allKeys ] firstObject ];
        NSMutableArray * cityNames = [[NSMutableArray alloc] init ];
        for (NSString * cityName in provinceDic[kProvince]){
            [cityNames addObject: cityName ];
        }
        self.currentProvinceDic = provinceDic;
        self.cityArr = cityNames;
        self.province = [[provinceDic allKeys] firstObject ];
        self.city = [[cityNames firstObject ] valueForKey: @"name" ];
        NSNumber * cityIdNum = [[cityNames firstObject ] objectForKey: @"id" ];
        self.cityId = [cityIdNum stringValue ];
        [pickerView reloadAllComponents];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
    }else if (component == 1){
        self.province = [[self.currentProvinceDic allKeys] firstObject ];
        NSArray * curCities = self.currentProvinceDic[self.province];
        self.city = [curCities[row] valueForKey: @"name" ];
         NSNumber * cityIdNum = [curCities[row] objectForKey: @"id" ];
        self.cityId = [cityIdNum stringValue ];
    }
    
    
    if ([self.cityPickerDelegate respondsToSelector: @selector(cityPickerView:withFinishPickProvince:withCity:)])
    {
        [self.cityPickerDelegate cityPickerView: self withFinishPickProvince:self.province withCity: self.city];
    }
}

//指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    // 宽度
    return kScreenWidth/2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}


#pragma mark - Private
- (UILabel *)labelForPickerView
{
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth/2,  50 ) ];
    label.textColor = [UIColor colorWithRed:85/255 green:85/255 blue:85/255 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

- (NSString *)titleForComponent:(NSInteger)component row:(NSInteger)row;
{
    switch (component)
    {
        case 0: return self.provinceArr[row];
        case 1: return [self.cityArr[row] valueForKey: @"name" ];
        default: return @"";
    }
  
}




#pragma mark - Getter and Setter
- (NSArray *)allCityInfo
{
    if (!_allCityInfo)
    {
        NSBundle *bundle=[NSBundle mainBundle];
        NSString *path=[bundle pathForResource:@"workPlace" ofType:@"plist"];
        NSArray<NSDictionary *> * arrayOne = [[NSArray alloc]initWithContentsOfFile: path];
        
        NSMutableArray * termArray = [[NSMutableArray alloc ] init ];
        for (NSDictionary * dictProvince in arrayOne){
            NSDictionary * terminalDict = [[NSMutableDictionary alloc ] init ];
            NSString * provinceStr = dictProvince[@"name"];
            NSArray<NSDictionary *> * cityArrStr = dictProvince[@"items"];
            NSMutableArray * cityArrayRes = [[NSMutableArray alloc ] init ];
            for (NSDictionary * dictCity in cityArrStr){
                NSDictionary * dictC = @{@"name":dictCity[@"name"],
                                       @"id":dictCity[@"id"]
                                         };
                [cityArrayRes addObject: dictC ];
            }
            [terminalDict setValue: cityArrayRes forKey: provinceStr ];
            [termArray addObject: terminalDict ];
        }
        _allCityInfo = [termArray copy ];
  
    }
    return _allCityInfo;
}

- (NSArray *)provinceArr
{
    if (!_provinceArr)
    {
        NSMutableArray<NSString *> *temp = [[NSMutableArray alloc] init ];
        for (NSDictionary * eleProvince in self.allCityInfo){
            [temp addObject: [eleProvince.allKeys firstObject ] ];
           
        }
        _provinceArr = temp;
     
    }
    return _provinceArr;
}

- (NSArray *)cityArr
{
    
    if (!_cityArr){
        NSDictionary * provinceDic = self.allCityInfo[0];
        NSString * kDict = [provinceDic.allKeys firstObject ];
        NSMutableArray<NSString *> *tempArr = [[NSMutableArray alloc] init ];
        for (NSString * cityName in provinceDic[kDict]){
    
            [tempArr addObject: cityName ];
        }
        _cityArr = [tempArr copy ];
    
    }
    return _cityArr;

}

- (NSDictionary *)currentProvinceDic
{
    if (!_currentProvinceDic) {
        _currentProvinceDic = [self.allCityInfo firstObject ];
    }
    return _currentProvinceDic;
}

@end


