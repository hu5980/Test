//
//  NNChooseView.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/14.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNChooseButton.h"

typedef void(^chooseButtonBlock)(NNChooseButton *button);

@interface NNChooseView : UIView

- (instancetype) initWithFrame:(CGRect)frame;

@property (nonatomic,strong) NSArray *chooseArray;

@property (nonatomic,copy) chooseButtonBlock chooseBlock;



@end