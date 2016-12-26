//
//  SearchAddressController.m
//  callmec
//
//  Created by sam on 16/6/30.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "SearchAddressController.h"
#import "CMLocation.h"
#import "CMSearchManager.h"
#import "CityOptionsView.h"

@interface SearchAddressController()<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic, strong) UISearchBar *searchBar;
//@property (nonatomic, strong) UISearchDisplayController *displayController;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) CityOptionsView *optionView;
@property (nonatomic, strong) UITextField *inputText;
@property (nonatomic, strong) UIView *searchBar;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UITableView *mTableView;
@end


@implementation SearchAddressController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _text = @"";
        _city = [GlobalData sharedInstance].city;
        _locations = [NSMutableArray array];
    }
    return self;
}

- (void) initView
{
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSearchBar];
    [self initSearchDisplay];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [_searchBar becomeFirstResponder];
    if (self.text.length > 0)
    {
        [self searchTipsWithKey:self.text];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

#pragma mark - Initialization

- (void)initSearchBar
{
    /*
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.view.bounds), 44)];
    self.searchBar.barStyle     = UIBarStyleBlack;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    self.searchBar.placeholder = @"搜索";
    self.searchBar.text = self.text;
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    //self.navigationItem.titleView = self.searchBar;
    [self.searchBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.searchBar];
    */
    _searchBar =[[UIView alloc] init];    
    _optionView = [[CityOptionsView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [_searchBar addSubview:_optionView];
    [_optionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchBar).offset(10);
        make.top.equalTo(_searchBar);
        make.height.equalTo(_searchBar);
    }];
    [_optionView setTitle:self.city];
    
    _inputText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [_inputText setFont:[UIFont systemFontOfSize:14]];
    [_inputText setPlaceholder:@"输入地址"];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_searchBar addSubview:_inputText];
    
    [_inputText addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];

    [_inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_optionView.mas_right).offset(5);
        make.centerY.equalTo(_searchBar);
        make.right.equalTo(_searchBar).offset(-60);
    }];
    [_searchBar addSubview:_cancelBtn];
    
    [_cancelBtn setTitleColor:RGBHex(g_red) forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputText.mas_right).offset(5);
        make.centerY.equalTo(_searchBar);
    } ];
    [self.headerView addSubview:_searchBar];
    [self.leftButton setHidden:YES];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(20);
        make.left.equalTo(self.headerView).offset(0);
        make.right.equalTo(self.headerView).offset(0);
        make.height.mas_equalTo(44);
    }];
}

- (void)initSearchDisplay
{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 300) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [self.view addSubview:_mTableView];
    
    [_mTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    /*
    self.displayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.displayController.delegate                = self;
    self.displayController.searchResultsDataSource = self;
    self.displayController.searchResultsDelegate   = self;
    self.displayController.displaysSearchBarInNavigationBar = YES;
    */
    if (self.city) {
        [self searchTipsWithKey:self.city];
    }else{
        [self searchTipsWithKey:[GlobalData sharedInstance].city];
    }
    

}

#pragma mark - Helpers

- (void)searchTipsWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.requireExtension = YES;
    request.keywords = key;
    
    if (self.city.length > 0)
    {
        request.city = self.city?self.city:[GlobalData sharedInstance].city;
    }
    
    __weak __typeof(&*self) weakSelf = self;
    [[CMSearchManager sharedInstance] searchForRequest:request completionBlock:^(id request, id response, NSError *error) {
        if (error)
        {
            NSLog(@"error :%@", error);
        }
        else
        {
            [weakSelf.locations removeAllObjects];
            
            AMapPOISearchResponse *aResponse = (AMapPOISearchResponse *)response;
            [aResponse.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop)
             {
                 CMLocation *location = [[CMLocation alloc] init];
                 location.name = obj.name;
                 location.coordinate = CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude);
                 location.address = obj.address;
                 location.cityCode = obj.citycode;
                 location.city = obj.city;
                 [weakSelf.locations addObject:location];
             }];
            
            [weakSelf.mTableView reloadData];
        }
    }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.text = searchBar.text;
    [self searchTipsWithKey:self.text];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    self.text = searchString;
    [self searchTipsWithKey:self.text];
    
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    CMLocation *location = self.locations[indexPath.row];
    
    cell.textLabel.text = location.name;
    cell.detailTextLabel.text = location.address;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchBar resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CMLocation *location = self.locations[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(searchViewController:didSelectLocation:)])
    {
        [_delegate searchViewController:self didSelectLocation:location];
    }else if (self.delegateCallback)
    {
        [self.delegateCallback callback:location];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) valueChanged:(UITextField*)field
{
    [self searchTipsWithKey:field.text];
}

@end
