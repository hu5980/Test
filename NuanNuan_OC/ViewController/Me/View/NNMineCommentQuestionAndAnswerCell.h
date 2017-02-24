//
//  NNMineCommentQuestionAndAnswerCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/18.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNQuestionAndAnswerCommentModel.h"
#import "UIImageView+WebCache.h"
#import "NNTimeUtil.h"
@interface NNMineCommentQuestionAndAnswerCell : UITableViewCell


@property (strong,nonatomic) NNQuestionAndAnswerCommentModel *questionAndAnswerCommentMode;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *questionerHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *questionerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *questLabel;

@property (weak, nonatomic) IBOutlet UIImageView *teacherHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *teacherNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end
