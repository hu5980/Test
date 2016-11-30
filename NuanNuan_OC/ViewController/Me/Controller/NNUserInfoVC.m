//
//  NNUserInfoVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/11/30.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNUserInfoVC.h"
#import "NNQuestionerChooseCell.h"
#import "NNQuestionerInfoCell.h"
#import "NNHeadImageCell.h"
#import "NNUserInfoModel.h"
#import "NNUserHeaderViewModel.h"

@interface NNUserInfoVC () <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    NNUserInfoModel *userInfoModel;
    NNHeadImageCell *headerCell;
    NNQuestionerInfoCell *userNameCell;
    NNQuestionerChooseCell *sexCell;
}
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@end

@implementation NNUserInfoVC

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
    [self setNavigationBackButton:YES];
    self.navTitle = @"个人信息";
    
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_infoTableView registerNib:[UINib nibWithNibName:@"NNQuestionerChooseCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionerChooseCell"];
    [_infoTableView registerNib:[UINib nibWithNibName:@"NNQuestionerInfoCell" bundle:nil] forCellReuseIdentifier:@"NNQuestionerInfoCell"];
    [_infoTableView registerNib:[UINib nibWithNibName:@"NNHeadImageCell" bundle:nil] forCellReuseIdentifier:@"NNHeadImageCell"];
}

- (void)initData {
    NSDictionary *returnValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    [self dealUserInfo:returnValue];
}

- (void)dealUserInfo:(NSDictionary *)returnValue {
    
    NSDictionary *info = [[returnValue objectForKey:@"data"] objectForKey:@"info"];
    
    NSString *token = [[returnValue objectForKey:@"data"] objectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    userInfoModel = [[NNUserInfoModel alloc ] init];
    userInfoModel.channel = [[info objectForKey:@"channel"] integerValue];
    userInfoModel.creatTime = [[info objectForKey:@"create_time"] integerValue];
    userInfoModel.userDescription = [info objectForKey:@"description"];
    userInfoModel.headImageUrl = [info objectForKey:@"head"];
    userInfoModel.modifyTime = [[info objectForKey:@"modify_time"] integerValue];
    userInfoModel.nickName = [info objectForKey:@"nickname"];
    userInfoModel.sex = [[info objectForKey:@"sex"] integerValue] == 1 ? @"男":@"女" ;
    userInfoModel.telphone = [info objectForKey:@"tel"];
    userInfoModel.uid = [info objectForKey:@"uid"] ;
    userInfoModel.usable = [info objectForKey:@"usable"];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        headerCell = [tableView dequeueReusableCellWithIdentifier:@"NNHeadImageCell" ];
        [headerCell.headImageView setImageWithURL:[NSURL URLWithString:userInfoModel.headImageUrl] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
        return headerCell;
    }else if (indexPath.row == 1){
        userNameCell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionerInfoCell"];
        userNameCell.titleLabel.text = @"昵称";
        userNameCell.titleTextField.text = userInfoModel.nickName;
        return userNameCell;
    }else{
        sexCell = [tableView dequeueReusableCellWithIdentifier:@"NNQuestionerChooseCell"];
        sexCell.chooseView.defaultSelect = [userInfoModel.sex isEqualToString:@"男"] ? 0 :1 ;
        sexCell.chooseTitleLabel.text = @"性别";
        sexCell.chooseView.chooseArray = @[@"男",@"女"];
        sexCell.chooseView.chooseBlock = ^(NNChooseButton *button){
            if (button.selected) {
                [button.chooseImageView setImage:[UIImage imageNamed:@"303_05"]];
            }else{
                [button.chooseImageView setImage:[UIImage imageNamed:@"303_03"]];
            }
        };

        return sexCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"选取照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            [self presentViewController:picker animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];

    }else if (indexPath.row == 2){
    
    }
    
}

#pragma  --mark  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage *temp = [self makeImageWithImage:image scaledToSize:CGSizeMake(720, 720)];
        
        
        NNUserHeaderViewModel *viewModel = [[NNUserHeaderViewModel alloc] init];
        
        [viewModel setBlockWithReturnBlock:^(id returnValue) {
           
        [headerCell.headImageView setImageWithURL:[NSURL URLWithString:returnValue] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
        
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^(id failureBlock) {
            
        }];
        [viewModel upLoadHeaderImageViewWithToken:TEST_TOKEN andImage:temp];
    }];
}

- (UIImage *)makeImageWithImage:(UIImage *)imageOld scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [imageOld drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
