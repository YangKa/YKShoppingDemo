//
//  CommonClass.m
//  AnimationTest
//
//  Created by qianzhan on 16/1/19.
//  Copyright © 2016年 YangKa. All rights reserved.
//

#import "CommonClass.h"

@implementation CommonClass
+ (NSMutableArray*)returnItemData{
    
    ItemModel *model0 = [[ItemModel alloc] init];
    model0.itemID = @"0000";
    model0.itemImg = @"item_0";
    model0.itemName = @"百事可乐";
    model0.itemPrice = 5;
    model0.selectedCount = 0;
    
    ItemModel *model1 = [[ItemModel alloc] init];
    model1.itemID = @"0001";
    model1.itemImg = @"item_1";
    model1.itemName = @"炒萝卜";
    model1.itemPrice = 15;
    model1.selectedCount = 0;
    
    ItemModel *model2 = [[ItemModel alloc] init];
    model2.itemID = @"0002";
    model2.itemImg = @"item_2";
    model2.itemName = @"土豆炖牛肉";
    model2.itemPrice = 20;
    model2.selectedCount = 0;
    
    ItemModel *model3 = [[ItemModel alloc] init];
    model3.itemID = @"0003";
    model3.itemImg = @"item_3";
    model3.itemName = @"咖喱饭";
    model3.itemPrice = 13;
    model3.selectedCount = 0;
    
    ItemModel *model4 = [[ItemModel alloc] init];
    model4.itemID = @"0004";
    model4.itemImg = @"item_4";
    model4.itemName = @"豆干木桶饭";
    model4.itemPrice = 15;
    model4.selectedCount = 0;

    NSArray *arr1 = @[model0, model1, model2, model3, model4];
    
    ItemModel *model5 = [[ItemModel alloc] init];
    model5.itemID = @"0005";
    model5.itemImg = @"item_5";
    model5.itemName = @"王老吉";
    model5.itemPrice = 4;
    model5.selectedCount = 0;
    
    ItemModel *model6 = [[ItemModel alloc] init];
    model6.itemID = @"0006";
    model6.itemImg = @"item_6";
    model6.itemName = @"油泼豆腐";
    model6.itemPrice = 22;
    model6.selectedCount = 0;
    
    ItemModel *model7 = [[ItemModel alloc] init];
    model7.itemID = @"0007";
    model7.itemImg = @"item_7";
    model7.itemName = @"清炒土豆丝";
    model7.itemPrice = 14;
    model7.selectedCount = 0;
    
    NSArray *arr2 = @[model5, model6, model7];
    
    ItemModel *model8 = [[ItemModel alloc] init];
    model8.itemID = @"0008";
    model8.itemImg = @"item_8";
    model8.itemName = @"青椒炒肉片";
    model8.itemPrice = 25;
    model8.selectedCount = 0;
    
    ItemModel *model9 = [[ItemModel alloc] init];
    model9.itemID = @"0009";
    model9.itemImg = @"item_9";
    model9.itemName = @"炒青菜";
    model9.itemPrice = 12;
    model9.selectedCount = 0;
    
    ItemModel *model10 = [[ItemModel alloc] init];
    model10.itemID = @"0010";
    model10.itemImg = @"item_10";
    model10.itemName = @"辣子鸡丁";
    model10.itemPrice = 20;
    model10.selectedCount = 0;
    
    ItemModel *model11 = [[ItemModel alloc] init];
    model11.itemID = @"0011";
    model11.itemImg = @"item_11";
    model11.itemName = @"莴苣炒肉";
    model11.itemPrice = 18;
    model11.selectedCount = 0;
    
    NSArray *arr3 = @[model8, model9, model10, model11];
    
    ItemModel *model12 = [[ItemModel alloc] init];
    model12.itemID = @"0012";
    model12.itemImg = @"item_12";
    model12.itemName = @"油焖茄子";
    model12.itemPrice = 18;
    model12.selectedCount = 0;
    
    ItemModel *model13 = [[ItemModel alloc] init];
    model13.itemID = @"0013";
    model13.itemImg = @"item_13";
    model13.itemName = @"炒海带丝";
    model13.itemPrice = 15;
    model13.selectedCount = 0;
    
    ItemModel *model14 = [[ItemModel alloc] init];
    model14.itemID = @"0014";
    model14.itemImg = @"item_0";
    model14.itemName = @"百事可乐";
    model14.itemPrice = 5;
    model14.selectedCount = 0;
    
    ItemModel *model15 = [[ItemModel alloc] init];
    model15.itemID = @"0015";
    model15.itemImg = @"item_1";
    model15.itemName = @"炒萝卜";
    model15.itemPrice = 15;
    model15.selectedCount = 0;
    
    NSArray *arr4 = @[model12, model13, model14, model15];
    
    NSMutableArray *itemArr  = [[NSMutableArray alloc] init];
    [itemArr addObject:arr1];
    [itemArr addObject:arr2];
    [itemArr addObject:arr3];
    [itemArr addObject:arr4];
    
    return itemArr;
}

@end
