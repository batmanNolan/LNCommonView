//
//  LNSelectIndexModel.m
//  LNCommonView
//
//  Created by nolan on 2018/4/17.
//  Copyright © 2018年 LN. All rights reserved.
//

#import "LNSelectIndexModel.h"

@implementation LNSelectIndexModel
+(LNSelectIndexModel *)setIndexModel:(NSString *)text sortKey:(NSString *)sortKey key:(NSString *)key{
    LNSelectIndexModel *selectIndexModel = [[LNSelectIndexModel alloc] init];
    selectIndexModel.text = text;
    selectIndexModel.sortKey = sortKey;
    selectIndexModel.key = key;
    return selectIndexModel;
}


+(NSMutableArray *)characterSum:(NSMutableArray *)branchList{
    NSMutableArray *characterSumArray = [NSMutableArray new];
    for (int i = 0; i<branchList.count;) {
        NSMutableArray *tempArray = [NSMutableArray new];
        LNSelectIndexModel *model = [branchList objectAtIndex:i];
        [tempArray addObject:model];
        int j = i + 1;
        int len = 1;
        while (j <branchList.count&&[[branchList[j] sortKey] compare:model.sortKey] == NSOrderedSame) {
            [tempArray addObject:branchList[j]];
            j++;
            len++;
        }
        i+= len;
        [characterSumArray addObject:tempArray];
    }
    return characterSumArray;
}


+(NSMutableArray *)indexSum:(NSMutableArray *)characterSum{
    NSMutableArray *indexSumArray = [NSMutableArray new];
    for (NSMutableArray *array in characterSum) {
        LNSelectIndexModel *model = [array firstObject];
        if(!IsStrEmpty(model.sortKey)){
            [indexSumArray addObject:model.sortKey];
        }
    }
    return indexSumArray;
}
@end
