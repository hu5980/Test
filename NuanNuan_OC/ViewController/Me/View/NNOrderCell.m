//
//  NNOrderCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/15.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNOrderCell.h"

@implementation NNOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NNOrderModel *)model {
    _model = model;
    _orderNumLabel.text = model.orderID;
    _orderSexLabel.text = model.orderSex;
    _orderTimeLabel.text = model.orderTime;
    _orderTypeLabel.text = model.orderType;
    _orderTypeLabel.preferredMaxLayoutWidth = NNAppWidth - 150 ;
    _orderPhonoLabel.text = model.orderTelephone;
    _orderContentLabel.text = model.orderContent;
    _orderContentLabel.preferredMaxLayoutWidth = NNAppWidth - 150 ;
    _orderNickNameLabel.text = model.orderUserName;
}

@end
