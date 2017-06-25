//
//  NNGoodsCell.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNOrderServerModel.h"

typedef void(^chooseGoodsBlock)(NSString *goodsID ,UIButton *button,NSString *money,NSString *goodsName);

@interface NNGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPricesLabel;
@property (copy, nonatomic) NNOrderServerModel *model;
@property (copy, nonatomic) chooseGoodsBlock chooseBlock;

@end
