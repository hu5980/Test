//
//  NNBaseVC.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "NNEnumDefine.h"
@interface NNBaseVC : UIViewController

@property (nonatomic,strong) NSString *title;

- (void)setNavigationBackButton:(BOOL ) showOrHidden;



@end
