//
//  NNMineCommentQuestionAndAnswerCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/18.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNMineCommentQuestionAndAnswerCell.h"
#import "Define.h"
@implementation NNMineCommentQuestionAndAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.teacherHeadImageView.layer.masksToBounds = YES;
    self.teacherHeadImageView.layer.cornerRadius = 16;
    self.questionerHeadImageView.layer.masksToBounds = YES;
    self.questionerHeadImageView.layer.cornerRadius = 16;
    self.questionerHeadImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.questionerHeadImageView.clipsToBounds  = YES;
    self.teacherHeadImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.teacherHeadImageView.clipsToBounds  = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setQuestionAndAnswerCommentMode:(NNQuestionAndAnswerCommentModel *)questionAndAnswerCommentMode {
    NNQuestionAndAnswerModel *model = questionAndAnswerCommentMode.questionAndAnswerModelmodel;
    [self.teacherHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.teacherModel.teacherHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]options:SDWebImageAllowInvalidSSLCertificates];
    [self.questionerHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.questionHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]options:SDWebImageAllowInvalidSSLCertificates];
    self.questionerNameLabel.text = model.questionNickName;
    self.questLabel.preferredMaxLayoutWidth = NNAppWidth - 73;
    self.questLabel.text = model.questionContent;
    
    self.teacherNameLabel.text = model.teacherModel.teacherNickName;
    self.answerLabel.preferredMaxLayoutWidth = NNAppWidth - 73;
    self.answerLabel.text = model.questionAnswer;
    self.timeLabel.text = [NNTimeUtil timeDealWithTimeFromNow:model.questionCreateTime];
    self.answerNumLabel.text = model.questionCommentNum;
    
    self.likeNumLabel.text = model.questionGoodsNum;
    self.commentLabel.text = questionAndAnswerCommentMode.comment;
    self.likeButton.selected = model.isGood;
}

@end
