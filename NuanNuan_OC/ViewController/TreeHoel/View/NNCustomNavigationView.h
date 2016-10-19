//
//  NNCustomNavigationView.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectTreeTypeBlock)(UIButton *button);

@interface NNCustomNavigationView : UIView
@property (copy, nonatomic) selectTreeTypeBlock selectBlock;
@property (weak, nonatomic) IBOutlet UIButton *emotionAskButton;
@property (weak, nonatomic) IBOutlet UIButton *teasingTreeHoleButton;

@end
