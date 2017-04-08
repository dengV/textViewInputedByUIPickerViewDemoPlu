//
//  DemoViewController.m
//  Demo
//
//  Created by Alex Leutgöb on 17.01.11.
//  Copyright 2011 alexleutgoeb.com. All rights reserved.
//  

#import "DemoViewController.h"

@implementation DemoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Create some sample data
    //初始化一下数据，分别为 所有源数据，和 已经选中的数据
	entries = [[NSArray alloc] initWithObjects:@"Duke", @"ColorMark", @"●(り啩__唸り)●", @"zaza", @"Miss.Y'G先生",@"iOS 开发者_北京联盟",@"iZ",@"Code4App.com",nil];
    
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
    btn.frame = CGRectMake(20, 50, 280, 50);
    [btn setTitle:@"展示PickerView多选功能" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    showLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 280, 190)];
    showLbl.backgroundColor = [UIColor lightGrayColor];
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
    entriesSelected = [[NSArray arrayWithArray:selectedEntriesArr] retain];
}

- (void)dealloc {
	
	[selectionStates release];
	[entries release];
    [showLbl release];
    
    [super dealloc];
}


@end
