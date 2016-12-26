//
//  BottomDialogView.m
//  callmec
//
//  Created by sam on 16/7/22.
//  Copyright © 2016年 sam. All rights reserved.
//

#import "BottomDialogView.h"

@interface BottomDialogView()

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UIView *container;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UIView *lastView;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation BottomDialogView


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
    _index = 0;
    _dataArray =[NSMutableArray array];
    [self setBackgroundColor:RGBHexa(g_black, 0.5)];
    _container = [[UIView alloc] init];
    [_container setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_container];
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(150);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:@"标题"];
    [_titleLabel setNumberOfLines:1];
    [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    [_container addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_container);
        make.top.equalTo(_container).offset(5);
        make.height.mas_equalTo(30);
    }];
    
    _descLabel = [[UILabel alloc] init];
    [_descLabel setText:@""];
    [_descLabel setTextAlignment:NSTextAlignmentCenter];
    [_descLabel setTextColor:RGBHex(g_gray)];
    [_descLabel setNumberOfLines:0];
    [_descLabel setFont:[UIFont systemFontOfSize:14]];
    [_descLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [_container addSubview:_descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_container);
        make.top.equalTo(_titleLabel.mas_bottom).offset(0);
        make.left.equalTo(_container).offset(10);
        make.right.equalTo(_container).offset(-10);
        make.height.mas_equalTo(30);
//        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    _lineView =[[UIView alloc] init];
    [_lineView setBackgroundColor:RGBHex(g_gray)];
    [_container addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_container);
        make.left.equalTo(_container);
        make.top.equalTo(_descLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_container];
    if (point.y<0) {
        [self removeFromSuperview];
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void) updateContainerHeight:(CGFloat)height
{
    [_container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void) addContainerView:(UIView*)view
{
    //NSInteger indx = _index%self.columnNumber;
    [_dataArray addObject:view];
    [_container addSubview:view];
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).offset(0);
        make.bottom.equalTo(_container);
        make.width.equalTo(_container).multipliedBy(((CGFloat)1/(CGFloat)self.columnNumber));
        if(_lastView) {
            make.left.equalTo(_lastView.mas_right);
        }else{
            make.left.equalTo(_container);
        }
    }];
    if ([view isKindOfClass:[UIButton class]]) {
        [((UIButton*)view) addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    }else{
    
    }
    _index++;
    _lastView = view;
}

- (NSInteger) columnNumber
{
    if (_columnNumber==0) {
        _columnNumber = 3;
        return 3;
    }
    return _columnNumber;
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:_title];
}

- (void) setDesc:(NSString *)desc
{
    _desc = desc;
    [_descLabel setText:_desc];
    CGSize size = [_desc sizeFont:14];
    [_descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
}

- (void) buttonTarget:(UIButton*)button
{
    if (_delegate &&[_delegate respondsToSelector:@selector(buttonSelected:Index:)]) {
        [_delegate buttonSelected:button Index:button.tag];
    }
    [self removeFromSuperview];
}
@end
