//
//  allOrderViewController.m
//  callmed
//
//  Created by wt on 2016/12/27.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "allOrderViewController.h"
#import "allOrderTableViewCell.h"

@interface allOrderViewController ()
{
    NSMutableArray *datasArray;
    NSInteger pages;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation allOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"全部订单"];
    [self getDatas:1];
    _balanceLabel.text = _balance;
    pages = 1;
    _tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pages = 1;
        [self getDatas:pages];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        pages++;
        [self getDatas:pages];
    }];    // Do any additional setup after loading the view from its nib.
}
-(void)getDatas:(NSInteger )page{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_accountId forKey:@"accountId"];
    [params setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [params setObject:@"5" forKey:@"pageSize"];

    [HttpShareEngine callWithFormParams:params withMethod:@"listDAccountLog" succ:^(NSDictionary *resultDictionary) {
        NSLog(@"resultDictionary:%@",resultDictionary);
        if (page == 1) {
            datasArray = [[NSMutableArray alloc]initWithArray:[resultDictionary objectForKey:@"rows"]];
        }else{
            [datasArray addObjectsFromArray:[resultDictionary objectForKey:@"rows"]];
        }
        
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"errorMessage:%@",errorMessage);
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
}
#pragma mark CELL的row数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datasArray.count;
}
#pragma mark CELL的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0;
}
#pragma mark CELL的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"allOrderTableViewCell";
    allOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"allOrderTableViewCell" owner:self options:nil][0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.nameLabel.text = [datasArray[indexPath.row] objectForKey:@"description"];
    cell.money.text = [NSString stringWithFormat:@"￥%@",[datasArray[indexPath.row] objectForKey:@"incomeCmoney"]];
    cell.timelabel.text =[datasArray[indexPath.row] objectForKey:@"createDate"];
    
    return cell;

    
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
