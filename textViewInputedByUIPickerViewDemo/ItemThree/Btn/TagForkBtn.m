//
//  TagForkBtn.m
//  TheStep
//
//  Created by dengzheyibu on 2017/3/30.
//  Copyright © 2017年 邓江洲. All rights reserved.
//

#import "TagForkBtn.h"

@interface TagForkBtn()
@property (nonatomic, strong ) UILabel * cityLabel;
@property (nonatomic, strong ) UIButton * forkBtn;
@end

@implementation TagForkBtn

- (instancetype) initWithTitle: (NSString *) title
{
   if(self = [super init ]){
        _cityLabel = [[UILabel alloc ] init];
        _cityLabel.text = title;
        _cityLabel.userInteractionEnabled = YES;
        _cityLabel.textColor = [UIColor blueColor ];
        [self addSubview: _cityLabel ];

        [_forkBtn addTarget: self action: @selector(forkTheCity:) forControlEvents: UIControlEventTouchUpInside ];
        _forkBtn = [[UIButton alloc ] init ];
        [_forkBtn setImage: [UIImage imageNamed: @"loginForkIcon"] forState: UIControlStateNormal ];
        [self addSubview: _forkBtn ];
        
   }
    return self;
}


- (void)forkTheCity: (UIButton *) btn
{
    if(self.forkCityBlock){
        self.forkCityBlock();
    }
}



-(void)layoutSubviews {
    [super layoutSubviews];
    [_cityLabel sizeToFit ];

    CGRect tempRectForkBtn = CGRectMake(_cityLabel.frame.origin.x + _cityLabel.frame.size.width + 7, _cityLabel.center.y-11 , 22, 22);
    _forkBtn.frame = tempRectForkBtn;
    
}

@end
