//
//  LNMultiSelectTableView.h
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNMultiSelectTableViewCell.h"

@protocol LNMultiSelectTBDelegate<NSObject>
- (void)tableView:(UITableView *)tableView multiSelectRowAtIndexPath:(NSIndexPath *)indexPath treeModel:(LNTreeModel *)treeModel;
@end
@interface LNMultiSelectTableView : UITableView
-(instancetype)initWithFrame:(CGRect)frame selectCellTyp:(SelectedCellType) cellType;
@property(nonatomic,weak) id<LNMultiSelectTBDelegate> multiSelectDelegate;
-(void)reloadSelectTableView:(NSMutableArray *)dataArray;
-(void)resetIndex;
-(void)selectedRow:(int)row;
@end
