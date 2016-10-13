//
//  NNSuccessCaseVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionCaseVC.h"

@interface NNEmotionCaseVC ()

@end

@implementation NNEmotionCaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createEmotionalTypeUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)createEmotionalTypeUI {
    NSArray *array = @[@"婚姻修复",@"夫妻感情",@"婆媳相处"];
    _emotionalTypeScrollView.contentSize = CGSizeMake((NNAppWidth/3)*array.count, 32);
    for (int i = 0; i< array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(NNAppWidth/3), -64, NNAppWidth/3, 32);
        [button setTitleColor:[UIColor colorFromHexString:@"333333"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexString:@"FF8833"] forState:UIControlStateSelected];
        button.tag = 100 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeEmotionalType:) forControlEvents:UIControlEventTouchUpInside];
        [_emotionalTypeScrollView addSubview:button];
    }
}


#pragma --mark Action 

- (void)changeEmotionalType :(UIButton *)button {
    switch (button.tag) {
        case 100:
            
            break;
        case 101:
            
            break;
        case 102:
            
            break;
            
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
