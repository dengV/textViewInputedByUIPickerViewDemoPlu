//
//  ProDreamViewController.m
//  TheStep
//
//  Created by dengzheyibu on 2017/1/18.
//  Copyright © 2017年 邓江洲. All rights reserved.
//

#import "ViewControllerOne.h"
#import "WorkCityPickerView.h"
#import "YYText.h"

#import "UIView+YYAdd.h"
#import "YYTextExampleHelper.h"

static NSString * const kByBtnCityStr = @"北京";
static NSString * const kByBtnCityId = @"1001";


@interface ViewControllerOne ()< WorkCityPickerViewDelegate, YYTextViewDelegate >

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) WorkCityPickerView * cityPickerView;
@property (nonatomic, strong) YYTextView * cityTextView;

@property (nonatomic, strong) YYTextBorder * cityBorder;
@property (nonatomic, strong) NSAttributedString * tempCityStr;
//[self parseYYString: city] current

@property (nonatomic, strong) NSMutableAttributedString * resultCityStr;
//self.cityTextView.attributedText，show

@property (nonatomic, strong) NSMutableString * addCityIdStr;
//  upload city args

@property (nonatomic, assign) NSInteger holdFlag;

@end

@implementation ViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWhenNaviHiddenViewWithTitle: @"YYText + UIPickerView" withTypeMode: kBaseTypeModeNormal ];
    
    [self assistantProDreamRsmUI ];
}

- (void) assistantProDreamRsmUI
{
    UITapGestureRecognizer * tapEn = [[UITapGestureRecognizer alloc ] initWithTarget: self action: @selector(tapEnRespond) ];
    [self.containerView addGestureRecognizer: tapEn ];

    
    UIView * cityAccessoryView = [ZheUtil createAccessoryViewWithExeSel: @selector(confirmChoice)  withTarget:self withCancelSel: @selector(deleteAll)  withExeBtnTag: 0 ];
    
#pragma mark  self.cityTextView
    self.cityTextView = [[YYTextView alloc ] initWithFrame: CGRectMake(110, 115, 245, 30) ];
    self.cityTextView.layer.borderColor = [UIColor blackColor ].CGColor;
    self.cityTextView.layer.borderWidth = 2;
    self.cityTextView.delegate = self;
    self.cityTextView.inputAccessoryView = cityAccessoryView;
    self.cityTextView.inputView = self.cityPickerView;
    self.cityTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

    UITapGestureRecognizer * cityTextViewTap = [[UITapGestureRecognizer alloc ] initWithTarget: self action: @selector(tapCityTxtVw) ];
    [self.cityTextView addGestureRecognizer: cityTextViewTap ];
    [self.containerView addSubview: self.cityTextView ];
 
    self.holdFlag = -1;
    self.resultCityStr = [[NSMutableAttributedString alloc ] init ];
    self.addCityIdStr = [[NSMutableString alloc ] initWithCapacity: 50 ];
}

#pragma mark Action inputAccessoryView

- (void)deleteAll
{
    NSAttributedString * emptyStr = [[NSAttributedString alloc ] initWithString: @"" ];
    [self.resultCityStr setAttributedString: emptyStr ];
    self.cityTextView.attributedText = nil;
    [self.addCityIdStr setString: @""] ;
}


- (void) confirmChoice
{
    self.holdFlag = 1;
    if(!self.tempCityStr){
        self.resultCityStr = [self parseYYString: kByBtnCityStr] ;
        [self.addCityIdStr appendString: kByBtnCityId ];
    }
    [self.cityTextView resignFirstResponder ];
}

#pragma mark Editing Assist

- (void) tapCityTxtVw
{
    [self.cityTextView becomeFirstResponder ];
}

- (void)tapEnRespond
{
    [self.view endEditing: YES ];
}

#pragma mark YYText Parse
- (NSMutableAttributedString *) parseYYString: (NSString *) contentStr
{
    NSMutableAttributedString *tagText = [[NSMutableAttributedString alloc] initWithString: contentStr];
    [tagText yy_insertString:@"   " atIndex:0];
    [tagText yy_appendString:@"   "];
    tagText.yy_font = [UIFont boldSystemFontOfSize: 15];
    tagText.yy_color = [UIColor whiteColor];
    [tagText yy_setTextBinding:[YYTextBinding bindingWithDeleteConfirm:NO] range:tagText.yy_rangeOfAll];
    [tagText yy_setTextBackgroundBorder: self.cityBorder range: [tagText.string rangeOfString: contentStr ]  ];
    tagText.yy_lineSpacing = 10;
    tagText.yy_lineBreakMode = NSLineBreakByWordWrapping ;
    return tagText;
    

}

#pragma mark text view Delegate

- (void)textViewDidEndEditing:(YYTextView *)textView {
    unsigned long num = textView.attributedText.string.length;
    if (num>32 ) {
            CGRect tempframe = self.cityTextView.frame;
            tempframe.size.height = 60;
            self.cityTextView.frame = tempframe;
        
        }else if (num<32 ){
            CGRect tempframe = self.cityTextView.frame;
            tempframe.size.height = 30;
            self.cityTextView.frame = tempframe;
            
        }
    if(self.holdFlag == 1 && self.tempCityStr && ![self.resultCityStr.string containsString: self.tempCityStr.string ]){
        [self.resultCityStr appendAttributedString: self.tempCityStr ];
        [self.addCityIdStr appendString: @"," ];
        [self.addCityIdStr appendString: self.cityPickerView.cityId ];
    }
    self.cityTextView.attributedText = self.resultCityStr;
    self.holdFlag = -1;
    
}

#pragma mark - City Picker delegate Action

- (void) cityPickerView:(WorkCityPickerView *)picker withFinishPickProvince:(NSString *)province withCity:(NSString *)city
{
    self.tempCityStr = [self parseYYString: city];
    [self.resultCityStr appendAttributedString: self.tempCityStr];
    self.cityTextView.attributedText = self.resultCityStr;
    [self.resultCityStr deleteCharactersInRange: [self.resultCityStr.string rangeOfString: self.tempCityStr.string ] ];
}


#pragma mark - Getter


- (WorkCityPickerView *)cityPickerView
{
    if(!_cityPickerView){
        _cityPickerView = [[WorkCityPickerView alloc ] init ];
        _cityPickerView.cityPickerDelegate = self;
    }
    return _cityPickerView;
}


#pragma mark cityBorder
- (YYTextBorder *)cityBorder
{
    if(!_cityBorder){
        YYTextBorder * border = [YYTextBorder new ];
        border.strokeWidth = 1.5;
        border.strokeColor = UIColorHex(54bc2e);
        border.fillColor = UIColorHex(76c957);
        border.cornerRadius = 100; // a huge value
        border.lineJoin = kCGLineJoinBevel;
        border.insets = UIEdgeInsetsMake(-2, -5.5, -2, -8);
        _cityBorder = border;
    }
    return _cityBorder;
}

@end
