//
//  NNSuccessCaseVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionCaseVC.h"
#import "NNEmotionallItemCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface NNEmotionCaseVC ()<UITableViewDataSource,UITableViewDelegate> {
    UIButton *defaultSelectButton;
}

@end

@implementation NNEmotionCaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackButton:YES];
    [self createEmotionalTypeUI];
    
    self.title = _navigationTitle;
    
    _emotionalTableView.delegate = self;
    _emotionalTableView.dataSource = self;
    [_emotionalTableView registerNib:[UINib nibWithNibName:@"NNEmotionallItemCell" bundle:nil] forCellReuseIdentifier:@"NNEmotionallItemCell"];
    // Do any additional setup after loading the view from its nib.
}

- (void)createEmotionalTypeUI {
    _emotionalTypeScrollView.contentSize = CGSizeMake((NNAppWidth/3)*_caseTypeArray.count, 32);
    for (int i = 0; i< _caseTypeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(NNAppWidth/3), -64, NNAppWidth/3, 32);
        [button setTitleColor:[UIColor colorFromHexString:@"333333"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorFromHexString:@"FF8833"] forState:UIControlStateSelected];
         [button setTitleColor:[UIColor colorFromHexString:@"FF8833"] forState:UIControlStateHighlighted];
        button.tag = 100 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button setTitle:[_caseTypeArray objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeEmotionalType:) forControlEvents:UIControlEventTouchUpInside];
        [_emotionalTypeScrollView addSubview:button];
        if (i == 0) {
            defaultSelectButton = button;
            defaultSelectButton.selected = YES;
        }
    }
}


#pragma --mark Action 

- (void)changeEmotionalType :(UIButton *)button {
    defaultSelectButton.selected = NO;
    defaultSelectButton = button;
    defaultSelectButton.selected = YES;
    switch (button.tag) {
        case 100:
            
            break;
        case 101:
            
            break;
        case 102:
            
            break;
            
        default:
            break;
    }
}

#pragma --mark UITableViewDelegate UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNEmotionallItemCell" cacheByIndexPath:indexPath configuration:^(id cell) {
      
    }];
    return height > 44 ? height :44  ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NNEmotionallItemCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"NNEmotionallItemCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
