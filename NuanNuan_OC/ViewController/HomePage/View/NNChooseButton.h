//
//  NNChooseButton.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/14.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNChooseButton : UIButton

- (instancetype)initChooseButtonWithFrame:(CGRect )rect andIsmultiSelect:(BOOL)ismultiSelect;

@property (nonatomic,strong) UILabel *chooseTitleLabel;
@property (nonatomic,strong) UIImageView *chooseImageView;
@end
