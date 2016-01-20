//
//  MenuCell.m
//  AnimationTest
//
//  Created by qianzhan on 16/1/19.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import "MenuCell.h"

@interface MenuCell (){
    
    UIImageView *_itemImage;
    UILabel *_itemNameLabel;
    
    UILabel *_priceLabel;
    
    UIButton *_addBtn;
    UIButton *_subBtn;
    UILabel *_countlabel;
    
    UIView  *_line;
}

@end

@implementation MenuCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    
    return self;
}

- (void)initSubView{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _itemImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
    [self addSubview:_itemImage];
    
    _itemNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, width -180-45, 25)];
    _itemNameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_itemNameLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(width -180, 5, 50, 25)];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLabel];
    
    //item count mananger
    _subBtn  = [[UIButton alloc] initWithFrame:CGRectMake(width-110, 7.5, 20, 20)];
    [_subBtn setBackgroundImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
    [_subBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
    _subBtn.tag = 0;
    _subBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_2);
    [self addSubview:_subBtn];
    
    _countlabel = [[UILabel alloc] initWithFrame:CGRectMake(width-85, 7.5, 50, 20)];
    _countlabel.textAlignment = NSTextAlignmentCenter;
    _countlabel.text = @"0份";
    _countlabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_countlabel];
    
    _addBtn  = [[UIButton alloc] initWithFrame:CGRectMake(width-30, 7.5, 20, 20)];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(changeCount:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.tag = 1;
    [self addSubview:_addBtn];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 35-0.5, [UIScreen mainScreen].bounds.size.width, 1)];
    _line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_line];
}

- (void)setItemModel:(ItemModel *)itemModel{
    
    _itemModel = itemModel;
    
    _itemImage.image = [UIImage imageNamed:itemModel.itemImg];
    _itemNameLabel.text = itemModel.itemName;
    
    [self showPrice];
}

- (void)showPrice{
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%ld", (long)_itemModel.itemPrice*_itemModel.selectedCount]];
    [mutableStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, mutableStr.length)];
    [mutableStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(1, mutableStr.length-1)];
    [mutableStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 1)];
    _priceLabel.attributedText = mutableStr;
    
    _countlabel.text = [NSString stringWithFormat:@"%ld份", (long)_itemModel.selectedCount];
}

- (void)changeCount:(UIButton*)btn{
    if (btn.tag == 0) {
        if (_itemModel.selectedCount == 1) {
            _itemModel.selectedCount--;
            self.deleteBlock(_itemModel);
        }else{
            _itemModel.selectedCount--;
        }
    }else{
        _itemModel.selectedCount++;
    }
    
    [self showPrice];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeItemCount" object:nil userInfo:nil];
}

@end
