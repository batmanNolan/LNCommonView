//
//  LNTreeModel.m
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import "LNTreeModel.h"

@implementation LNTreeModel

+ (instancetype)nodeWithParentKey:(NSString *)parentKey key:(NSString *)key value:(NSString *)value{
    LNTreeModel *tree = [[LNTreeModel alloc] init];
    tree.parentKey  = parentKey;
    tree.key        = key;
    tree.value      = value;
    tree.parentValue = parentKey;
    return tree;
}

+ (instancetype)nodeWithParentKey:(NSString *)parentKey key:(NSString *)key value:(NSString *)value childArray:(NSMutableArray *)childArray{
    LNTreeModel *tree = [[LNTreeModel alloc] init];
    tree.parentKey  = parentKey;
    tree.key        = key;
    tree.value      = value;
    tree.childArray =childArray;
    return tree;
}

+(NSMutableArray *)treeArray:(NSMutableArray *)treeModelArray parentKey:(NSString *)parentKey{
    NSMutableArray *parentModelArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < treeModelArray.count;i++) {
        LNTreeModel *treeModel = [treeModelArray objectAtIndex:i];
        if ([treeModel.key isEqualToString:parentKey]) {
            [parentModelArray addObject:treeModel];
        }
    }
    return parentModelArray;
}

+(NSMutableArray *)treeArray:(NSMutableArray *)treeModelArray key:(NSString *)key{
    NSMutableArray *childModelArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < treeModelArray.count;i++) {
        LNTreeModel *treeModel = [treeModelArray objectAtIndex:i];
        if (!IsStrEmpty(treeModel.parentKey)) {
            if ([treeModel.parentKey isEqualToString:key]) {
                [childModelArray addObject:treeModel];
            }
        }
    }
    return childModelArray;
}

-(NSMutableArray *)childArray:(NSString *)key parentKey:(NSString *)parentKey value:(NSString *)value childArray:(NSString *)childArray{
    if (IsArrEmpty(self.childArray)) {
        return nil;
    }
    NSMutableArray *tempChildArray=[[NSMutableArray alloc]init];
    for (int i = 0; i< self.childArray.count; i++) {
        NSDictionary *dic = [self.childArray objectAtIndex:i];
        LNTreeModel *treeModel = [LNTreeModel nodeWithParentKey:parentKey
                                                              key:dic[key]
                                                            value:dic[value]
                                                       childArray:dic[childArray]];
        [tempChildArray addObject:treeModel];
    }
    return tempChildArray;
}

@end
