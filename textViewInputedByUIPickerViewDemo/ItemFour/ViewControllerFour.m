//
//  ViewControllerFour.m
//  textViewInputedByUIPickerViewDemo
//
//  Created by dengzheyibu on 2017/4/8.
//  Copyright © 2017年 dengzheyibu. All rights reserved.
//

#import "ViewControllerFour.h"
#import "ALPickerView.h"
#import "CYCustomMultiSelectPickerView.h"
@interface ViewControllerFour ()<CYCustomMultiSelectPickerViewDelegate>


@property (nonatomic, strong) NSArray * allCityInfo;

@end

@implementation ViewControllerFour


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWhenNaviHiddenViewWithTitle: @"Github alexleutgoeb/ALPickerView" withTypeMode: kBaseTypeModeNormal ];
    // Create some sample data
    //初始化一下数据，分别为 所有源数据，和 已经选中的数据
    entries = self.allCityInfo;
    
    entriesSelected = [[NSArray alloc] initWithObjects: @"",nil];
    
    
    selectionStates = [[NSMutableDictionary alloc] init];
    
    // 配置是否选中状态
    for (NSString *key in entries){
        BOOL isSelected = NO;
        for (NSString *keyed in entriesSelected) {
            if ([key isEqualToString:keyed]) {
                isSelected = YES;
            }
        }
        [selectionStates setObject:[NSNumber numberWithBool:isSelected] forKey:key];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 55, 280, 50);
    [btn setTitle:@"Click, then input" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    showLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 280, 190)];
    showLbl.layer.borderColor = [[UIColor redColor ] CGColor ];
    showLbl.layer.borderWidth = 1;
    showLbl.backgroundColor = [UIColor whiteColor];
    showLbl.numberOfLines = 0;
    showLbl.adjustsFontSizeToFitWidth = YES;
    showLbl.contentMode = UIControlContentVerticalAlignmentTop;
    
    [self.view addSubview:showLbl];
    
}

-(void)getData
{
    //点击后删除之前的PickerView
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CYCustomMultiSelectPickerView class]]) {
            [view removeFromSuperview];
        }
    }
    
    multiPickerView = [[CYCustomMultiSelectPickerView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 260-20, 320, 260+44)];
    
    //  multiPickerView.backgroundColor = [UIColor redColor];
    multiPickerView.entriesArray = entries;
    multiPickerView.entriesSelectedArray = entriesSelected;
    multiPickerView.multiPickerDelegate = self;
    
    [self.view addSubview:multiPickerView];
    
    [multiPickerView pickerShow];
    
}

#pragma mark - Delegate
//获取到选中的数据
-(void)returnChoosedPickerString:(NSMutableArray *)selectedEntriesArr
{
    NSLog(@"selectedArray=%@",selectedEntriesArr);
    
    NSString *dataStr = [selectedEntriesArr componentsJoinedByString:@"\n"];
    
    showLbl.text = dataStr;
    // 再次初始化选中的数据
    entriesSelected = [NSArray arrayWithArray:selectedEntriesArr] ;
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
            NSString * provinceStr = dictProvince[@"name"];
            [termArray addObject: provinceStr ];
        }
        _allCityInfo = [termArray copy ];
        
    }
    return _allCityInfo;
}


@end
