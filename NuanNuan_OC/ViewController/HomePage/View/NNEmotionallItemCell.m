//
//  NNEmotionallItemCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionallItemCell.h"
#import "UIImageView+WebCache.h"


@implementation NNEmotionallItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    _bgView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
    // Configure the view for the selected state
}

- (void)setModel:(NNSuccessCaseModel *)model {
    if (_model == nil) {
         _model = model;
    }
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:model.caseImageUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageRefreshCached | SDWebImageContinueInBackground |SDWebImageAllowInvalidSSLCertificates];
    
    _emotionTitleLabel.text = model.caseTitle;
    _readNumLabel.text = [NSString stringWithFormat:@"%ld",model.caseClickNum];
    _likeNumLabel.text = [NSString stringWithFormat:@"%ld",model.caseGoodsNum];
    _likeButton.selected = model.hasGood;
}

- (IBAction)likeAction:(UIButton *)sender {
    _block(_model);
}
@end
