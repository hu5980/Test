//
//  NNAddImageView.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/20.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNAddImageView : UIView

@property (nonatomic,assign) CGFloat imageViewHeight;

- (instancetype)initWithFrame:(CGRect)frame
               SpaceWithImage:(CGFloat ) imageSpace
     SpaceWithSideOfSuperView:(CGFloat ) spaceOfSide
            NumberImageOfLine:(NSInteger) number;

@end
