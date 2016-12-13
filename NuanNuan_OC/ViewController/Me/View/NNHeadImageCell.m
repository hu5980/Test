//
//  NNHeadImageCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/30.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNHeadImageCell.h"

@implementation NNHeadImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 30;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
