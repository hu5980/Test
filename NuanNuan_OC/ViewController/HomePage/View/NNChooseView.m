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
    NSMutableArray *selectArrays;
    NSMutableString *str;
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
    selectArrays = [NSMutableArray array];
    [self initUI];
}

- (void)initUI {
    CGFloat width = [[UIScreen mainScreen] bounds].size.width - 105;
    
    for (int i = 0; i < _chooseArray.count; i++) {
        NNChooseButton *chooseButton = [[NNChooseButton alloc] initChooseButtonWithFrame:CGRectMake(i%2 *width/2, i/2 * 44 , width / 2, 44) andIsmultiSelect:_ismultiSelect];
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
            if ([[_chooseArray objectAtIndex:i] isKindOfClass:[NNAppointmentModel class]]) {
                NNAppointmentModel *model = [_chooseArray objectAtIndex:i];
                [selectArrays addObject:[NSNumber numberWithInteger:[model.appointmentID integerValue]]];
            }else{
                [selectArrays addObject:[NSNumber numberWithInteger:i + 1]];
            }
            
        }
        
        [chooseButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chooseButton];
    }
}

- (void)chooseAction:(NNChooseButton *)button {
    if (str == nil) {
        str = [NSMutableString string];
    }else{
        str= [NSMutableString stringWithString:@""];
    }
    
    if (_ismultiSelect) {
        if (button.selected) {
            [selectArrays removeObject:[NSNumber numberWithInteger:button.tag]];
            
        }else{
            [selectArrays addObject:[NSNumber numberWithInteger:button.tag]];
        }
        button.selected =  !button.selected;
    }else{
        [selectArrays removeAllObjects];
        for (NNChooseButton *chooseButton in self.subviews) {
            chooseButton.selected = NO;
        }
        button.selected = YES;
        [selectArrays addObject:[NSNumber numberWithInteger:button.tag]];
    }
    
    
    for (int i   = 0; i < selectArrays.count; i++) {
        if (str.length == 0) {
            [str appendString:[NSString stringWithFormat:@"%@",[selectArrays objectAtIndex:i]]];
        }else{
            [str appendString:[NSString stringWithFormat:@",%@",[selectArrays objectAtIndex:i]]];
        }
    }
    _chooseBlock(str);
}

@end
