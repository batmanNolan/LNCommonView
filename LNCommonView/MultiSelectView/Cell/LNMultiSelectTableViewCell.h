//
//  LNMultiSelectTableViewCell.h
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNTreeModel.h"

typedef enum {
    Seperate_Type,  //选中后为白色
    Line_Type,      //选中后底部为绿色
} SelectedCellType;
static NSString * multicellId = @"mulit_cell_id";
@interface LNMultiSelectTableViewCell : UITableViewCell
@property(nonatomic,strong) LNTreeModel *treeModel;
@property(nonatomic,assign)BOOL    touched;
+(LNMultiSelectTableViewCell *)cellWithTableView:(UITableView *)tableView cellType:(SelectedCellType)cellType;
+(LNMultiSelectTableViewCell *)cellWithTableView:(UITableView *)tableView;
-(void)selectedCell:(BOOL)touched;
@end
