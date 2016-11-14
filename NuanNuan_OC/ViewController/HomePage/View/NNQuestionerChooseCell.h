//
//  NNQuestionerChooseCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/14.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNChooseView.h"

@interface NNQuestionerChooseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chooseTitleLabel;
@property (weak, nonatomic) IBOutlet NNChooseView *chooseView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chooseContraint;
@end
