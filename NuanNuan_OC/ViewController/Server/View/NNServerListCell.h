//
//  NNServerListCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/20.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNSuccessCaseModel.h"
@interface NNServerListCell : UITableViewCell

@property (nonatomic,strong) NNSuccessCaseModel *caseMode;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIView *apaleView;
@property (weak, nonatomic) IBOutlet UILabel *packageNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *packageDescributeLabel;
@end
