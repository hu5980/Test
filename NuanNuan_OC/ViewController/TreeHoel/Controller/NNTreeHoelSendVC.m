//
//  NNTreeHoelSendVC.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 16/11/19.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNTreeHoelSendVC.h"
#import "MLSelectPhoto.h"
#import "NNSendTreeHoelViewModel.h"
#import "NNAddTreeHoelImageViewModel.h"

@interface NNTreeHoelSendVC ()<UITextViewDelegate> {
    UIButton *addImageButton ;
    NSString *picsJsonStr;
    NSString *showname;
}

@property (nonatomic,assign) BOOL isModified;
@property (nonatomic,strong)  NSMutableArray *imageArray;

@end

@implementation NNTreeHoelSendVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI {
    self.view.backgroundColor = NN_BACKGROUND_COLOR;
    [self setNavigationBackButton:YES];
    self.navTitle = @"发表树洞";
    [self setNavigationRightItem:@"发送"];
    self.contentTextView.font = [UIFont systemFontOfSize:14.f];
    self.contentTextView.textColor = NN_TEXT666666_COLOR;
    addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addImageButton.frame = CGRectMake(15, 10, (NNAppWidth - 30 - 10 * 3) / 4, (NNAppWidth - 30 - 10 * 3) / 4);
    addImageButton.backgroundColor = [UIColor clearColor];
    [addImageButton setBackgroundImage:[UIImage imageNamed:@"addimage"] forState:UIControlStateNormal];
    [addImageButton addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:addImageButton];
    
    _contentTextView.delegate = self;
}

- (void)initData {
    _imageArray = [NSMutableArray array];
    showname = @"2";
}


#pragma --mark Action
- (void)addImageAction:(UIButton *)button {
    MLSelectPhotoPickerViewController *selectVC = [[MLSelectPhotoPickerViewController alloc]init];
    selectVC.minCount = 9 - _imageArray.count;
    
    __weak NNTreeHoelSendVC *weakSelf = self;
    selectVC.callBack = ^(id obj) {
        weakSelf.isModified = true;
        
        if (obj) {
            for(MLSelectPhotoAssets *temp in obj) {
                [weakSelf.imageArray addObject:temp.originImage];
            }
            [weakSelf reloadImages];
        }
    };
    [selectVC showPickerVc:self];
}

- (void)reloadImages {
    
    for (UIView *view  in _imageView.subviews) {
        [view removeFromSuperview];
    }

    CGFloat xPoint  = 15.0;
    CGFloat yPoint  = 15.0;
    CGFloat imageWidth = (NNAppWidth - 30 - 10 * 3) / 4 ;
    CGFloat gapWidth  = 10.0 ;
    NSInteger tag = 0 ;
    
    for (UIImage *image in self.imageArray)  {
        if (xPoint >= NNAppWidth - 15) {
            xPoint = 15.0 ;
            yPoint += imageWidth + gapWidth ;
        }
        
        UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, imageWidth, imageWidth)];
        button.imageView.contentMode = UIViewContentModeScaleToFill;
        button.tag = tag ++;
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleClickAction:) forControlEvents:UIControlEventTouchUpInside];
       
        [self.imageView addSubview:button];
        xPoint += imageWidth + gapWidth ;
    }
    
    if (self.imageArray.count < 9) {
        if (xPoint >= NNAppWidth - 15) {
            xPoint = 15.0 ;
            yPoint += imageWidth + gapWidth ;
        }
        addImageButton.left = xPoint;
        addImageButton.top = yPoint;
        [self.imageView addSubview:addImageButton];
    }
    self.imageViewConstraint.constant = yPoint + imageWidth + 15.0 ;
}


- (void)handleClickAction:(UIButton *)button {

}
- (IBAction)hideNameAction:(UIButton *)sender {
    sender.selected =  !sender.selected;
    if (sender.selected) {
        showname = @"1";
    }else{
        showname = @"2";
    }
}

- (void)rightItemAction:(UIBarButtonItem *)item {
    
    if([_contentTextView isFirstResponder]){
        [_contentTextView resignFirstResponder];
    }
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);


    [[NNProgressHUD instance] showHudToView:self.view ];
    NNAddTreeHoelImageViewModel *addImageViewModel = [[NNAddTreeHoelImageViewModel alloc] init];
    [addImageViewModel setBlockWithReturnBlock:^(id returnValue) {
        [[NNProgressHUD instance] hideHud];
        
     
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:returnValue
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        
        picsJsonStr = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        
        dispatch_group_leave(group);
    } WithErrorBlock:^(id errorCode) {
         [[NNProgressHUD instance] hideHud];
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
         dispatch_group_leave(group);
    } WithFailureBlock:^(id failureBlock) {
        [[NNProgressHUD instance] hideHud];
         dispatch_group_leave(group);
    }];
    
    [addImageViewModel addTreeImageWithToken:TEST_TOKEN andImages:_imageArray];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^(){
        [[NNProgressHUD instance] showHudToView:self.view ];
         NNSendTreeHoelViewModel *sendViewModel = [[NNSendTreeHoelViewModel alloc] init];
        [sendViewModel setBlockWithReturnBlock:^(id returnValue) {
            [[NNProgressHUD instance] hideHud];
            if ([returnValue isEqualToString:@"success"]) {
               // [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:@"发布成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } WithErrorBlock:^(id errorCode) {
            [[NNProgressHUD instance] hideHud];
            [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode];
        } WithFailureBlock:^(id failureBlock) {
            [[NNProgressHUD instance] hideHud];
        }];
        [sendViewModel sendTreeHoelWithToken:TEST_TOKEN andContent:_contentTextView.text andPics:picsJsonStr andanonymity:showname];
    });
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _placeLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        _placeLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        
        [textView resignFirstResponder];
        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
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
