//
//  NNQuestionAndAnswerCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNQuestionAndAnswerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *questionerHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *questionerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *questLabel;

@property (weak, nonatomic) IBOutlet UIImageView *teacherHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeNumLabel;
@end
