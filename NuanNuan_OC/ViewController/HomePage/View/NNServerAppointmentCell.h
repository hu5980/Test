//
//  NNServerAppointmentCell.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/3.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNChooseView.h"
#import "NNGoodsCell.h"


typedef void(^selectPayBlock)(NSString *payNums);

@interface NNServerAppointmentCell : UITableViewCell



//@property (copy, nonatomic) selectPayBlock payBlock;

@property (nonatomic, nonatomic) IBOutlet UITableView *orderTableView;
@property (nonatomic,strong) NSArray *goodsArrays;
@end
