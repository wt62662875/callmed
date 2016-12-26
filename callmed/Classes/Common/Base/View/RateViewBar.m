//
//  TXRateViewBar.m
//  crownbee
//
//  Created by sam on 16/5/19.
//  Copyright © 2016年 张小聪. All rights reserved.
//

#import "RateViewBar.h"


//@property (nonatomic,strong) UIImageView *starImageView;
@implementation RateViewBar
{
    NSMutableArray *dataLightArray;
    NSMutableArray *dataGrayArray;
    UIView *lightView;
}

- (instancetype) init
{
    self = [self initWithFrame:CGRectMake(0, 0, 50, 25)];
    if (self) {
        
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        dataLightArray = [NSMutableArray array];
        dataGrayArray  = [NSMutableArray array];
        UIImage *image = [UIImage imageNamed:@"icon_sart_ss2"];
        lightView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x,
                                                             self.frame.origin.y,
                                                             image.size.width*5,
                                                             image.size.height)];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, image.size.width*5,image.size.height)];
        for (int i=0; i<5; i++) {
            
            UIImageView *star_light = [[UIImageView alloc] initWithImage:image];
            
            [dataLightArray addObject:star_light];
            [star_light setFrame:CGRectMake(i*image.size.width, 0,image.size.width, image.size.height)];
            [self addSubview:star_light];
            
            UIImageView *star_gray = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_sart_ss1"]];
            [star_gray setFrame:CGRectMake(i*image.size.width, 0,image.size.width, image.size.height)];
            [lightView addSubview:star_gray];
        }
        [lightView setFrame:CGRectMake(0, 0, image.size.width/2, image.size.height)];
        [lightView setClipsToBounds:YES];
        [self addSubview:lightView];
    }
    return  self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setRateNumber:(CGFloat)rateNumber
{
    CGFloat width = 0;
    if (rateNumber>0) {
        width = (self.frame.size.width/5)*rateNumber;
    }
    [lightView setFrame:CGRectMake(0, 0, width,self.frame.size.height)];
}
@end
