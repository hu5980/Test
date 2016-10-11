//
//  NNRingImageViewView.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNRingImageViewView.h"
#import "Define.h"
@implementation NNRingImageViewView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)initViewWithRingArray:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        [button addTarget:self action:@selector(selectRingImage:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(NNAppWidth * i, 0, NNAppWidth, NNAppWidth * 164 / 375);
        
        [_ringScrollView addSubview:button];
    }
}

- (void)selectRingImage:(UIButton *)button {
    _ringBlock();
}

@end
