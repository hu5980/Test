//
//  NNTreeHoelSendVC.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/19.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNBaseVC.h"

@interface NNTreeHoelSendVC : NNBaseVC
@property (strong, nonatomic) IBOutlet UILabel *placeLabel;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;

@property (strong, nonatomic) IBOutlet UIView *imageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewConstraint;
@end
