//
//  TripCataController.m
//  callmed
//
//  Created by sam on 16/7/19.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "TripCataController.h"
#import "TripScrollerView.h"
#import "OrderViewCell.h"

#import "TripOneController.h"
#import "TripTwoController.h"
#import "TripThreeController.h"
#import "TripFourController.h"
#import "MessageController.h"

#import "OrderModel.h"

@interface TripCataController()<TargetActionDelegate>
@property (nonatomic,strong) TripScrollerView *tripView;
@property (nonatomic,assign) UIViewController *currentController;
@end

@implementation TripCataController


- (void) viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadRedBall:) name:NOTICE_NEED_REDBALL object:nil];
    [super viewDidLoad];
    [self initData];
    [self initView];
}


- (void) initData
{
    [self addChildViewController:[[TripOneController alloc] init]];
    [self addChildViewController:[[TripTwoController alloc] init]];

}

- (void) initView
{
    [self setTitle:@"最新订单"];
    [self setHiddenHeader:YES];

    
    if ([GlobalData sharedInstance].user.isLogin) {
        if ([@"1" isEqualToString:[GlobalData sharedInstance].user.userInfo.type]) {
            _tripView = [[TripScrollerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) selected:0];
            [self buttonSelectedIndex:0];
        }else if ([@"2" isEqualToString:[GlobalData sharedInstance].user.userInfo.type]) {
            _tripView = [[TripScrollerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) selected:1];
            [self buttonSelectedIndex:1];
        }
    }else{
        _tripView = [[TripScrollerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) selected:0];
        [self buttonSelectedIndex:0];
    }
    [_tripView setDelegate:self];
    [_tripView setDataArray:[NSArray arrayWithObjects:@"专车",@"快车", nil]];
    [self.view addSubview:_tripView];
    [_tripView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.width.equalTo(self.view);
    }];
    
}

- (void) buttonTarget:(id)sender
{
    
}

- (void) buttonSelectedIndex:(NSInteger)index
{
    if (_currentController) {
        [_currentController.view removeFromSuperview];
    }
    _currentController = self.childViewControllers[index];
    if (_currentController)
    {
        [self.view addSubview:_currentController.view];
        [_currentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom);
            make.left.equalTo(self.view);
            make.width.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        if ([_currentController respondsToSelector:@selector(reloadData)])
        {
            [_currentController performSelector:@selector(reloadData) withObject:nil];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) reloadData
{
    if (_notice_model) {
        
        if ([@"1" isEqualToString:_notice_model.oType])
        {
            [_tripView setSelectIndex:0];
            [self buttonSelectedIndex:0];
        }else if ([@"2" isEqualToString:_notice_model.oType])
        {
            [_tripView setSelectIndex:1];
        }else if ([@"3" isEqualToString:_notice_model.oType])
        {
            [_tripView setSelectIndex:3];
        }else if ([@"4" isEqualToString:_notice_model.oType])
        {
            [_tripView setSelectIndex:2];
        }
    }else{
        if (_currentController && [_currentController respondsToSelector:@selector(reloadData)])
        {
            [_currentController performSelector:@selector(reloadData) withObject:nil];
        }
    }
    [self fetchOrderNumber];
}

- (void) reloadRedBall:(id)sender
{
    [self fetchOrderNumber];
}

- (void) fetchOrderNumber{

    [OrderModel driverOrderNumberBydriverId:@"" latesd:@"3" succes:^(NSDictionary *resultDictionary) {
        NSLog(@"resultDictionary:%@",resultDictionary);
        NSDictionary *data = resultDictionary[@"data"];
        NSInteger pooling =  [data[@"2"] integerValue];
        [_tripView updateRedBobble:1 withNumber:pooling];
//        NSInteger goods =[data[@"3"] integerValue];
//        [_tripView updateRedBobble:3 withNumber:goods];
    } failed:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"errorMessage:%@",errorMessage);
    }];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end