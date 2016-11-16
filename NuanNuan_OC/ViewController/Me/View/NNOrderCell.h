//
//  NNOrderCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/15.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNOrderModel.h"

@interface NNOrderCell : UITableViewCell
@property (strong,nonatomic ) NNOrderModel *model;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderSexLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPhonoLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderContentLabel;

@end
