//
//  LNMultiSelectView.h
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LNTreeModel.h"
@class LNMultiSelectView,LNMultiSelectDelegate;

@protocol LNMultiSelectDelegate<NSObject>
-(void)multiSelectView:(LNMultiSelectView *)mutiSelectView
        tableViewIndex:(int)tableIndex
             indexPath:(NSIndexPath *)indexPath
             treeModel:(LNTreeModel *)treeModel;

@optional
-(void)tableViewIndex:(int)tableIndex
            indexPath:(NSIndexPath *)indexPath
            treeModel:(LNTreeModel *)treeModel;

@end
//table的选择页面
@interface LNMultiSelectView : UIView
@property(nonatomic,weak)id <LNMultiSelectDelegate> multiSelectDelegate;
-(instancetype)initWithFrame:(CGRect)frame buttonCount:(int)buttonCount;
- (void)reloadMultiTableView:(NSMutableArray *)dataArray tableIndex:(int)index;
- (void)hideAndSaveSelectView:(BOOL)savaView animated:(BOOL)animated;
- (void)showMultiSelectView:(BOOL)animated;
@end
