//
//  OrderCell.m
//  AnimationTest
//
//  Created by qianzhan on 16/1/18.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import "OrderCell.h"

@interface OrderCell (){
    
    UIImageView *_itemImage;
    UILabel *_itemNameLabel;
    UILabel *_priceLabel;
    
    UIButton *_addBtn;
    UIButton *_subBtn;
    UILabel *_countlabel;
    
    UIView  *_line;

}
@end

@implementation OrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    
    return self;
}

- (void)initSubView{

    CGFloat width = [UIScreen mainScreen].bounds.size.width-80;
    
    _itemImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [self addSubview:_itemImage];
    
    _itemNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, width-80, 20)];
    _itemNameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_itemNameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, width-80-130, 20)];
    [self addSubview:_priceLabel];
    
    //item count mananger
    _countlabel = [[UILabel alloc] initWithFrame:CGRectMake(width-35, 50, 0, 20)];
    _countlabel.textAlignment = NSTextAlignmentCenter;
    _countlabel.text = @"0份";
    _countlabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_countlabel];
    
    _subBtn  = [[UIButton alloc] initWithFrame:CGRectMake(width-30, 50, 20, 20)];
    [_subBtn setBackgroundImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
    [_subBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
    _subBtn.tag = 0;
    [self addSubview:_subBtn];
    
    _addBtn  = [[UIButton alloc] initWithFrame:CGRectMake(width-30, 50, 20, 20)];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.tag = 1;
    [self addSubview:_addBtn];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 80-0.5, [UIScreen mainScreen].bounds.size.width, 1)];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line];
}

- (void)setItemModel:(ItemModel *)itemModel{
    
    _itemModel = itemModel;
    
    _itemImage.image = [UIImage imageNamed:itemModel.itemImg];
    _itemNameLabel.text = itemModel.itemName;
    
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%ld", (long)itemModel.itemPrice]];
    [mutableStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, mutableStr.length)];
    [mutableStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(1, mutableStr.length-1)];
    [mutableStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    _priceLabel.attributedText = mutableStr;
    
}

//add or sub item count
- (void)changeCount:(UIButton*)btn{
    
    NSInteger price;
    
    if (btn.tag == 1) {
        _itemModel.selectedCount++;
        price  = _itemModel.itemPrice;
        
        if (_itemModel.selectedCount == 1) {
            [self unfoldAnimation];
        }
    }else{
        _itemModel.selectedCount--;
        price  = -_itemModel.itemPrice;
        
        if (_itemModel.selectedCount == 0) {
            [self foldAniamtion];
        }
    }
    
    [self postPrice:price];
    _countlabel.text = [NSString stringWithFormat:@"%ld份", (long)_itemModel.selectedCount];

}

- (void)reloadSelectedItemCount{

    NSInteger newCount = _itemModel.selectedCount;
    
    if (newCount == 0) {
        [self foldAniamtion];
    }
    _countlabel.text = [NSString stringWithFormat:@"%ld份", (long)_itemModel.selectedCount];
}

- (void)unfoldAnimation{
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect frame = _countlabel.frame;
    
    transform = CGAffineTransformTranslate(transform, -100, 0);
    transform = CGAffineTransformRotate(transform, -M_PI_2);
    [UIView animateWithDuration:0.5 animations:^{
        _subBtn.transform = transform;
        
    }];
    
    frame.size.width = 60;
    frame.origin.x = frame.origin.x - frame.size.width;
    [UIView animateWithDuration:0.5 animations:^{
        _countlabel.frame = frame;
    }];
    
}

- (void)foldAniamtion{
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect frame = _countlabel.frame;
    
    frame.origin.x = frame.origin.x + frame.size.width;
    frame.size.width = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _countlabel.frame = frame;
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        _subBtn.transform = transform;
    }];
    
}

- (void)postPrice:(NSInteger)price{
    if ([self.delegate respondsToSelector:@selector(didSelectItemModel:atPoint:isAdd:)]) {
        
        CGPoint point = [self convertPoint:_addBtn.center toView:self.superview];
        
        if (price>=0) {
            [self.delegate didSelectItemModel:_itemModel atPoint:point isAdd:YES];
        }else{
            [self.delegate didSelectItemModel:_itemModel atPoint:point isAdd:NO];
        }
        
    }
}

@end
