//
//  NNSpitslotCell.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/10/22.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNSpitslotCell.h"

@implementation NNSpitslotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)praiseSpitslotAction:(UIButton *)sender {
    _block(sender.tag);
}
- (IBAction)commentSpitslotAction:(UIButton *)sender {
    _block(sender.tag);
}

@end
