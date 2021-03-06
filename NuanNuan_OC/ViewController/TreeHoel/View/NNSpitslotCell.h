//
//  NNSpitslotCell.h
//  NuanNuan_OC
//
//  Created by hu5980 on 16/10/22.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNTreeHoelModel.h"
#import "NNSpitslotCommentModel.h"
typedef void(^spitslotActionBlock)(UIButton *button);

typedef void(^selectImageIndexPath)(NSInteger indexPath);

@interface NNSpitslotCell : UITableViewCell

@property (strong, nonatomic) NNTreeHoelModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timelabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIView  *broswerView;
@property (strong, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *broswerViewConstraint;

@property (strong, nonatomic) IBOutlet UILabel *bePraisedLabel;
@property (copy , nonatomic) spitslotActionBlock block;
@property (copy , nonatomic) selectImageIndexPath selectImageBlock;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;


@end
