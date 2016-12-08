//
//  NNPsychologicalTeacherHeaderView.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/12.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^popBlock)();

typedef void (^showDetailBlock)();

@interface NNPsychologicalTeacherHeaderView : UIView
@property (copy, nonatomic) popBlock popblock;
@property (copy, nonatomic) showDetailBlock showDetail;
@property (weak, nonatomic) IBOutlet UIButton *popButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UILabel *teacherIntroduceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headimageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *studyTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherDescribeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *describelLabelConstraint;
@end
