//
//  NNUnAnswerQuestionCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/13.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNUnAnswerQuestionCell.h"
#import "UIImageView+WebCache.h"

@implementation NNUnAnswerQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 16;
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImageView.clipsToBounds  = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NNQuestionAndAnswerModel *)model {
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.questionHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]options:SDWebImageAllowInvalidSSLCertificates];
    self.nickNameLabel.text = model.questionNickName;
    self.questionLabel.text = model.questionContent;
    
}


@end
