//
//  NNEmotionalItemCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNEnumDefine.h" 

typedef void(^emotionBlock)(EmotionType type);

@interface NNEmotionalItemCell : UITableViewCell
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@property (nonatomic,copy) emotionBlock eblock;

@end
