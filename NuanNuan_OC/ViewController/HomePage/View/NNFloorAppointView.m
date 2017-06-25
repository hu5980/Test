//
//  NNFloorAppointView.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/4.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNFloorAppointView.h"

@implementation NNFloorAppointView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)chooseProtocolAction:(UIButton *)sender {
    sender.selected = !sender.selected;
   
}

@end
