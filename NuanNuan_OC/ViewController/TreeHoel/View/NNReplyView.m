//
//  NNReplyView.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/10/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNReplyView.h"

@implementation NNReplyView

- (void)awakeFromNib {
    [super awakeFromNib];
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.cornerRadius = 15;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
