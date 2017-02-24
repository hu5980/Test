//
//  NNAskingView.m
//  NuanNuan_OC
//
//  Created by hu5980 on 16/10/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNAskingView.h"

@implementation NNAskingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cancelAction:(UIButton *)sender {
    _block(sender.tag);
}

- (IBAction)askingAction:(UIButton *)sender {
    _block(sender.tag);
}
@end
