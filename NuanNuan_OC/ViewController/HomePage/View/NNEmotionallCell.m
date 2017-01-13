//
//  NNEmotionallCell.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/9.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionallCell.h"
#import "NNSuccessCaseModel.h"
#import "UIButton+AFNetworking.h"
#import "UIButton+WebCache.h"
@implementation NNEmotionallCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _bgButton1.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgButton2.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgButton3.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgButton4.imageView.contentMode = UIViewContentModeScaleAspectFill;
    _bgButton1.clipsToBounds = YES;
    _bgButton2.clipsToBounds = YES;
    _bgButton3.clipsToBounds = YES;
    _bgButton4.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)moreCaseAction:(UIButton *)sender {
    _successCasemoreBlock(_type);
}

- (IBAction)selcetSuccessCase:(UIButton *)sender {
    _successCaseBlock([_successCaseModelArray objectAtIndex:sender.tag - 100]);
}

- (void)setSuccessCaseModelArray:(NSArray *)successCaseModelArray {
    
    if(successCaseModelArray.count )
    {
        _successCaseModelArray = successCaseModelArray;
        _titleLabel1.text = ((NNSuccessCaseModel *)[successCaseModelArray objectAtIndex:0]).caseTitle;
        _titleLabel1.hidden = NO;
        
       [_bgButton1 sd_setImageWithURL:[NSURL URLWithString:((NNSuccessCaseModel *)[successCaseModelArray objectAtIndex:0]).caseImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageAllowInvalidSSLCertificates];
        
        if (successCaseModelArray.count >= 2) {
            _titleLabel2.text = ((NNSuccessCaseModel *)[successCaseModelArray objectAtIndex:1]).caseTitle;
            _titleLabel2.hidden = NO;
            [_bgButton2 sd_setImageWithURL:[NSURL URLWithString:((NNSuccessCaseModel *)[successCaseModelArray objectAtIndex:1]).caseImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageAllowInvalidSSLCertificates];
        }
       
        if (successCaseModelArray.count >= 3) {
            _titleLabel3.text = ((NNSuccessCaseModel *)[successCaseModelArray objectAtIndex:2]).caseTitle;
            _titleLabel3.hidden = NO;
            [_bgButton3 sd_setImageWithURL:[NSURL URLWithString:((NNSuccessCaseModel *)[successCaseModelArray objectAtIndex:2]).caseImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageAllowInvalidSSLCertificates];
        }
        if (successCaseModelArray.count >= 4) {
            _titleLabel4.text = ((NNSuccessCaseModel *)[successCaseModelArray objectAtIndex:3]).caseTitle;
            _titleLabel4.hidden = NO;
            [_bgButton4 sd_setImageWithURL:[NSURL URLWithString:((NNSuccessCaseModel *)[successCaseModelArray objectAtIndex:3]).caseImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"detail_defalut"] options:SDWebImageAllowInvalidSSLCertificates];
        }
    }

}

@end
