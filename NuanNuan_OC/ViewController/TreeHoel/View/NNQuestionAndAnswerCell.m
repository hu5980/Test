//
//  NNQuestionAndAnswerCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNQuestionAndAnswerCell.h"
#import "UIImageView+WebCache.h"
#import "NNTimeUtil.h"
#import "Define.h"
@implementation NNQuestionAndAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.teacherHeadImageView.layer.masksToBounds = YES;
    self.teacherHeadImageView.layer.cornerRadius = 16;
    self.teacherHeadImageView.clipsToBounds = YES;
    self.teacherHeadImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.questionerHeadImageView.layer.masksToBounds = YES;
    self.questionerHeadImageView.layer.cornerRadius = 16;
    self.questionerHeadImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.questionerHeadImageView.clipsToBounds  = YES;
    
    // Configure the view for the selected state
}

- (void)setModel:(NNQuestionAndAnswerModel *)model {
    _model = model;
    
    [self.teacherHeadImageView   sd_setImageWithURL:[NSURL URLWithString:model.teacherModel.teacherHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]options:SDWebImageAllowInvalidSSLCertificates];;
    
    [self.questionerHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.questionHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]options:SDWebImageAllowInvalidSSLCertificates];
    self.questionerNameLabel.text = model.questionNickName;
    self.questLabel.text = model.questionContent;
    self.questLabel.preferredMaxLayoutWidth = NNAppWidth -73;
    self.answerLabel.preferredMaxLayoutWidth = NNAppWidth -73;
    self.teacherNameLabel.text = model.teacherModel.teacherNickName;
    self.answerLabel.text = model.questionAnswer;
    self.timeLabel.text = [NNTimeUtil timeDealWithTimeFromNow:model.questionCreateTime];
    self.answerNumLabel.text = model.questionCommentNum;
    self.likeNumLabel.text = model.questionGoodsNum;
    
    self.likeButton.selected = model.isGood;
    
}
- (IBAction)likeAction:(UIButton *)sender {
    _likeBlock(sender);
}

- (IBAction)commentAction:(UIButton *)sender {
    _commentBlock();
}

+ (CGFloat) getuestionAndAnswerCellHeight:(NNQuestionAndAnswerModel *)model {
    
    return 10.1;
}


@end
