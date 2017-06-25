//
//  NNServerAppointmentCell.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/3.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNServerAppointmentCell.h"

@implementation NNServerAppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [_orderTableView registerNib:[UINib nibWithNibName:@"NNGoodsCell" bundle:nil] forCellReuseIdentifier:@"NNGoodsCell"];
    _orderTableView.scrollEnabled = NO;
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}





- (IBAction)chooseBuyAction:(UIButton *)sender {
    NSString *payNums;
     switch (sender.tag) {
        case 100:
            payNums = @"36";
            break;
        case 101:
             payNums = @"800";
            break;
        case 102:
             payNums = @"8000";
            break;
        default:
            break;
    }
    _payBlock(payNums);
}




@end
