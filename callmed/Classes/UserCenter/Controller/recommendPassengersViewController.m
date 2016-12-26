//
//  recommendPassengersViewController.m
//  callmed
//
//  Created by wt on 2016/11/21.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "recommendPassengersViewController.h"
#import "recommendPassengersTableViewCell.h"

@interface recommendPassengersViewController ()
{
    NSArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;

@end

@implementation recommendPassengersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"推荐乘客"];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.view setBackgroundColor:RGB(235, 235, 235)];
    _tableView.layer.cornerRadius = 5;
    _tableView.layer.masksToBounds = YES;
    
    
    // Do any additional setup after loading the view from its nib.
    [self getdatas];
}
-(void)getdatas{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if([GlobalData sharedInstance].user.isLogin)
    {
        [params setObject:[GlobalData sharedInstance].user.userInfo.ids forKey:@"driverId"];
    }
    [params setObject:[GlobalData sharedInstance].user.userInfo.phoneNo forKey:@"introducer"];

    [HttpShareEngine callWithFormParams:params withMethod:@"listMemberShip" succ:^(NSDictionary *resultDictionary) {
        NSLog(@"resultDictionary=%@",resultDictionary);
        _personLabel.text = [NSString stringWithFormat:@"%@人",[resultDictionary objectForKey:@"total"]];
        dataArray = [[NSArray alloc]initWithArray:[resultDictionary objectForKey:@"rows"]];
        [_tableView reloadData];
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"errorMessage:%@",errorMessage);
    }];
}
#pragma mark CELL的row数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count + 1;
}
#pragma mark CELL的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"recommendPassengersTableViewCell";
    recommendPassengersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"recommendPassengersTableViewCell" owner:self options:nil][0];
    }

    if (indexPath.row != 0) {
        cell.nameLabel.textColor = RGB(113, 122, 135);
        cell.phoneNumberLabel.textColor = RGB(113, 122, 135);
        cell.nameLabel.text = [dataArray[indexPath.row-1] objectForKey:@"realName"];
        cell.phoneNumberLabel.text = [dataArray[indexPath.row-1] objectForKey:@"phoneNo"];
    }


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
