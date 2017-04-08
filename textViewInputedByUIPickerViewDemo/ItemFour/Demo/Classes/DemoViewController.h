//
//  DemoViewController.h
//  Demo
//
//  Created by Alex Leutgöb on 17.01.11.
//  Copyright 2011 alexleutgoeb.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALPickerView.h"
#import "CYCustomMultiSelectPickerView.h"

@interface DemoViewController : UIViewController <CYCustomMultiSelectPickerViewDelegate> {
	NSArray *entries;
    NSArray *entriesSelected;
	NSMutableDictionary *selectionStates;
    UILabel *showLbl;
    
    CYCustomMultiSelectPickerView *multiPickerView;
}

@end
