//
//  SelectedMenuVC.m
//  AnimationTest
//
//  Created by qianzhan on 16/1/19.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import "SelectedMenuVC.h"
#import "MenuCell.h"

@interface SelectedMenuVC ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *_tableView;
    UIView *header;
    
}

@end

@implementation SelectedMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    self.view.clipsToBounds = YES;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)]];
}

- (void)hidden{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _tableView.frame  = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0);
        header.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0);
        self.view.alpha = 0.2;
        
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
    }];
}

- (void)showInViewController:(UIViewController*)VC{
    [self initTableView];
    [self returHeader];
    
    [VC addChildViewController:self];
    self.view.frame = CGRectMake(0, -45, VC.view.frame.size.width, VC.view.frame.size.height);
    [VC.view addSubview:self.view];
    
    CGFloat height = _menuArr.count > 4 ? 4*35 : _menuArr.count*35;
    
    [UIView animateWithDuration:0.3 animations:^{
        _tableView.frame  = CGRectMake(0, self.view.frame.size.height-height, self.view.frame.size.width, height);
        header.frame = CGRectMake(0, self.view.frame.size.height-30-height, self.view.frame.size.width, 30);
    }];
    
}

- (void)returHeader{
    
    header = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, 0)];
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, 0, 80, 30)];
    [btn setTitle:@"清空购物车" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clearShoppingBox) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [header addSubview:btn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 30-1, [UIScreen mainScreen].bounds.size.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [header addSubview:line];
}

#pragma mark UITableView
- (void)initTableView{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)clearShoppingBox{
    [_menuArr removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeItemCount" object:nil userInfo:nil];
    [self hidden];
}

#pragma mark
#pragma mark ---------------tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = [NSString stringWithFormat:@"menuCell_%ld", (long)indexPath.row];
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.itemModel = [_menuArr objectAtIndex:indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.deleteBlock = ^(ItemModel *model){
        
        [_menuArr removeObject:model];
        
        if (_menuArr.count>0) {
            
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            
            CGFloat height = _menuArr.count > 4 ? 4*35 : _menuArr.count*35;
            [UIView animateWithDuration:0.3 animations:^{
                header.frame = CGRectMake(0, self.view.frame.size.height-30-height, self.view.frame.size.width, 30);
                _tableView.frame  = CGRectMake(0, self.view.frame.size.height-height, self.view.frame.size.width, height);
            }];
            
        }else{
            [weakSelf hidden];
        }
        
    };
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
