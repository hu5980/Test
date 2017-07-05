//
//  NNAddInfoCell.h
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/3.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNAddInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstlabel;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerxContraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
