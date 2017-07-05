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


 
    _merryLabel.text = model.merry;
    _orderNickNameLabel.text = model.orderUserName;
    _weChatLabel.text = model.wechat;
    _ageLabel.text = model.age;
    _orderTypeLabel.text = model.orderContent;

}

@end
