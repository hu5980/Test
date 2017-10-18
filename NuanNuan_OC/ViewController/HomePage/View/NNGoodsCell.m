//
//  NNGoodsCell.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNGoodsCell.h"

@implementation NNGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)chooseGoodsAction:(UIButton *)sender {
    
}

- (void)setModel:(NNOrderServerModel *)model {
    _model = model;
    _goodsNameLabel.text = model.orderTitle;
    _lastPriceLabel.text = [NSString stringWithFormat:@"%@元／次",model.orderPrice];
    _goodsPricesLabel.text = [NSString stringWithFormat:@"%@元／次",model.g_discount_price];
}
- (IBAction)changeGoodsAction:(UIButton *)sender {
    _chooseBlock(_model.orderServerId,_chooseButton,_model.g_discount_price,_model.orderTitle);
}

@end
