//
//  NNSuccessCaseVC.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"

@interface NNEmotionCaseVC : NNBaseVC

@property (weak, nonatomic) IBOutlet UIScrollView *emotionalTypeScrollView;

@property (weak, nonatomic) IBOutlet UITableView *emotionalTableView;

@property (strong,nonatomic) NSString *navigationTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewConstraint;

@property (strong,nonatomic) NSArray *caseTypeArray;
@end
