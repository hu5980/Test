//
//  NNChooseView.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/14.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNChooseView.h"
#import "Define.h"
#import "NNAppointmentModel.h"
@implementation NNChooseView{
    CGRect rect;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (void)setChooseArray:(NSArray *)chooseArray {
    _chooseArray = chooseArray;
    [self initUI];
}

- (void)initUI {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width - 105;
    
    for (int i = 0; i < _chooseArray.count; i++) {
        NNChooseButton *chooseButton = [[NNChooseButton alloc] initChooseButtonWithFrame:CGRectMake(i%2 *width/2, i/2 * 44 , width / 2, 44)];
        chooseButton.tag = 100+i;
        if ([[_chooseArray objectAtIndex:i] isKindOfClass:[NNAppointmentModel class]]) {
            NNAppointmentModel *model = [_chooseArray objectAtIndex:i];
            chooseButton.chooseTitleLabel.text = model.appointmentTitle;
            chooseButton.tag = [model.appointmentID integerValue];
        }else{
            chooseButton.chooseTitleLabel.text = [_chooseArray objectAtIndex:i];
            chooseButton.tag = i + 1;
        }
        
        if (_defaultSelect == i) {
            chooseButton.selected = YES;
             [chooseButton.chooseImageView  setImage:[UIImage imageNamed:@"303_05"]];
        }
      
        [chooseButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chooseButton];
    }
}

- (void)chooseAction:(NNChooseButton *)button {
    for (NNChooseButton *chooseButton in self.subviews) {
        [chooseButton.chooseImageView  setImage:[UIImage imageNamed:@"303_03"]];
    }
    button.selected = YES;
    _chooseBlock(button);
}

@end
