//
//  NNImageBroswerView.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/10/22.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNImageBroswerView.h"
#import "Define.h"
#import "UIButton+AFNetworking.h"
@implementation NNImageBroswerView

- (instancetype)initWithFrame:(CGRect)frame ImageUrls:(NSArray *)arrays SpaceWithImage:(CGFloat ) imageSpace SpaceWithSideOfSuperView:(CGFloat ) spaceOfSide NumberImageOfLine:(NSInteger) number{
    if (self = [super initWithFrame:frame]) {
        [self setImageViewWithImageUrls:arrays SpaceWithImage:imageSpace SpaceWithSideOfSuperView:spaceOfSide NumberImageOfLine:number];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setImageViewWithImageUrls:(NSArray *)arrays SpaceWithImage:(CGFloat ) imageSpace SpaceWithSideOfSuperView:(CGFloat ) spaceOfSide NumberImageOfLine:(NSInteger) number{
    if (arrays.count == 0) {
        _broswerViewHeight = 0;
        return;
    }else {
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
        CGFloat imageWidth = (NNAppWidth - (number - 1) * imageSpace - 30  ) / number;
        
        for (int i = 0; i < arrays.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[arrays objectAtIndex:i]] placeholderImage:nil];
            [button addTarget:self action:@selector(clickImageButton:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i%number*(imageSpace + imageWidth) + 15 , i/number *(imageWidth + imageSpace) + 10, imageWidth, imageWidth);
            button.tag = 1000 + i;
            button.backgroundColor = [UIColor redColor];
            [self addSubview:button];
        }
        _broswerViewHeight = (arrays.count/number + 1) *(imageWidth + imageSpace) ;
        self.frame = CGRectMake(0,0,NNAppWidth, _broswerViewHeight);
    }
}

- (void)clickImageButton:(UIButton *)button {
    _block(button.tag);
}

@end