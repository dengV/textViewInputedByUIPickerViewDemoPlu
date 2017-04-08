//
//  CareerIdealViewController.m
//  TheStep
//
//  Created by dengzheyibu on 2016/12/16.
//  Copyright © 2016年 邓江洲. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "WorkCityPickerView.h"
#import "Masonry.h"
#import "SKTagView.h"

@interface ViewControllerTwo ()<WorkCityPickerViewDelegate  >

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) NSArray * tagColors;
@property (weak, nonatomic) IBOutlet UITextField *cityNameTextField;

@property (nonatomic, strong) WorkCityPickerView * workCityPickView;
@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, assign) NSInteger objectId;


@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWhenNaviHiddenViewWithTitle: @"use TagView" withTypeMode: kBaseTypeModeNormal ];
    UITapGestureRecognizer * tapEndEdi = [[UITapGestureRecognizer alloc ] initWithTarget: self action: @selector(tapContainerViewEndEdi) ];
    [self.containerView addGestureRecognizer: tapEndEdi ];
    
    [self  setupTagView ];
    self.cityNameTextField.inputView = self.workCityPickView;
    UIView * cityNameAccessoryView = [ZheUtil createAccessoryViewWithExeSel: @selector(confirmChoiceOrCancelCareer: )  withTarget:self withCancelSel: @selector(confirmChoiceOrCancelCareer: )  withExeBtnTag: 13 ];
    self.cityNameTextField.inputAccessoryView = cityNameAccessoryView;
}



#pragma mark - target Action

- (void) confirmChoiceOrCancelCareer: (UIButton *) tempBtn
{

    if(!self.workCityPickView.cityId){
        self.workCityPickView.city = @"北京" ;
    }
    SKTag *tag = [SKTag tagWithText: self.workCityPickView.city ];
    tag.textColor = [UIColor whiteColor];
    tag.fontSize = 15;
    tag.enable = YES;
    tag.padding = UIEdgeInsetsMake(3, 3, 3, 3);
    tag.bgColor = [ZheUtil colorWithHexString: self.tagColors[arc4random() % self.tagColors.count] ];
    tag.cornerRadius = 5;
    [self.tagView addTag:tag];
    [self tapContainerViewEndEdi ];


}






- (void) tapContainerViewEndEdi
{
    [self.view endEditing: YES ];
}


#pragma mark - Picker delegate Action

- (void) cityPickerView:(WorkCityPickerView *)picker withFinishPickProvince:(NSString *)province withCity:(NSString *)city
{
    self.cityNameTextField.text = city ;
    
}


#pragma mark - Getter

- (WorkCityPickerView *)workCityPickView
{
    if(!_workCityPickView){
        _workCityPickView = [[WorkCityPickerView alloc ] init ];
        _workCityPickView.cityPickerDelegate = self;
        
    }
    return _workCityPickView;
    
}



#pragma mark - Private Method

- (void)setupTagView {
    self.tagColors = @[@"#7ecef4"];
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        view.backgroundColor = [UIColor whiteColor];
        view.padding = UIEdgeInsetsMake(6, 6, 6, 6);
        view.interitemSpacing = 8;
        view.lineSpacing = 8;
        __weak SKTagView *weakView = view;
        view.didTapTagAtIndex = ^(NSUInteger index){
            [weakView removeTagAtIndex:index];
        };
        view;
    });
    [self.view addSubview:self.tagView];
    __weak typeof(self ) weakSelf = self;
    [self.tagView mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.cityNameTextField.mas_top);
        make.leading.equalTo(weakSelf.cityNameTextField.mas_trailing);
        make.trailing.equalTo(weakSelf.containerView.mas_trailing).offset(-10);
    }];
    
    
}


@end
