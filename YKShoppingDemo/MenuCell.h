//
//  MenuCell.h
//  AnimationTest
//
//  Created by qianzhan on 16/1/19.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"

typedef void(^DeleteBlock)(ItemModel *model);


@interface MenuCell : UITableViewCell
@property (nonatomic, strong) ItemModel *itemModel;

@property (nonatomic , strong) DeleteBlock deleteBlock;
@end
