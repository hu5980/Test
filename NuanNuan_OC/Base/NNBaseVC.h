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
#import "UITableView+FDTemplateLayoutCell.h"
#import "Masonry.h"
@interface NNBaseVC : UIViewController

@property (nonatomic,strong) NSString *navTitle;

- (void)setNavigationBackButton:(BOOL ) showOrHidden;



@end
