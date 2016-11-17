//
//  NNUserHeaderViewModel.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/17.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNUserHeaderViewModel.h"

@implementation NNUserHeaderViewModel

- (void)upLoadHeaderImageViewWithToken:(NSString *)token andImage:(UIImage *)imagedata {
    NSDictionary *parames = @{@"token":token,@"head":imagedata};
    
    [NNNetRequestClass NetRequestPOSTWithRequestURL:[NSString stringWithFormat:@"%@/?c=api_member&a=updateHead",NNBaseUrl] withParameter:parames withReturnValueBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        
    } withErrorCodeBlock:^(id errorCode) {
        
    } withFailureBlock:^(id failureBlock) {
        
    } withProgress:^(id Progress) {
        
    }];
}



NSDictionary *param = @{@"type":self.typeId,
                        @"uid":self.userInfo[@"uid"],
                        @"project_id":self.projectId,
                        @"name":self.nameTextField.text,
                        @"info":self.infoTextView.text};
NSLog(@"param:%@",param);
AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
[SVProgressHUD showWithStatus:@"正在上传图片" maskType:SVProgressHUDMaskTypeGradient];
[manager POST:[NSString stringWithFormat:@"%@/projectLog/create",HOST_URL] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    for (int i = 0; i < self.uploadImageView.allImages.count; i++) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.uploadImageView.allImages,0.8) name:@"images[]" fileName:@"something.jpg" mimeType:@"image/jpeg"];
    }
} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if ([[responseObject objectForKey:@"code"] isEqualToNumber:@1]) {
        [SVProgressHUD showSuccessWithStatus:@"发布成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([[responseObject objectForKey:@"code"] isEqualToNumber:@400]) {
        [SVProgressHUD dismiss];
    } else {
        [SVProgressHUD dismiss];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[responseObject objectForKey:@"message"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"%@",error);
    [SVProgressHUD dismiss];
    [[[UIAlertView alloc]initWithTitle:@"上传失败" message:@"网络故障，请稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}];








@end
