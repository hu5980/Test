//
//  NNServerListCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/20.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNServerListCell.h"
#import "UIImageView+WebCache.h"

@implementation NNServerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _apaleView.backgroundColor =  [UIColor clearColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.clipsToBounds = YES;
    // Configure the view for the selected state
}

- (void)setCaseMode:(NNSuccessCaseModel *)caseMode {
    _caseMode = caseMode;
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:caseMode.caseImageUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageAllowInvalidSSLCertificates];
    _packageNameLabel.text = caseMode.caseTitle;
    _packageDescributeLabel.text =  [NSString stringWithFormat:@"-%@-",caseMode.caseName];
}

@end
