//
//  NNChooseButton.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/14.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNChooseButton.h"
#import "Define.h"

@implementation NNChooseButton {
    
    CGRect  frameRect;
    
    BOOL multiSelect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initChooseButtonWithFrame:(CGRect )rect andIsmultiSelect:(BOOL)ismultiSelect{
    self = [super initWithFrame:rect];
   
    if (self) {
        frameRect = rect;
        multiSelect = ismultiSelect;
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _chooseImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(5, (frameRect.size.height - 18)/2, 18, 18)];
    if (multiSelect) {
        [_chooseImageView setImage:[UIImage imageNamed:@"303_02"]];
    }else{
        [_chooseImageView setImage:[UIImage imageNamed:@"303_03"]];
    }
    [self addSubview:_chooseImageView];
    _chooseTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + 15 + 18, 0, frameRect.size.width - 38, 43)];
    [_chooseTitleLabel setTextColor:NN_TEXT666666_COLOR];
    [_chooseTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self addSubview:_chooseTitleLabel];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        if (multiSelect) {
            [_chooseImageView setImage:[UIImage imageNamed:@"303_04"]];
        }else{
            [_chooseImageView setImage:[UIImage imageNamed:@"303_05"]];
        }
    }else{
        if (multiSelect) {
            [_chooseImageView setImage:[UIImage imageNamed:@"303_02"]];
        }else{
            [_chooseImageView setImage:[UIImage imageNamed:@"303_03"]];
        }
    }
}



@end
