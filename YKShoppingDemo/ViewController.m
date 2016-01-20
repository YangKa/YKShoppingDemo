//
//  ViewController.m
//  AnimationTest
//
//  Created by qianzhan on 16/1/18.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import "ViewController.h"
#import "OrderCell.h"
#import "ItemModel.h"
#import "SelectedMenuVC.h"
#import "CommonClass.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, OrderDelegate>{
    NSArray *_titleArr;
    UITableView *_tableView;
    
    UIScrollView *_scrollView;
    
    UIImageView *carLogImage;
    UILabel *_badgeLabel;
    UILabel *label;
    UIButton *commitBtn;
}
@property (nonatomic, strong) NSMutableArray *itemArr;

@property (nonatomic, strong) NSMutableArray *orderArr;

@property (nonatomic, assign) NSInteger totalCost;
@property (nonatomic, assign) NSInteger totalCounts;
@end

@implementation ViewController

- (void)initItemData{
    _itemArr = [CommonClass returnItemData];
    _titleArr = @[@"类型一", @"类型二", @"类型三", @"类型四"];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _totalCounts = 0;
    _totalCost = 0;
    [self initItemData];
    [self initTableView];
    [self initScrollView];
    [self initButtomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCount) name:@"changeItemCount" object:nil];
}

#pragma mark -------------change item count notification
- (void)changeCount{
    
    [self reloadTableView];
 
    NSInteger count = 0;
    NSInteger price = 0;
    for (ItemModel *model in _orderArr) {
        count = count + model.selectedCount;
        price = price + model.selectedCount*model.itemPrice;
    }

    _totalCounts = count;
    _totalCost = price;
    
    label.text = [NSString stringWithFormat:@"¥%ld", (long)_totalCost];
    [self showSelectedItemCount];
    
    if (_totalCounts == 0) {
        CGRect frame = commitBtn.frame;
        frame.origin.x = self.view.frame.size.width;
        [UIView animateWithDuration:0.4 animations:^{
            commitBtn.frame = frame;
        }];
    }

}

- (void)reloadTableView{
    int section = -1;
    for (NSArray *arr in  _itemArr) {
        section++;
        
        int index = -1;
        for (ItemModel *tempModel in arr) {
            index++;
            
            BOOL flag = YES;
            for (ItemModel *model in _orderArr) {
                if ([model.itemID isEqualToString:tempModel.itemID]) {
                    tempModel.selectedCount = model.selectedCount;
                    flag = NO;
                }
            }
            
            if (flag) {
                tempModel.selectedCount = 0;
            }
            
            OrderCell *cell = (OrderCell*)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
            [cell reloadSelectedItemCount];
        }
    }

}

- (void)initButtomView{
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 45)];
    buttomView.backgroundColor = [UIColor colorWithRed:46/255.0 green:46/255.0 blue:46/255.0 alpha:0.8];
    [self.view addSubview:buttomView];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.view.frame.size.width-80-35, 45)];
    label.textColor = [UIColor whiteColor];
    label.font  =[UIFont systemFontOfSize:16];
    label.text  =@"¥0";
    [buttomView addSubview:label];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-80, 0, 75, 45)];
    tipLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    tipLabel.font  =[UIFont systemFontOfSize:14];
    tipLabel.text  =@"¥15起送";
    tipLabel.textAlignment  =NSTextAlignmentRight;
    [buttomView addSubview:tipLabel];
    
    carLogImage = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 7.5, 30, 30)];
    carLogImage.image = [UIImage imageNamed:@"gouwuche"];
    carLogImage.userInteractionEnabled = YES;
    [carLogImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSelectedMenuList)]];
    [buttomView addSubview:carLogImage];
    
    _badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -5, 15, 15)];
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.backgroundColor = [UIColor redColor];
    _badgeLabel.font  =[UIFont boldSystemFontOfSize:10];
    _badgeLabel.textAlignment  =NSTextAlignmentCenter;
    _badgeLabel.layer.cornerRadius = 15/2;
    _badgeLabel.layer.masksToBounds = YES;
    _badgeLabel.hidden = YES;
    [carLogImage addSubview:_badgeLabel];
    
    commitBtn  = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, 80, 45)];
    commitBtn.backgroundColor = [UIColor colorWithRed:73/255.0 green:202/255.0 blue:99/255.0 alpha:1.0];
    [commitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [buttomView addSubview:commitBtn];
}


#pragma mark -----------UITableView
- (void)initScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 80, self.view.frame.size.height-45)];
    _scrollView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    [self initMainMenuList];

}

- (void)initMainMenuList{
    for (int i = 0; i<_titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, i*40, 80, 40)];
        [btn setTitleColor:[UIColor colorWithWhite:0.2 alpha:1.0] forState:UIControlStateNormal];
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(touchMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
    }
    
    [self setHighlightAtindex:0];
}

- (void)touchMenuButton:(UIButton*)btn{
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:btn.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)setHighlightAtindex:(NSInteger)index{
    [_scrollView.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
        UIButton *btn = (UIButton*)obj;
        if (btn.tag == index) {
            btn.backgroundColor = _tableView.backgroundColor;
        }else{
            btn.backgroundColor = _scrollView.backgroundColor;
        }
    }];
}

#pragma mark -----------UITableView
- (void)initTableView{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(80, 0, self.view.frame.size.width-80, self.view.frame.size.height-45)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark -----------UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _itemArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = _itemArr[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    

    return _titleArr[section];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *identifier = [NSString stringWithFormat:@"cell_%ld_%ld", (long)indexPath.section , (long)indexPath.row];
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSArray *arr = _itemArr[indexPath.section];
    cell.itemModel = [arr objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat section1_y = [_tableView rectForSection:1].origin.y;
  
    CGFloat section2_y = [_tableView rectForSection:2].origin.y;

    CGFloat section3_y = [_tableView rectForSection:3].origin.y;
    
    CGFloat y = _tableView.contentOffset.y;
    NSInteger section;
    if (y < section1_y) {
        section = 0;
    }else if (y < section2_y){
        section = 1;
    }else if (y < section3_y){
        section = 2;
    }else{
        section = 3;
    }
    
    if (_tableView.contentOffset.y+_tableView.bounds.size.height >= _tableView.contentSize.height) {
        section = _titleArr.count-1;
    }
    
    [self setHighlightAtindex:section];
}

#pragma mark
#pragma mark -----------OrderDelegate
- (void)didSelectItemModel:(ItemModel *)model atPoint:(CGPoint)point isAdd:(BOOL)flag{
    
    if (!_orderArr) {
        _orderArr = [NSMutableArray array];
    }
    
    NSInteger price;
    if (flag) {
        _totalCounts = _totalCounts + 1;
        price = model.itemPrice;
        
        [self addItemModel:model];
        
        CGPoint startPoint = [_tableView convertPoint:point toView:self.view];
        CGPoint endPoint = [carLogImage convertPoint:carLogImage.center toView:self.view];
        [self animationFromPoint:startPoint toPoint:endPoint];
    }else{
        _totalCounts = _totalCounts - 1;
        price = -model.itemPrice;
        
         [self subItemModel:model];
    }
    
    if (_totalCost == 0) {
        CGRect frame = commitBtn.frame;
        frame.origin.x = self.view.frame.size.width-80;
        [UIView animateWithDuration:0.4 animations:^{
            commitBtn.frame = frame;
        }];
    }
    
    if (_totalCost + price == 0) {
        CGRect frame = commitBtn.frame;
        frame.origin.x = self.view.frame.size.width;
        [UIView animateWithDuration:0.4 animations:^{
            commitBtn.frame = frame;
        }];
    }
    _totalCost = _totalCost + price;
    
    
    label.text = [NSString stringWithFormat:@"¥%ld", (long)_totalCost];
    [self showSelectedItemCount];
}

- (void)addItemModel:(ItemModel*)model{
    if (model.selectedCount == 1) {
        [_orderArr addObject:model];
    }else{
        for(int i = 0; i < _orderArr.count ; i++){
            ItemModel *tempModel = _orderArr[i];
            if ([tempModel.itemID isEqualToString:model.itemID]) {
                [_orderArr replaceObjectAtIndex:i withObject:model];
                break;
            }
        }
    }
}

- (void)subItemModel:(ItemModel*)model{
    
    if (model.selectedCount == 0) {
        
        [_orderArr removeObject:model];
    }else{
        
        for(int i = 0; i < _orderArr.count ; i++){
    
            ItemModel *tempModel = _orderArr[i];
            if ([tempModel.itemID isEqualToString:model.itemID]) {
                [_orderArr replaceObjectAtIndex:i withObject:model];
                break;
            }
        }
        
    }

}

- (void)showSelectedItemCount{
    if (_totalCounts>0) {
        _badgeLabel.hidden = NO;
    }else{
        _badgeLabel.hidden = YES;
    }
    _badgeLabel.text = [NSString stringWithFormat:@"%ld", (long)_totalCounts];
}

#pragma mark -----------show selected menu
- (void)showSelectedMenuList{
    if (self.childViewControllers.count == 0) {
        if (_orderArr && _orderArr.count>0) {
            SelectedMenuVC *popView = [[SelectedMenuVC alloc] init];
            popView.menuArr = _orderArr;
            [popView show];
        }
    }
}


#pragma mark -------shopping animation
- (void)animationFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint{
    
    CALayer *layer = [[CALayer alloc]init];
    layer.cornerRadius = 10;
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.frame = CGRectMake(-100, -100, 20, 20);
    layer.opacity = 1;
    [self.view.layer addSublayer:layer];
    
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);//移动到起始点
    CGPathAddQuadCurveToPoint(path, NULL, 100, 100, endPoint.x, endPoint.y);
    keyframeAnimation.path = path;
    
    keyframeAnimation.delegate = self;
    keyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    CGPathRelease(path);
    keyframeAnimation.duration = 0.5;
    [layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];

}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeItemCount" object:nil];
}

@end
