//
//  OrderCell.h
//  AnimationTest
//
//  Created by qianzhan on 16/1/18.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"

@protocol OrderDelegate <NSObject>

- (void)didSelectItemModel:(ItemModel*)model atPoint:(CGPoint)point isAdd:(BOOL)flag;

@end


@interface OrderCell : UITableViewCell

@property (nonatomic, strong) ItemModel *itemModel;

@property (nonatomic, strong) id<OrderDelegate> delegate;

- (void)reloadSelectedItemCount;

@end
