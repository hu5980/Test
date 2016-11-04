//
//  NNTreeHoelCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNTreeHoelCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "UIImage+AFNetworking.h"

@implementation NNTreeHoelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = 20;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setModel:(NNEmotionTeacherModel *)model{
    [self.backgroundImageView setImageWithURL:[NSURL URLWithString:model.backgroundImageUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.teacherHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
    self.ninkNameLabel.text = model.teacherNickName;
    self.specialityLabel.text = model.teacherTypeName;
    self.questionNumLabel.text = [NSString stringWithFormat:@"%@提问",model.teacherQuestionNum];
    self.expertIntroductionLabel.text = model.teacherDescription;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
