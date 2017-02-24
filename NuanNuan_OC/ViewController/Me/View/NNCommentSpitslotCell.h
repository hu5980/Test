//
//  NNCommentSpitslotCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/18.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNTreeHoelModel.h"
#import "NNSpitslotCommentModel.h"
@interface NNCommentSpitslotCell : UITableViewCell

//typedef void(^spitslotActionBlock)(UIButton *button);

typedef void(^selectImageIndexPath)(NSInteger indexPath);

@property (strong,nonatomic) NNSpitslotCommentModel *spitslotCommentModel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timelabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIView  *broswerView;
@property (strong, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *broswerViewConstraint;

@property (strong, nonatomic) IBOutlet UILabel *bePraisedLabel;

//@property (copy , nonatomic) spitslotActionBlock block;
@property (copy , nonatomic) selectImageIndexPath selectImageBlock;
@end
