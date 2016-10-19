//
//  NNTreeHoelCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNTreeHoelCell.h"

@implementation NNTreeHoelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = 20;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
