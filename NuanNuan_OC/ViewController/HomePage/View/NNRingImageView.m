//
//  NNRingImageView.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNRingImageView.h"
#import "Define.h"
#import "Masonry.h"
#import "UIButton+AFNetworking.h"
//#import "ReactiveCocoa.h"

@implementation NNRingImageView {
    NSArray *modelArrays;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)createRingImageviewWithRingArray:(NSArray *)array {
    modelArrays = array;
    for (int i = 0; i < array.count; i++) {
        NNRingImageModel *model = [array objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        [button addTarget:self action:@selector(selectRingImage:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(NNAppWidth * i, 0, NNAppWidth, NNAppWidth * 164 / 375);
        [button setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
        [_ringScrollView addSubview:button];
    }
    _ringScrollView.contentSize = CGSizeMake(array.count * NNAppWidth, NNAppWidth * 164 / 375);
    _ringScrollView.delegate = self;
    // 用RAC中的RACObserve 对_ringScrollView 中的contentOffset 进行观察
    // subscribeNext 参考http://www.jianshu.com/p/4fee21fb05b3
//    [RACObserve(_ringScrollView, contentSize) subscribeNext:^(id x) {
//         _pageControl.currentPage =  _ringScrollView.contentOffset.x / NNAppWidth ;
//    }];
    
    _pageControl.numberOfPages = array.count;
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
 _pageControl.currentPage =  scrollView.contentOffset.x / NNAppWidth ;

}

- (void)changePage:(UIPageControl *)pageControl {
    _ringScrollView.contentOffset = CGPointMake(pageControl.currentPage * NNAppWidth, 0);
}

- (void)selectRingImage:(UIButton *)button {
    _ringBlock([modelArrays objectAtIndex:button.tag - 100]);
}

@end
