//
//  NNServerAppointmentCell.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/3.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNChooseView.h"

typedef void(^selectPayBlock)(NSString *payNums);

@interface NNServerAppointmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *defaultButton;

@property (weak, nonatomic) IBOutlet NNChooseView *chooseView;
@property (weak, nonatomic) IBOutlet UITextView *descributeTextView;
@property (copy, nonatomic) selectPayBlock payBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chooseViewConstraint;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
