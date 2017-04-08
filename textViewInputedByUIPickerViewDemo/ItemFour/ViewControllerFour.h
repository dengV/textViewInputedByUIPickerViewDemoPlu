//
//  ViewControllerFour.h
//  textViewInputedByUIPickerViewDemo
//
//  Created by dengzheyibu on 2017/4/8.
//  Copyright © 2017年 dengzheyibu. All rights reserved.
//

#import "BaseWhenNaviHiddenViewController.h"

@class CYCustomMultiSelectPickerView;

@interface ViewControllerFour : BaseWhenNaviHiddenViewController {
    NSArray *entries;
    NSArray *entriesSelected;
    NSMutableDictionary *selectionStates;
    UILabel *showLbl;
    
    CYCustomMultiSelectPickerView *multiPickerView;
}

@end
