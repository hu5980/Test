//
//  NNNeterReply.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNCommentModel.h"

typedef void(^likeCommentBlock)(UIButton *button);

@interface NNNeterReplyCell : UITableViewCell
@property (nonatomic,strong) NNCommentModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTImeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeNumLabel;
@property (copy, nonatomic) likeCommentBlock likeCommentBlock;
@end
