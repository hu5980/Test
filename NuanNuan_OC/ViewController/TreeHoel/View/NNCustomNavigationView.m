//
//  NNCustomNavigationView.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNCustomNavigationView.h"
#import "Define.h"
@implementation NNCustomNavigationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)emotionAskAction:(UIButton *)sender {
    _selectBlock(sender);
}
- (IBAction)teasingTreeHole:(UIButton *)sender {
    
    if([sender.titleLabel.text isEqualToString:@"吐槽树洞"]){
        if (TEST_TOKEN == nil) {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"entryLogin"]) {
               
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginAgain" object:@"需要登录"];
            }
            return;
        }
    }
    _selectBlock(sender);
}

@end
