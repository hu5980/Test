//
//  NNNeterReply.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNNeterReplyCell.h"
#import "UIImageView+WebCache.h"
#import "NNTimeUtil.h"
@implementation NNNeterReplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NNCommentModel *)model {
    _model = model;
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.commentHeaderUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageAllowInvalidSSLCertificates];
    self.nickNameLabel.text = model.commentNickName;
    self.commentContentLabel.text = model.commentContent;
    self.commentTImeLabel.text = [NNTimeUtil timeDealWithFormat:@"yyyy-MM-dd HH:mm:ss" andTime:model.commentCreateTime];
    self.likeNumLabel.text = model.commentGoodsNum;
}

- (IBAction)likeButtonAction:(UIButton *)sender {
    _likeCommentBlock(sender);
}

@end
