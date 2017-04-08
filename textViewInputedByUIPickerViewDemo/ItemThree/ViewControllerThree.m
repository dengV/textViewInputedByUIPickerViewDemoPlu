//
//  CareerIdealViewController.m
//  TheStep
//
//  Created by dengzheyibu on 2016/12/16.
//  Copyright © 2016年 邓江洲. All rights reserved.
//

#import "ViewControllerThree.h"
#import "WorkCityPickerView.h"
#import "Masonry.h"

#import "TagForkBtn.h"


static NSInteger const kLeftCityMargin = 40;
@interface ViewControllerThree ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *cityNameTextField;
@property (nonatomic, strong) WorkCityPickerView * workCityPickView;

@property (nonatomic, assign) NSInteger objectId;
@property (nonatomic, strong) TagForkBtn * lastBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cityNameTextFieldHeight;




@end

@implementation ViewControllerThree

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configWhenNaviHiddenViewWithTitle: @"Code Btn" withTypeMode: kBaseTypeModeNormal ];
    
    
    UITapGestureRecognizer * tapEndEdi = [[UITapGestureRecognizer alloc ] initWithTarget: self action: @selector(tapContainerViewEndEdi) ];
    [self.containerView addGestureRecognizer: tapEndEdi ];
    
    self.cityNameTextField.inputView = self.workCityPickView;
    UIView * cityNameAccessoryView = [ZheUtil createAccessoryViewWithExeSel: @selector(confirmChoiceOrCancelCareer: )  withTarget:self withCancelSel: @selector(confirmChoiceOrCancelCareer: )  withExeBtnTag: 13 ];
    self.cityNameTextField.inputAccessoryView = cityNameAccessoryView;
    
  
}



#pragma mark - target Action

- (void) confirmChoiceOrCancelCareer: (UIButton *) tempBtn
{
    self.cityNameTextField.text = @" ";
    if(!self.workCityPickView.cityId){
        self.workCityPickView.city = @"北京" ;
    }
    
    TagForkBtn * btn = [[TagForkBtn alloc ] initWithTitle: self.workCityPickView.city];
    
    NSInteger countNum = self.cityNameTextField.subviews.count;
    __weak typeof(self) blockSelf = self;
    [self.cityNameTextField addSubview: btn ];
    __weak typeof(btn) blockBtn = btn;
    btn.forkCityBlock = ^{
        [blockBtn removeFromSuperview ];
    };
    self.cityNameTextFieldHeight.constant = 35 * (countNum/4+1);
    if (self.lastBtn) {
        if ((countNum-2) % 3 == 0 ) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(blockSelf.cityNameTextField).offset(kLeftCityMargin);;
                make.height.mas_equalTo(blockSelf.lastBtn.mas_height);
                make.top.mas_equalTo(blockSelf.lastBtn.mas_bottom).offset(7);
            }];
            // if (countNum>7)
        }else{
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(blockSelf.lastBtn.mas_right).offset(75);// What
                make.top.mas_equalTo(blockSelf.lastBtn.mas_top);
                make.height.mas_equalTo(blockSelf.lastBtn.mas_height);
                
            } ];
        }
        //if (self.lastBtn)
    }else{
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(blockSelf.cityNameTextField).offset(kLeftCityMargin);;
            make.top.mas_equalTo(blockSelf.cityNameTextField).offset(7);;
            make.height.mas_equalTo(18);
            
        } ];
        
    }
    self.lastBtn = btn;
    [self tapContainerViewEndEdi ];
}


- (void) tapContainerViewEndEdi
{
    [self.view endEditing: YES ];
}


#pragma mark - Getter

- (WorkCityPickerView *)workCityPickView
{
    if(!_workCityPickView){
        _workCityPickView = [[WorkCityPickerView alloc ] init ];
    }
    return _workCityPickView;
    
}

@end
