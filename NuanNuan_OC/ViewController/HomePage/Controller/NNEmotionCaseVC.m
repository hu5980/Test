//
//  NNSuccessCaseVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionCaseVC.h"
#import "NNEmotionallItemCell.h"

@interface NNEmotionCaseVC ()<UITableViewDataSource,UITableViewDelegate> {
    UIButton *defaultSelectButton;
}

@end

@implementation NNEmotionCaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self createEmotionalTypeUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBackButton:YES];
   
    
    self.navTitle = _navigationTitle;
 
    _emotionalTableView.delegate = self;
    _emotionalTableView.dataSource = self;
    _emotionalTableView.backgroundColor = NN_BACKGROUND_COLOR;
    [_emotionalTableView registerNib:[UINib nibWithNibName:@"NNEmotionallItemCell" bundle:nil] forCellReuseIdentifier:@"NNEmotionallItemCell"];
    
    if(_caseTypeArray.count == 0){
        _scrollViewConstraint.constant = 0;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)createEmotionalTypeUI {
    _emotionalTypeScrollView.contentSize = CGSizeMake((NNAppWidth/3)*_caseTypeArray.count, 32);
    for (UIView *view in _emotionalTypeScrollView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i< _caseTypeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(NNAppWidth/3), 0, NNAppWidth/3, 32);
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"NNEmotionallItemCell" cacheByIndexPath:indexPath configuration:^(id cell) {
      
    }];
    return height   ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
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
