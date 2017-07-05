//
//  NNOrderCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/15.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNOrderModel.h"
#import "Define.h"
@interface NNOrderCell : UITableViewCell
@property (strong,nonatomic ) NNOrderModel *model;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderSexLabel;

;

@property (weak, nonatomic) IBOutlet UILabel *weChatLabel;
@property (weak, nonatomic) IBOutlet UILabel *merryLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@end
