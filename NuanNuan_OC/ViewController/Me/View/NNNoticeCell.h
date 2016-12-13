//
//  NNNoticeCell.h
//  NuanNuan_OC
//
//  Created by 忘、 on 16/12/13.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNNoticeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *noticeTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeContentLabel;

@end
