//
//  NNAskingView.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/10/23.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^askingActionBlock)(NSInteger tag);

@interface NNAskingView : UIView

@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

@property (weak, nonatomic) IBOutlet UITextView *askingTextView;

@property (copy ,nonatomic) askingActionBlock block;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@end
