//
//  NNMineEmotionalMangmentCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/9.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^emotionSelectBlock)(NSInteger tag);

@interface NNMineEmotionalMangmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *minePraiseButton;
@property (weak, nonatomic) IBOutlet UIButton *mineCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *mineLikeButton;
@property (weak, nonatomic) IBOutlet UIButton *mineShareButton;
@property (copy ,nonatomic) emotionSelectBlock block;
@end
