//
//  NNRingImageViewView.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectRingImageBlock)();

@interface NNRingImageViewView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *ringScrollView;

@property (nonatomic,copy) selectRingImageBlock ringBlock;

- (void)createRingImageviewWithRingArray:(NSArray *)array;

@end
