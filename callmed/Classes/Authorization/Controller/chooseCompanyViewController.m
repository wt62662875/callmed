//
//  chooseCompanyViewController.m
//  callmed
//
//  Created by wt on 2016/11/16.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "chooseCompanyViewController.h"
#import "chooseCompanyTableViewCell.h"

@interface chooseCompanyViewController ()<UITextFieldDelegate>
{
    NSArray *datasArray;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation chooseCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"请选择所属公司"];
    [self.rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view from its nib.
    
    [self getDatas:@""];
}
#pragma mark CELL的row数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datasArray.count;
}
#pragma mark CELL的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
#pragma mark CELL的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"chooseCompanyTableViewCell";
    chooseCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"chooseCompanyTableViewCell" owner:self options:nil][0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.nameLabel.text = [datasArray[indexPath.row] objectForKey:@"name"];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate getCompanyDatas:datasArray[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getDatas:(NSString *)name{
    [MBProgressHUD showAndHideWithMessage:@"正在加载数据中....." forHUD:nil];
    
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:@"1", @"page",@"100",@"pageSize",name,@"name",nil];
    [HttpShareEngine callWithFormParams:params withMethod:@"listDepartment" succ:^(NSDictionary *resultDictionary) {
        NSLog(@"%@",resultDictionary);
        datasArray = [[NSArray alloc]initWithArray:[resultDictionary objectForKey:@"rows"]];
        [_tableView reloadData];
        
    } fail:^(NSInteger errorCode, NSString *errorMessage) {
        [MBProgressHUD showAndHideWithMessage:@"系统繁忙，请稍后再试..." forHUD:nil];
    }];

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self getDatas:_textField.text];
    [textField resignFirstResponder];
    return YES;
}

-(void)buttonTarget:(id)sender{
    if (self.leftButton == sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self getDatas:_textField.text];
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