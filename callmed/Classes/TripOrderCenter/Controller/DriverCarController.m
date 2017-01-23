//
//  DriverCarController.m
//  callmed
//
//  Created by sam on 16/7/19.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "DriverCarController.h"
#import "CarStatusModel.h"
#import "CarStatusCell.h"

@interface DriverCarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation DriverCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) initData
{
    
    _dataArray =[NSArray arrayWithObjects:
    [[CarStatusModel alloc] initWithDictionary:@{@"imageUrl":@"che1",
                                                 @"title":@"专车",
                                                 @"type":@"1",
                                                 @"status":@"0",
                                                 @"height":@(40)} error:nil],
    [[CarStatusModel alloc] initWithDictionary:@{@"imageUrl":@"che2",
                                                 @"title":@"快车",
                                                 @"type":@"2",
                                                 @"status":@"0",
                                                 @"height":@(40)} error:nil],nil];
}

- (void) viewDidAppear:(BOOL)animated
{
    if ([GlobalData sharedInstance].user.isLogin) {
        NSInteger tripType = [[GlobalData sharedInstance].user.userInfo.type integerValue];
        NSInteger ready =[[GlobalData sharedInstance].user.userInfo.ready integerValue];
        [self changeCarStatus:tripType withReady:ready];
    }
    [_mTableView reloadData];
}

- (void) changeCarStatus:(NSInteger)index withReady:(NSInteger)ready
{
    if (index==1) {
         ((CarStatusModel*)_dataArray[0]).status = ready;
         ((CarStatusModel*)_dataArray[1]).status = 0;
    }else if (index==2) {
        ((CarStatusModel*)_dataArray[0]).status = 0;
        ((CarStatusModel*)_dataArray[1]).status = ready;
    }else{
        ((CarStatusModel*)_dataArray[0]).status = 0;
        ((CarStatusModel*)_dataArray[1]).status = 0;
    }
}

- (void) initView
{
    [self setTitle:@"出车"];
    [self setHiddenHeader:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mTableView = [[UITableView alloc] init];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    [_mTableView setBackgroundColor:RGBHex(g_assit_gray)];
    _mTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _mTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mTableView];
    [_mTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}


#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"cellid";
    CarStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[CarStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.model = _dataArray[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([@"1" isEqualToString:[GlobalData sharedInstance].user.userInfo.passed]) {
        CarStatusModel *model = _dataArray[indexPath.section];
        
        if (model.status==0) {
            model.status = 1;
        }else{
            model.status = 0;
        }
        [self changeCarStatusWithModel:model section:indexPath.section];
    }else{
        [MBProgressHUD showAndHideWithDetail:@"审核未通过，暂不能出车，请完善你的个人信息！" forHUD:nil];
    }
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [view setBackgroundColor:[UIColor whiteColor]];
        UILabel *title =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [title setText:@"选择出车业务"];
        [title setFont:[UIFont systemFontOfSize:15]];
        [view addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(10);
        }];
        return view;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }
    return 0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) changeCarStatusWithModel:(CarStatusModel*)model section:(NSInteger)section
{

    MBProgressHUD *pub = [MBProgressHUD showProgressView:@"请稍后..." inView:nil];
    [pub show:YES];
    [CarStatusModel driverUpdateStatusType:model.type status:model.status success:^(NSDictionary *resultDictionary) {
        if (model.status == 1) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"outCarJump" object:[NSString stringWithFormat:@"%ld",(long)section]];
        }

        [[GlobalData sharedInstance].user.userInfo setType:model.type];
        [[GlobalData sharedInstance].user.userInfo setReady:[NSString stringWithFormat:@"%ld",(long)model.status]];
        [[GlobalData sharedInstance].user save];
        
        [pub hide:YES];
        [self.mTableView reloadData];
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        [pub hide:YES];
        if (model.status==0) {
            model.status = 1;
        }else{
            model.status = 0;
        }
        [MBProgressHUD showAndHideWithDetail:errorMessage forHUD:nil];
    }];
}

@end
