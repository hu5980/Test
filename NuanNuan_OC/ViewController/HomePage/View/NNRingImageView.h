//
//  NNRingImageView.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNRingImageModel.h"

typedef void(^selectRingImageBlock)(NNRingImageModel *model);

@interface NNRingImageView : UIView <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *ringScrollView;

@property (nonatomic,copy) selectRingImageBlock ringBlock;

- (void)createRingImageviewWithRingArray:(NSArray *)array;

@end
