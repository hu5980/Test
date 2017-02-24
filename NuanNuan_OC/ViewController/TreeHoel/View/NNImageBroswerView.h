//
//  NNImageBroswerView.h
//  NuanNuan_OC
//
//  Created by hu5980 on 16/10/22.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickImageViewBlock)(NSInteger tag);

@interface NNImageBroswerView : UIView

@property (nonatomic,copy) clickImageViewBlock block;

@property (nonatomic,assign) CGFloat broswerViewHeight;

/**
 初始化图片展示

 @param frame       view 的Frame
 @param arrays      图片展示的URL
 @param imageSpace  图片间隔距离
 @param spaceOfSide 图片与View的边框的距离
 @param number      每行展示的图片的个数

 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame
                    ImageUrls:(NSArray *)arrays
               SpaceWithImage:(CGFloat ) imageSpace
     SpaceWithSideOfSuperView:(CGFloat ) spaceOfSide
            NumberImageOfLine:(NSInteger) number;

@end
