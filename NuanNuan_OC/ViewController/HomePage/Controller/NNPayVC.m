//
//  NNPayVC.m
//  NuanNuan_OC
//
//  Created by 胡光耀 on 2017/6/11.
//  Copyright © 2017年 NuanNuan. All rights reserved.
//

#import "NNPayVC.h"
#import "NNPayCell.h"
#import "NNChoosePayCell.h"
#import "Define.h"
#import "NNPayDataModel.h"
#import "IpaynowPluginDelegate.h"
#import "IPNPreSignMessageUtil.h"
#import "IPNDESUtil.h"
#import "IpaynowPluginApi.h"
#import "NNPayDataViewModel.h"

#define kMerchantID @"merchant.cn.ipaynow.applepay"
#define kBtnFirstTitle    @"获取订单，开始支付"
#define kWaiting          @"正在获取订单,请稍候..."
#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果："

@interface NNPayVC () <UITableViewDelegate,UITableViewDataSource,IpaynowPluginDelegate> {
    NSTimer   *timer;
    NNPayCell *cell;
    NSInteger min;
    NSInteger sec ;
    NSArray   *payTitles;
    NSArray   *payImages;
    UIButton  *payWayButton;
    NSString  *payType;
    NSString  *mhtOrderNo;
    NSMutableString  *presignStr;
    
   ;
}

@property (weak, nonatomic) IBOutlet UITableView *payTableView;

@end

@implementation NNPayVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [IpaynowPluginApi setBeforeReturnLoadingHidden:false];
    [IpaynowPluginApi setMerchantID:kMerchantID];
    [self initView];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}


- (void)initView {
    [self setNavigationBackButton:YES];
    self.title = @"支付";
    _payTableView.backgroundColor = NN_BACKGROUND_COLOR;
    _payTableView.delegate = self;
    _payTableView.dataSource = self;
    _payTableView.tableFooterView = [self createFootView];
    _payTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_payTableView registerNib:[UINib nibWithNibName:@"NNPayCell" bundle:nil] forCellReuseIdentifier:@"NNPayCell"];
    [_payTableView registerNib:[UINib nibWithNibName:@"NNChoosePayCell" bundle:nil] forCellReuseIdentifier:@"NNChoosePayCell"];
    
    payTitles = @[@"微信支付",@"支付宝支付",@"银联支付"];
    payImages = @[@"ic_weChatPay",@"ic_aliPay",@"ic_UnionPay"];
}

- (UIView *)createFootView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, NNAppWidth, 80)];
    view.backgroundColor = NN_BACKGROUND_COLOR;
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom ];
    payButton.frame = CGRectMake(0, 40, NNAppWidth, 40);
    payButton.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:153/255.0 blue:158 / 255.0 alpha:1];
    [payButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:payButton];
    
    return view;
}

- (void)initData {
    min = 60;
    sec = 00;
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}



- (void)payAction:(UIButton *)button {
    NSString  *payChannelType;
    if ([payType isEqualToString:@"1"]) {
        payChannelType = @"13";
    }else if ([payType isEqualToString:@"2"]){
        payChannelType = @"12";
    }else{
        payChannelType = @"11";
    }
    
    __weak NNPayVC *weakSelf = self;
     NNPayDataViewModel *payDataViewModel = [[NNPayDataViewModel alloc] init];
    [payDataViewModel setBlockWithReturnBlock:^(id returnValue) {
        [weakSelf payByType:returnValue payChannelType:payChannelType];
    } WithErrorBlock:^(id errorCode) {
        [NNProgressHUD showHudAotoHideAddToView:self.view withMessage:errorCode ];
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    
    
    [payDataViewModel getPayData:TEST_TOKEN PayType:payType andOrderID:_orderId];
}


- (void)payByType:(NNPayDataModel *) payDataModel payChannelType:(NSString *)payChannelType{
    
    
    // 订单拼接
    IPNPreSignMessageUtil *preSign = [[IPNPreSignMessageUtil alloc] init];
    preSign.appId = payDataModel.appid;
    mhtOrderNo = payDataModel.mhtOrderNo;
    preSign.mhtOrderNo = payDataModel.mhtOrderNo;
    preSign.mhtOrderName = payDataModel.mhtOrderName;
    preSign.mhtOrderType = @"01";
    preSign.mhtCurrencyType = @"156";
    preSign.mhtOrderAmt = payDataModel.mhtOrderAmt;
    preSign.mhtOrderDetail = payDataModel.mhtOrderDetail;
    preSign.mhtOrderStartTime = payDataModel.mhtOrderStartTime;
    preSign.notifyUrl = payDataModel.mhtNotifyUrl;
    preSign.mhtCharset = payDataModel.mhtCharset;
    preSign.mhtOrderTimeOut = payDataModel.mhtOrderTimeOut;
    preSign.mhtReserved = payDataModel.mhtReserved;
    preSign.payChannelType = payChannelType;
 
    presignStr = [NSMutableString stringWithString:[preSign generatePresignMessage]];
    
    
    if (presignStr == nil) {
        NSLog(@"缺少字段");
        return;
    }
    NSString *payData = [presignStr stringByAppendingFormat:@"&mhtSignType=MD5&mhtSignature=%@",payDataModel.mhtSignature];
    
    [IpaynowPluginApi pay:payData AndScheme:@"NuanNuanIpay" viewController:self delegate:self];
}


#pragma mark - SDK的回调方法
- (void)iPaynowPluginResult:(IPNPayResult)result errorCode:(NSString *)errorCode errorInfo:(NSString *)errorInfo{
    NSString *resultString = @"";

    NNPayDataViewModel *payViewModel = [[NNPayDataViewModel alloc] init];
    [payViewModel setBlockWithReturnBlock:^(id returnValue) {
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^(id failureBlock) {
        
    }];
    switch (result) {
        case IPNPayResultFail:
            resultString = [NSString stringWithFormat:@"支付失败:\r\n错误码:%@,异常信息:%@",errorCode, errorInfo];
            [payViewModel payResult:TEST_TOKEN OrderId:_orderId mhtOrderNo:mhtOrderNo paystatus:@"1"];
            break;
        case IPNPayResultCancel:
            resultString = @"支付被取消";
            break;
        case IPNPayResultSuccess:
            resultString = @"支付成功";
           
            
            [payViewModel payResult:TEST_TOKEN OrderId:_orderId mhtOrderNo:mhtOrderNo paystatus:@"2"];
            break;
        case  IPNPayResultUnknown:
            resultString = [NSString stringWithFormat:@"支付结果未知:%@",errorInfo];
        default:
            break;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:kNote
                                                        message:resultString
                                                       delegate:self
                                              cancelButtonTitle:kConfirm
                                              otherButtonTitles:nil];
    [alertView show];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return [payTitles count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 350;
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NNPayCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.serverName.text = _serverName;
        cell.totalPayLabel.text = _money;
        cell.userName.text = _name;
        cell.wechatLabel.text = _wechat;
        cell.phoneLabel.text = _telphone;
        cell.orderLabel.text = _orderNO;
        
        NSMutableAttributedString *payMoney = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"应付金额：￥%@",_money]];
        [payMoney addAttribute:NSForegroundColorAttributeName  value:[UIColor colorFromHexString:@"#333333"] range:NSMakeRange(0, 5)];
        [payMoney addAttribute:NSForegroundColorAttributeName  value:NN_SECOND_COLOR range:NSMakeRange(5, payMoney.length - 5)];
        [payMoney addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:18]
                         range:NSMakeRange(0, payMoney.length -1)];
        cell.payLabel.attributedText = payMoney;
        
        
        return cell;
    }else{
        NNChoosePayCell *choosePayCell = [tableView dequeueReusableCellWithIdentifier:@"NNChoosePayCell"];
        choosePayCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [choosePayCell.payImageView setImage:[UIImage imageNamed:[payImages objectAtIndex:indexPath.row]]];
        choosePayCell.payWayLabel.text = [payTitles objectAtIndex:indexPath.row];
        choosePayCell.choosePayButton.tag = 100 + indexPath.row;
        [choosePayCell.choosePayButton addTarget:self action:@selector(choosePayWay:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row == 0) {
            choosePayCell.choosePayButton.selected = YES;
            payWayButton = choosePayCell.choosePayButton;
            payType = @"1";
        }
        return choosePayCell;
    }
}

- (void ) timeAction {
    sec -= 1;
    if (sec < 0) {
        sec = 59;
        min -= 1;
    }
    if (min < 0) {
        [timer invalidate];
        min = 0;
    }
    
    NSString *minStr =  min < 10 ? [NSString stringWithFormat:@"0%ld",(long)min] : [NSString stringWithFormat:@"%ld",(long)min] ;
    NSString *secStr =  sec < 10 ? [NSString stringWithFormat:@"0%ld",(long)sec] : [NSString stringWithFormat:@"%ld",(long)sec] ;
    NSMutableAttributedString *timeAttributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"请在%@:%@分钟内支付，否则订单会被取消",minStr,secStr]];
    [timeAttributeString addAttribute:NSForegroundColorAttributeName  value:[UIColor colorFromHexString:@"#333333"] range:NSMakeRange(0, 2)];
    [timeAttributeString addAttribute:NSForegroundColorAttributeName  value:NN_SECOND_COLOR range:NSMakeRange(2, 5)];
    [timeAttributeString addAttribute:NSForegroundColorAttributeName  value:[UIColor colorFromHexString:@"#333333"] range:NSMakeRange(7, timeAttributeString.length - 7)];
    cell.timerlabel.attributedText = timeAttributeString;
    
}


- (void)choosePayWay:(UIButton *)button {
    payWayButton.selected = NO;
    payWayButton = button;
    payWayButton.selected = YES;
    if (button.tag == 100) {
        payType = @"1";
    }else if (button.tag == 101){
        payType = @"2";
    }else{
        payType = @"3";
    }
}


- (void)dealloc {
    timer = nil;
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
