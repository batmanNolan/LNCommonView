//
//  LNSelectIndexModel.h
//  LNCommonView
//
//  Created by nolan on 2018/4/17.
//  Copyright © 2018年 LN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNSelectIndexModel : NSObject
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *sortKey;
@property(nonatomic,strong)NSString *key;
+(LNSelectIndexModel *)setIndexModel:(NSString *)text sortKey:(NSString *)sortKey key:(NSString *)key;
+(NSMutableArray *)characterSum:(NSMutableArray *)branchList;
+(NSMutableArray *)indexSum:(NSMutableArray *)characterSum;
@end
