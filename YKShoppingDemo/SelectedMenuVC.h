//
//  SelectedMenuVC.h
//  AnimationTest
//
//  Created by qianzhan on 16/1/19.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedMenuVC : UIViewController

@property (nonatomic , strong) NSMutableArray *menuArr;

- (void)hidden;

- (void)showInViewController:(UIViewController*)VC;
@end
