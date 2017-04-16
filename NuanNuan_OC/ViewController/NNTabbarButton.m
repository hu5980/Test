//
//  NNTabbarButton.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/4/16.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNTabbarButton.h"
#import "Masonry.h"
#import "UIColor+Helper.h"
#import "Define.h"
@implementation NNTabbarButton 
{
    UILabel *titleLabel;
    UIImageView *imageView;
    NSString *nnNormalImage;
    NSString *nnHeightImage;
    NSString *nnTitle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setNormalImage:(NSString *)normalImage andHeightImage:(NSString *)heightImage andTitle:(NSString *)title {
     nnNormalImage = normalImage;
     nnHeightImage = heightImage;
     nnTitle = title;
     imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
     [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(@24);
         make.height.mas_equalTo(@24);
         make.top.mas_equalTo(@5);
         make.centerX.mas_equalTo(self.mas_centerX);
     }];
     titleLabel = [[UILabel alloc] init];
     [self addSubview:titleLabel];
     titleLabel.font = [UIFont systemFontOfSize:12];
     titleLabel.textAlignment = NSTextAlignmentCenter;
     titleLabel.textColor = NN_TEXT999999_COLOR;
     [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(@40);
         make.height.mas_equalTo(@10);
         make.top.mas_equalTo(@34);
         make.centerX.mas_equalTo(self.mas_centerX);
     }];
    
    imageView.image = [UIImage imageNamed:normalImage];
    titleLabel.text = title;

}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        imageView.image = [UIImage imageNamed:nnHeightImage];
        titleLabel.textColor =  NN_MAIN_COLOR;
    }else{
        imageView.image = [UIImage imageNamed:nnNormalImage];
        titleLabel.textColor = NN_TEXT999999_COLOR;
    }

}

@end
