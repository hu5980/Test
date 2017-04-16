//
//  NNSuccessCaseVC.m
//  NuanNuan_OC
//
//  Created by 忘、 on 16/10/11.
//  Copyright © 2016年 NuanNuan. All rights reserved.
//

#import "NNEmotionCaseVC.h"
#import "NNMoreSuccessCaseViewModel.h"
#import "NNPariseViewModel.h"
#import "NNSuccessCaseModel.h"
#import "NNLoginAndRegisterVC.h"
#import "NNEmotionCaseCollectionCell.h"
#import "NNArticleDetailVC.h"

@interface NNEmotionCaseVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate> {
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
    if ([_navigationTitle isEqualToString:@"生活情感"]) {
        [MobClick event:@"clk_mother"];
    }else if ([_navigationTitle isEqualToString:@"爱情导航"]) {
        [MobClick event:@"clk_CrushOn"];
    }else if ([_navigationTitle isEqualToString:@"心灵蜕变"]) {
        [MobClick event:@"clk_love"];
    }else if ([_navigationTitle isEqualToString:@"深夜识堂・热门推荐"]) {
        [MobClick event:@"in_StoryMarry"];
    }else if ([_navigationTitle isEqualToString:@"深夜识堂・身边故事"]) {
        [MobClick event:@"in_StoryMarry"];
    }else if ([_navigationTitle isEqualToString:@"深夜识堂・暖暖私语"]) {
        [MobClick event:@"in_StoryMarry"];
    }
    [self setNavigationBackButton:YES];
    [self createEmotionalTypeUI];
    self.navTitle = _navigationTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置间距
    self.emotionFlow.minimumInteritemSpacing = 0;
    self.emotionFlow.minimumLineSpacing = 0;
    self.emotionFlow.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    //设置collectionView一些属性
    self.emotionCollectionView.bounces = NO;
    //分页
    self.emotionCollectionView.pagingEnabled = YES;
    //水平条
    self.emotionCollectionView.showsHorizontalScrollIndicator = NO;
    self.emotionCollectionView.delegate = self;
    self.emotionCollectionView.dataSource = self;
    self.emotionCollectionView.backgroundColor = NN_BACKGROUND_COLOR;
    [self.emotionCollectionView registerNib:[UINib nibWithNibName:@"NNEmotionCaseCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"emotionCaseCollectionCell"];
    if(_caseTitleArrsy.count == 0){
        _scrollViewConstraint.constant = 0;
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)createEmotionalTypeUI {
    if (_caseTitleArrsy.count > 0) {
        _emotionalTypeScrollView.contentSize = CGSizeMake((NNAppWidth/3)*_caseTitleArrsy.count, 32);
        _emotionalTypeScrollView.delegate = self;
        for (UIView *view in _emotionalTypeScrollView.subviews) {
            [view removeFromSuperview];
        }
        for (int i = 0; i< _caseTitleArrsy.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*(NNAppWidth/_caseTitleArrsy.count), 0, NNAppWidth/_caseTitleArrsy.count, 32);
            [button setTitleColor:[UIColor colorFromHexString:@"333333"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorFromHexString:@"FF8833"] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor colorFromHexString:@"FF8833"] forState:UIControlStateHighlighted];
            button.tag = 100 + i;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [button setTitle:[_caseTitleArrsy objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(changeEmotionalType:) forControlEvents:UIControlEventTouchUpInside];
            [_emotionalTypeScrollView addSubview:button];
            if (i == 0) {
                defaultSelectButton = button;
                defaultSelectButton.selected = YES;
            }
        }

    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //设置cell大小
    self.emotionFlow.itemSize = self.emotionCollectionView.frame.size;
    
}

#pragma --mark Action 

- (void)changeEmotionalType :(UIButton *)button {
    if (button.tag != defaultSelectButton.tag) {
        defaultSelectButton.selected = NO;
        defaultSelectButton = button;
        defaultSelectButton.selected = YES;
        [_emotionCollectionView setContentOffset:CGPointMake((button.tag-100) * NNAppWidth, 0) animated:YES];
        
        NSLog(@"%@",button.titleLabel.text);
        
        if ([button.titleLabel.text isEqualToString:@"婚姻调色"]) {
            [MobClick event:@"clk_mother"];
        }else if ([button.titleLabel.text isEqualToString:@"家有一老"]) {
             [MobClick event:@"clk_HusbandWife"];
        }else if ([button.titleLabel.text isEqualToString:@"七年之痒"]) {
             [MobClick event:@"clk_family"];
        }else if ([button.titleLabel.text isEqualToString:@"家长里短"]) {
             [MobClick event:@"clk_ExtramaritalLove"];
        }else if ([button.titleLabel.text isEqualToString:@"爱情修炼"]) {
             [MobClick event:@"clk_CrushOn"];
        }else if ([button.titleLabel.text isEqualToString:@"情感挽回"]) {
             [MobClick event:@"clk_lovelorn"];
        }else if ([button.titleLabel.text isEqualToString:@"多维爱情"]) {
             [MobClick event:@"clk_complex"];
        }else if ([button.titleLabel.text isEqualToString:@"爱情探索"]) {
             [MobClick event:@"clk_love"];
        }else if ([button.titleLabel.text isEqualToString:@"男生向左"]) {
             [MobClick event:@"clk_relationship"];
        }else if ([button.titleLabel.text isEqualToString:@"女生向右"]) {
             [MobClick event:@"clk_LifeBelief"];
        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;

    for (UIButton *button in _emotionalTypeScrollView.subviews) {
        if (button.tag == currentPage + 100) {
            [self changeEmotionalType:button];
        }
    }
}

#pragma --mark UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.caseTypeArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NNEmotionCaseCollectionCell *emotionCaseCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"emotionCaseCollectionCell" forIndexPath:indexPath];
    emotionCaseCollectionCell.defaultType = [[_caseTypeArray objectAtIndex:indexPath.item] integerValue];
    emotionCaseCollectionCell.block = ^(NNSuccessCaseModel *model){
            NNArticleDetailVC *articleVC = [[NNArticleDetailVC alloc] init];
            articleVC.articleID = model.caseAdID;
            articleVC.artileTitle = model.caseTitle;
            articleVC.imageUrl = model.caseImageUrl;
            [self.navigationController pushViewController:articleVC animated:YES];
    };
    return emotionCaseCollectionCell;
}



#pragma --mark UITableViewDelegate UITableViewDatasource



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
