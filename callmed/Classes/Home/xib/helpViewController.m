//
//  helpViewController.m
//  callmed
//
//  Created by wt on 2017/1/20.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "helpViewController.h"
#import "recommendPassengersViewController.h"
#import "BrowerController.h"

@interface helpViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionlabel;



@end

@implementation helpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"帮助"];
    _versionlabel.text = [NSString stringWithFormat:@"当前版本：%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    self.view.backgroundColor = RGBHex(g_assit_gray);
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)buttonClick:(UIButton *)sender {
    recommendPassengersViewController *recommendPassengersVC = [[recommendPassengersViewController alloc]initWithNibName:@"recommendPassengersViewController" bundle:nil];
    BrowerController *brower = [[BrowerController alloc] init];

    switch (sender.tag) {
        case 0:
            [self.navigationController pushViewController:recommendPassengersVC animated:YES];
            break;
        case 1:
            [CommonUtility callTelphone:[GlobalData sharedInstance].user.userInfo.serviceNo];

            break;
        case 2:
            [brower setTitleStr:@"使用指南"];
            brower.urlStr =[NSString stringWithFormat:@"%@getArticle?id=100&token=%@",
                            kserviceURL,
                            [GlobalData sharedInstance].user.session];
            [self.navigationController pushViewController:brower animated:YES];
            break;
        case 3:
            [brower setTitleStr:@"法律条款"];
            brower.urlStr =[NSString stringWithFormat:@"%@getArticle?id=2&token=%@",
                            kserviceURL,
                            [GlobalData sharedInstance].user.session];
            [self.navigationController pushViewController:brower animated:YES];
            break;
        case 4:
            [brower setTitleStr:@"版本信息"];
            brower.urlStr =[NSString stringWithFormat:@"%@getArticle?id=3&token=%@&version=%@",
                            kserviceURL,
                            [GlobalData sharedInstance].user.session,
                            [CommonUtility versions]];
            [self.navigationController pushViewController:brower animated:YES];
            break;
        default:
            break;
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
