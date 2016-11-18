//
//  NNMeVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/9/21.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNMeVC.h"
#import "NNMineEmotionalMangmentCell.h"
#import "NNMineCell.h"
#import "Masonry.h"
#import "NNMineCommentVC.h"
#import "NNMinePraisedVC.h"
#import "NNMineLikeVC.h"
#import "NNMineOrderVC.h"
#import "NNMineFeedbackVC.h"
#import "NNMineSetVC.h"
#import "NNMineNoticeVC.h"
#import "NNUserHeaderViewModel.h"

@interface NNMeVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    NSArray *imageArray;
    NSArray *titleArray;
    
    UILabel *ninkNameLabel;
    UIButton *headerButton;
    UIButton *backgroundButton;
}
@property (weak, nonatomic) IBOutlet UITableView *meTableView;

@end

@implementation NNMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initdata];
    [self initView];
    // Do any additional setup after loading the view.
}


- (void)initView {
    
    _meTableView.tableHeaderView = [self createTableHeaderView];
    
    _meTableView.delegate = self;
    _meTableView.dataSource = self;
    _meTableView.rowHeight = 44.f;
    _meTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _meTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_meTableView registerNib:[UINib nibWithNibName:@"NNMineEmotionalMangmentCell" bundle:nil] forCellReuseIdentifier:@"NNMineEmotionalMangmentCell"];
}

- (UIView *)createTableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, NNAppWidth *164 / 375)];
    backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundButton.backgroundColor = [UIColor redColor];
    [headerView addSubview:backgroundButton];
    
    [backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@-20);
        make.bottom.equalTo(@0);
    }];
    
    headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headerButton.layer.masksToBounds = YES;
    headerButton.layer.cornerRadius = 30;
    headerButton.backgroundColor = [UIColor yellowColor];
    [headerButton addTarget:self action:@selector(changeHeadAction:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundButton addSubview:headerButton];
    [headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(@((NNAppWidth*62)/375 ));
        make.centerX.equalTo(backgroundButton.mas_centerX);
    }];
    
    ninkNameLabel = [[UILabel alloc] init];
    ninkNameLabel.textColor = [UIColor colorFromHexString:@"#333333"];
    ninkNameLabel.font = [UIFont systemFontOfSize:14.f];
    [backgroundButton addSubview:ninkNameLabel];
    [ninkNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@150);
        make.centerX.equalTo(backgroundButton.mas_centerX);
        make.top.equalTo(headerButton.mas_bottom).with.offset(8.0f);
        make.height.equalTo(@20);
    }];
    
    ninkNameLabel.backgroundColor = [UIColor whiteColor];
    
    return headerView;
}

- (void)initdata {
    titleArray = @[@"我的预约",@"我的问吧",@"我的消息",@"意见反馈",@"设置"];
    imageArray = @[@"400_16",@"400_23",@"400_27",@"400_29",@"400_31"];
}

- (void)changeHeadAction:(UIButton *)button {
    
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
}

- (UIImage *)makeImageWithImage:(UIImage *)imageOld scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [imageOld drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma  --mark  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage *temp = [self makeImageWithImage:image scaledToSize:CGSizeMake(720, 720)];
      
        
     
        NNUserHeaderViewModel *viewModel = [[NNUserHeaderViewModel alloc] init];
        
        [viewModel setBlockWithReturnBlock:^(id returnValue) {
            [headerButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:returnValue] placeholderImage:[UIImage imageNamed:@"detail_defalut"]];
        } WithErrorBlock:^(id errorCode) {
            
        } WithFailureBlock:^(id failureBlock) {
            
        }];
        [viewModel upLoadHeaderImageViewWithToken:TEST_TOKEN andImage:temp];
    }];
}


#pragma --Mark  UItableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }
    else if(section == 1) {
        return 3;
    }else{
        return 2;
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"mineCell";
    NNMineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NNMineCell" owner:self options:nil][0];
    }
    if (indexPath.section == 0) {
        NNMineEmotionalMangmentCell *emotionalMangmentCell = [tableView dequeueReusableCellWithIdentifier:@"NNMineEmotionalMangmentCell"];
        emotionalMangmentCell.block = ^(NSInteger tag){
            switch (tag) {
                case 100:
                {
                    NNMinePraisedVC *praisedVC = [[NNMinePraisedVC alloc] initWithNibName:@"NNMinePraisedVC" bundle:nil];
                    praisedVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:praisedVC animated:YES];
                }
                    break;
                case 101:
                {
                    NNMineCommentVC *commentVC = [[NNMineCommentVC alloc] initWithNibName:@"NNMineCommentVC" bundle:nil];
                     commentVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:commentVC animated:YES];
                }
                    
                    break;
                case 102:
                {
                    NNMineLikeVC *likeVC = [[NNMineLikeVC alloc] initWithNibName:@"NNMineLikeVC" bundle:nil];
                    likeVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:likeVC animated:YES];
                }
                    
                    break;
                case 103:
                    
                    break;
                    
                default:
                    break;
            }
        };
        return emotionalMangmentCell;
    }else if (indexPath.section == 1) {
        cell.iconImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
        cell.mineTitleLabel.text = [titleArray objectAtIndex:indexPath.row];
    }else {
        cell.iconImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row + 3]];
        cell.mineTitleLabel.text = [titleArray objectAtIndex:indexPath.row + 3];

    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NNMineOrderVC *orderVC = [[NNMineOrderVC alloc] initWithNibName:@"NNMineOrderVC" bundle:nil];
            orderVC.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:orderVC animated:YES];
        }else if (indexPath.row == 1){
           
        }else if (indexPath.row == 2){
            NNMineNoticeVC *noticeVC = [[NNMineNoticeVC alloc] initWithNibName:@"NNMineNoticeVC" bundle:nil];
            noticeVC.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:noticeVC animated:YES];

        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            NNMineFeedbackVC *feedbackVC = [[NNMineFeedbackVC alloc] initWithNibName:@"NNMineFeedbackVC" bundle:nil];
            feedbackVC.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:feedbackVC animated:YES];
        }else if (indexPath.row == 1){
            NNMineSetVC *setVC = [[NNMineSetVC alloc] initWithNibName:@"NNMineSetVC" bundle:nil];
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:YES];
        }
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
