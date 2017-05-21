//
//  NNEmotionalItemCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionalItemCell.h"
#import "Define.h"
@implementation NNEmotionalItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (NNAppWidth > 375) {
        _leftConstraint.constant = 80;
        _rightConstraint.constant = 80;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)marriageAndFamilyAction:(UIButton *)sender {
    _eblock(marriageAndFamily);
}

- (IBAction)EmotionalSaveAction:(UIButton *)sender {
    _eblock(emotionalSave);
}
- (IBAction)selfImprovementAction:(id)sender {
    _eblock(selfImprovement);
}
@end
