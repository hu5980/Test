//
//  NNPsychologicalTeacherHeaderView.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNPsychologicalTeacherHeaderView.h"

@implementation NNPsychologicalTeacherHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    _headimageView.layer.masksToBounds = YES;
    _headimageView.layer.cornerRadius = 20;
    _backgroundImageView.clipsToBounds = YES;
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (IBAction)popAction:(UIButton *)sender {
    _popblock();
}


@end
