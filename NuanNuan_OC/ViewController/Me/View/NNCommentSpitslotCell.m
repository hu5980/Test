//
//  NNCommentSpitslotCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/18.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNCommentSpitslotCell.h"
#import "NNImageBroswerView.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "NNTimeUtil.h"

@implementation NNCommentSpitslotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 16.f;
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImageView.clipsToBounds  = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSpitslotCommentModel:(NNSpitslotCommentModel *)spitslotCommentModel {
    _spitslotCommentModel = spitslotCommentModel;
    NNTreeHoelModel *model = spitslotCommentModel.treeHoelModel;
    self.timelabel.text = [NNTimeUtil timeDealWithFormat:@"yyyy-MM-dd dd:mm" andTime:model.createTime];
    if (model.userNikeName.length == 0 || model.userNikeName == nil ) {
        self.nickNameLabel.text = [NSString stringWithFormat:@"暖暖用户%@",model.uid];
    }else{
        self.nickNameLabel.text = model.userNikeName;
    }
    self.commentLabel.text = spitslotCommentModel.comment;
    self.commentNumLabel.text = model.thCommentNum;
    self.bePraisedLabel.text = model.thGoodsNum;
    if ([model.userNikeName isEqualToString:@"匿名用户"] ) {
        [self.headImageView setImage:[UIImage imageNamed:@"400_05"]];
    }else{
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.userHeadUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageRefreshCached |SDWebImageAllowInvalidSSLCertificates];
    }
    self.contentLabel.text = model.thContent;
    self.commentLabel.preferredMaxLayoutWidth = NNAppWidth - 30;
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

@end
