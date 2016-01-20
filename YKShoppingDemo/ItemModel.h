//
//  ItemModel.h
//  AnimationTest
//
//  Created by qianzhan on 16/1/19.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, strong) NSString *itemID;

@property (nonatomic, strong) NSString *itemImg;

@property (nonatomic, strong) NSString *itemName;

@property (nonatomic, assign) NSInteger itemPrice;

@property (nonatomic, assign) NSInteger selectedCount;

@end
