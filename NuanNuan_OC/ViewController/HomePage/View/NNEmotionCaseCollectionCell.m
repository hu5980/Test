//
//  NNEmotionCaseCollectionCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 17/1/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNEmotionCaseCollectionCell.h"
#import "NNEmotionTableVC.h"

@interface NNEmotionCaseCollectionCell ()

@property (nonatomic,strong)NNEmotionTableVC *emotionTableViewController;

@end


@implementation NNEmotionCaseCollectionCell



- (void)awakeFromNib {
    [super awakeFromNib];

    self.emotionTableViewController =  [[NNEmotionTableVC alloc] initWithNibName:@"NNEmotionTableVC" bundle:nil ];
    self.emotionTableViewController.block = ^(NNSuccessCaseModel *model){
        _block(model);
    };
    [self.contentView addSubview:_emotionTableViewController.view];
    // Initialization code
}

//设置view的大小
- (void)layoutSubviews {
    [super layoutSubviews];
    self.emotionTableViewController.view.frame = self.bounds;
}

- (void)setDefaultType:(NSInteger)defaultType {
    self.emotionTableViewController.defaultType = defaultType;
}

@end
