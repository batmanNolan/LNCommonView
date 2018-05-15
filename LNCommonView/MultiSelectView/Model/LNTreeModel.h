//
//  LNTreeModel.h
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import <Foundation/Foundation.h>

//多级选择为多叉树结构
@interface LNTreeModel : NSObject

@property (nonatomic, strong)     NSString *parentKey;       //父节点
@property (nonatomic, strong)     NSString *parentValue;
@property (nonatomic, strong)     NSString *key;             //本节点
@property (nonatomic, strong)     NSString *value;          //展示值
@property (nonatomic, strong)     NSMutableArray *childArray;


+ (instancetype)nodeWithParentKey:(NSString *)parentKey key:(NSString *)key value:(NSString *)value;
+ (instancetype)nodeWithParentKey:(NSString *)parentKey key:(NSString *)key value:(NSString *)value childArray:(NSMutableArray *)childArray;
+ (NSMutableArray *)treeArray:(NSMutableArray *)treeModelArray parentKey:(NSString *)parentKey;
+ (NSMutableArray *)treeArray:(NSMutableArray *)treeModelArray key:(NSString *)key;

@end
