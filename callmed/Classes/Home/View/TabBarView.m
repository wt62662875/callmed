//
//  TabBarView.m
//  callmed
//
//  Created by sam on 16/7/18.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "TabBarView.h"
#import "TabItemView.h"

@interface TabBarView()

@property (nonatomic,strong) TabItemView *leftItem;
@property (nonatomic,strong) TabItemView *midItem;
//@property (nonatomic,strong) TabItemView *rightItem;

@end

@implementation TabBarView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}


- (void) initView
{
    _leftItem = [[TabItemView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _leftItem.tag = 0;
    [_leftItem setTitle:@"首页"];
    [_leftItem setImageUrlNormal:@"shouye1"];
    [_leftItem setImageUrlSelect:@"shouye"];
    UITapGestureRecognizer *g1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    g1.numberOfTapsRequired = 1;
    g1.numberOfTouchesRequired = 1;
    [_leftItem addGestureRecognizer:g1];
    
    [self addSubview:_leftItem];
    [_leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(self).dividedBy(2);
    }];
    
    _midItem = [[TabItemView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _midItem.tag = 1;
    [_midItem setTitle:@"出车"];
    [_midItem setImageUrlNormal:@"fache1"];
    [_midItem setImageUrlSelect:@"fache2"];
    [self addSubview:_midItem];
    [_midItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftItem.mas_right);
        make.top.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(self).dividedBy(2);
    }];
    //[_midItem setSelected:YES];
    UITapGestureRecognizer *g2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    g2.numberOfTapsRequired = 1;
    g2.numberOfTouchesRequired = 1;
    [_midItem addGestureRecognizer:g2];
    
//    _rightItem = [[TabItemView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    _rightItem.tag = 2;
//    [_rightItem setTitle:@"我的"];
//    [_rightItem setImageUrlNormal:@"xia3hui"];
//    [_rightItem setImageUrlSelect:@"heixia2"];
//    [self addSubview:_rightItem];
//    [_rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_midItem.mas_right);
//        make.top.equalTo(self);
//        make.height.equalTo(self);
//        make.width.equalTo(self).dividedBy(3);
//    }];
//    UITapGestureRecognizer *g3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
//    g3.numberOfTapsRequired = 1;
//    g3.numberOfTouchesRequired = 1;
//    [_rightItem addGestureRecognizer:g3];
}

- (void) gesture:(UITapGestureRecognizer*)recognizer
{
    NSInteger tag =recognizer.view.tag;
    for (TabItemView *view in self.subviews) {
        if (view == recognizer.view) {
            view.isSelected = YES;
        }else{
            view.isSelected = NO;
        }
    }
    
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonSelectedIndex:)]) {
        [_delegate buttonSelectedIndex:tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    int i = 0;
    for (TabItemView *view in self.subviews) {
        if (i == selectIndex) {
            view.isSelected = YES;
        }else{
            view.isSelected = NO;
        }
        i++;
    }
}

@end
