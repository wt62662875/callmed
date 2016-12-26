//
//  CancelView.m
//  callmec
//
//  Created by sam on 16/8/14.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "DriverTypeView.h"

@implementation DriverTypeModel


@end

@interface DriverTypeView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIButton *buttonSubmit;
@property (nonatomic,strong) UIView *bottom_container;

@end

@implementation DriverTypeView
{
    NSInteger cancelTimes;
    DriverTypeModel *cmodel;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initView];
    }
    return self;
}

- (void) initData
{
    _dataArray = [NSMutableArray array];
    
    [_dataArray addObject:[[DriverTypeModel alloc] initWithDictionary:@{@"id":@"0",@"name":@"C1"} error:nil]];
    [_dataArray addObject:[[DriverTypeModel alloc] initWithDictionary:@{@"id":@"1",@"name":@"C2"} error:nil]];
    [_dataArray addObject:[[DriverTypeModel alloc] initWithDictionary:@{@"id":@"2",@"name":@"A1"} error:nil]];
    [_dataArray addObject:[[DriverTypeModel alloc] initWithDictionary:@{@"id":@"3",@"name":@"A2"} error:nil]];
    [_dataArray addObject:[[DriverTypeModel alloc] initWithDictionary:@{@"id":@"4",@"name":@"A3"} error:nil]];
    [_dataArray addObject:[[DriverTypeModel alloc] initWithDictionary:@{@"id":@"5",@"name":@"B1"} error:nil]];
    [_dataArray addObject:[[DriverTypeModel alloc] initWithDictionary:@{@"id":@"6",@"name":@"B2"} error:nil]];
}

- (void) initView
{
    [self setBackgroundColor:RGBHexa(g_black, 0.5)];//[ImageTools imageWithColor:RGBHexa(g_assit_gray, 0.5)]
    _containerView = [[UIView alloc]  init];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.mas_equalTo(300);
        make.bottom.equalTo(self);
    }];
    
    _titleLabel =[[UILabel alloc] init];
    [_titleLabel setText:@"请选择"];
    [_containerView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_containerView);
        make.centerX.equalTo(_containerView);
        make.height.mas_equalTo(30);
    }];
    
    
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchCancelList];
    }];
    [_mTableView.mj_header beginRefreshing];
    
    [_containerView addSubview:_mTableView];
    _bottom_container =[[UIView alloc] init];
    [_bottom_container setBackgroundColor:[UIColor whiteColor]];
    [_containerView addSubview:_bottom_container];
    [_bottom_container setHidden:YES];
    [_bottom_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_containerView);
        make.right.equalTo(_containerView);
        make.bottom.equalTo(_containerView);
        make.height.mas_equalTo(80);
    }];
    
    _buttonSubmit =[UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonSubmit.layer setCornerRadius:5];
    [_buttonSubmit.layer setMasksToBounds:YES];
    [_buttonSubmit setTitle:@"确定" forState:UIControlStateNormal];
    [_buttonSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonSubmit addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonSubmit setBackgroundImage:[ImageTools imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [_bottom_container addSubview:_buttonSubmit];
    
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
//        make.bottom.equalTo(_bottom_container.mas_top);
        make.bottom.equalTo(self);
    }];
    
    
    [_buttonSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottom_container);
        make.centerY.equalTo(_bottom_container);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(40);
    }];
    
    [self tranlateAnimation:_containerView];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_containerView];
    if (point.y<0) {
        [self removeFromSuperview];
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void) tranlateAnimation:(UIView *)views
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;   //时间间隔
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillRuleEvenOdd;//kCAFillModeForwards;
    animation.type = kCATransitionMoveIn;         //动画效果
    animation.subtype = kCATransitionFromTop;   //动画方向
    [views.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    DriverTypeModel *model = _dataArray[indexPath.section];
    [cell.textLabel setText:model.name];
    [cell.imageView setImage:[UIImage imageNamed:@"icon_userss"]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cmodel = _dataArray[indexPath.section];
    if (cmodel) {
        if (_block && cmodel) {
            _block([cmodel.ids integerValue],cmodel.name);
        }
        [self removeFromSuperview];
    }
}


- (void)buttonTarget:(id)sender
{
    if(self.buttonSubmit == sender){
        if (_block && cmodel) {
            _block([cmodel.ids integerValue],cmodel.name);
        }
        [self removeFromSuperview];
    }
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void) fetchCancelList
{
    [self.mTableView.mj_header endRefreshing];
}

- (void) dealloc
{
    NSLog(@"CancelView dealloc");
}
@end