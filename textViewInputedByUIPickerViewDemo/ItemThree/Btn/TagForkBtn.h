//
//  TagForkBtn.h
//  TheStep
//
//  Created by dengzheyibu on 2017/3/30.
//  Copyright © 2017年 邓江洲. All rights reserved.
//



@interface TagForkBtn : UIView
@property (nonatomic, strong) void(^forkCityBlock)(void);


- (instancetype) initWithTitle: (NSString *) title;
@end
