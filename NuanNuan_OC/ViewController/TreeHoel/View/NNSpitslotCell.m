//
//  NNSpitslotCell.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/10/22.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNSpitslotCell.h"
#import "NNImageBroswerView.h"
#import "Define.h"
#import "UIImageView+WebCache.h"

@implementation NNSpitslotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(NNTreeHoelModel *)model {

    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.userHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageRefreshCached];
    self.contentLabel.text = model.thContent;
    NNImageBroswerView *broswerImageView = [[NNImageBroswerView alloc] initWithFrame:CGRectMake(0, 0,NNAppWidth, 0) ImageUrls:model.picArrays SpaceWithImage:10 SpaceWithSideOfSuperView:15 NumberImageOfLine:3];
    self.broswerViewConstraint.constant = broswerImageView.broswerViewHeight;
    
    for (UIView *view in self.broswerView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.broswerView addSubview:broswerImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)praiseSpitslotAction:(UIButton *)sender {
    _block(sender.tag);
}
- (IBAction)commentSpitslotAction:(UIButton *)sender {
    _block(sender.tag);
}

@end
