//
//  NNSpitslotCell.m
//  NuanNuan_OC
//
//  Created by hu5980 on 16/10/22.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNSpitslotCell.h"
#import "NNImageBroswerView.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "NNTimeUtil.h"

@implementation NNSpitslotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 16.f;
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImageView.clipsToBounds  = YES;
}

- (void)setModel:(NNTreeHoelModel *)model {
    _model = model;
    self.timelabel.text = [NNTimeUtil timeDealWithFormat:@"yyyy-MM-dd HH:mm" andTime:model.createTime];
    if (_model.userNikeName.length == 0 || _model.userNikeName == nil ) {
        self.nickNameLabel.text = [NSString stringWithFormat:@"暖暖情感用户%@",model.uid];
    }else{
        self.nickNameLabel.text = _model.userNikeName;
    }
    self.commentNumLabel.text = _model.thCommentNum;
    self.bePraisedLabel.text = _model.thGoodsNum;
    if ([model.userNikeName isEqualToString:@"匿名用户"] ) {
        [self.headImageView setImage:[UIImage imageNamed:@"400_05"]];
    }else{
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.userHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageRefreshCached |SDWebImageAllowInvalidSSLCertificates];
    }
    self.contentLabel.text = model.thContent;
    self.contentLabel.preferredMaxLayoutWidth = NNAppWidth - 30;
    NNImageBroswerView *broswerImageView = [[NNImageBroswerView alloc] initWithFrame:CGRectMake(0, 0,NNAppWidth, 0) ImageUrls:model.picArrays SpaceWithImage:10 SpaceWithSideOfSuperView:15 NumberImageOfLine:3];
    self.broswerViewConstraint.constant = broswerImageView.broswerViewHeight;
    
    __weak selectImageIndexPath weakSelectImageBlock = _selectImageBlock;
    broswerImageView.block = ^(NSInteger indexPath){
        weakSelectImageBlock(indexPath);
    };
    
    for (UIView *view in self.broswerView.subviews) {
        [view removeFromSuperview];
    }
    self.likeButton.selected = model.isGood;
    [self.broswerView addSubview:broswerImageView];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (IBAction)praiseSpitslotAction:(UIButton *)sender {
    _block(sender);
}
- (IBAction)commentSpitslotAction:(UIButton *)sender {
    _block(sender);
}

@end
