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
    _apaleView.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.3];;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCaseMode:(NNSuccessCaseModel *)caseMode {
    _caseMode = caseMode;
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:caseMode.caseImageUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
    _packageNameLabel.text = [NSString stringWithFormat:@"-%@-",caseMode.caseName];
    _packageDescributeLabel.text = caseMode.caseTitle;
}

@end
