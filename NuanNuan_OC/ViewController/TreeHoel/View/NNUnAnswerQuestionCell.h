//
//  NNUnAnswerQuestionCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/13.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNQuestionAndAnswerModel.h"

@interface NNUnAnswerQuestionCell : UITableViewCell
@property (strong, nonatomic) NNQuestionAndAnswerModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end
