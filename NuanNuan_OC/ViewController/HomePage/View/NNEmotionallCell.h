//
//  NNEmotionallCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/9.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^emotionSuccessCaseMoreBlock)();
typedef void(^emotionSuccessCaseBlock)();

@interface NNEmotionallCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *emotionTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreEmotionButton;

@property (copy,nonatomic) emotionSuccessCaseMoreBlock successCasemoreBlock;
@property (copy,nonatomic) emotionSuccessCaseBlock successCaseBlock;

@end
