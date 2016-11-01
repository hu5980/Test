//
//  NNEmotionallCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/9.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNSuccessCaseModel.h"
typedef void(^emotionSuccessCaseMoreBlock)(NSInteger type);
typedef void(^emotionSuccessCaseBlock)(NNSuccessCaseModel *mode);

@interface NNEmotionallCell : UITableViewCell


@property (nonatomic,assign) NSInteger type;

@property (weak, nonatomic) IBOutlet UILabel *emotionTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreEmotionButton;

@property (strong, nonatomic) NSArray *successCaseModelArray;
@property (copy,nonatomic) emotionSuccessCaseMoreBlock successCasemoreBlock;
@property (copy,nonatomic) emotionSuccessCaseBlock successCaseBlock;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel4;

@property (weak, nonatomic) IBOutlet UIButton *bgButton1;

@property (weak, nonatomic) IBOutlet UIButton *bgButton2;
@property (weak, nonatomic) IBOutlet UIButton *bgButton3;
@property (weak, nonatomic) IBOutlet UIButton *bgButton4;
@end
