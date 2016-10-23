//
//  NNRingImageViewView.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNRingImageViewView.h"
#import "Define.h"
#import "Masonry.h"
@implementation NNRingImageViewView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)createRingImageviewWithRingArray:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        [button addTarget:self action:@selector(selectRingImage:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(NNAppWidth * i, 0, NNAppWidth, NNAppWidth * 164 / 375);
        
        [_ringScrollView addSubview:button];
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] init ] ;
     [_ringScrollView addSubview:pageControl];
    pageControl.currentPageIndicatorTintColor = [UIColor colorFromHexString:@"#999999"];
    pageControl.tintColor = [UIColor whiteColor];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_ringScrollView.mas_centerX);
        make.bottom.equalTo(_ringScrollView.mas_bottom).with.offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
        
    }];
    
   
    
}

- (void)selectRingImage:(UIButton *)button {
    _ringBlock();
}

@end
