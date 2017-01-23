//
//  HomeBackView.h
//  callmed
//
//  Created by wt on 2017/1/13.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBackView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic,weak) id<TargetActionDelegate> delegate;

//@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@end
