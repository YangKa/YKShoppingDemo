//
//  MainViewController.m
//  YKShoppingDemo
//
//  Created by qiager on 16/1/22.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"
#import "JudgeViewController.h"
#import "SellerViewController.h"

@interface MainViewController ()<UIScrollViewDelegate>{
    UIView *topLine;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MenuViewController *menuVC;

@property (nonatomic, strong) JudgeViewController *judgeVC;

@property (nonatomic, strong) SellerViewController *sellerVC;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"小杨菜馆";
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    
    _menuVC  = [[MenuViewController alloc] init];
    [self addChildViewController:_menuVC];
    
    _judgeVC = [[JudgeViewController alloc] init];
    [self addChildViewController:_judgeVC];
    
    _sellerVC = [[SellerViewController alloc] init];
    [self addChildViewController:_sellerVC];
    
    [self initTopView];
    
    [self initScrollView];
}

- (void)initTopView{
    CGFloat width = self.view.frame.size.width/3;
    CGFloat height = 35;
    
    NSArray *arr = @[@"商品", @"评价", @"商家"];
    
    for (int i =  0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(width*i, 64, width, height)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(touchTopView:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        btn.tag = i;
        [self.view addSubview:btn];
        
        if (i == 0) {
            btn.selected = YES;
        }
    }
    
    topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 64+35, width, 2)];
    topLine.backgroundColor = [UIColor colorWithRed:57/255.0 green:147/255.0 blue:230/255.0 alpha:1.0];
    [self.view addSubview:topLine];
}

- (void)touchTopView:(UIButton*)btn{
    [self.view.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)obj;
            if (button.tag == btn.tag) {
                button.selected = YES;
            }else{
                button.selected = NO;
            }
        }
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.contentOffset = CGPointMake(btn.tag*self.view.frame.size.width, _scrollView.contentOffset.y);
        
    }];
}

- (void)initScrollView{
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height-64-37;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+37, width, height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(width*3, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    _menuVC.view.frame = CGRectMake(0, 0, width, height);
    [_scrollView addSubview:_menuVC.view];
    
    _judgeVC.view.frame = CGRectMake(width, 0, width, height);
    [_scrollView addSubview:_judgeVC.view];
    
    _sellerVC.view.frame = CGRectMake(width*2, 0, width, height);
    [_scrollView addSubview:_sellerVC.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    
    CGFloat moveX = (x/(2*scrollView.frame.size.width))*self.view.frame.size.width*(2/3.0);
    
    CGRect frame = topLine.frame;
    frame.origin.x = moveX;
    topLine.frame = frame;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
