//
//  LNMultiSelectView.m
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import "LNMultiSelectView.h"
#import "LNMultiSelectTableView.h"
#import "Masonry.h"
#define buttonTag       10
#define tableviewTag    100
@interface LNMultiSelectView()<LNMultiSelectTBDelegate>
@property(nonatomic,strong)NSMutableArray       *tableViewArray;
@property(nonatomic,assign)int                  buttonCount;
@property(nonatomic,strong)NSMutableDictionary  *dataDic;
@property(nonatomic,strong)NSMutableArray   *tempTableviewsDataArray;
@property(nonatomic,strong)NSMutableArray   *tableviewsDataArray;
@property(nonatomic,strong)NSMutableArray   *tempSelectedRowArray;
@property(nonatomic,strong)NSMutableArray   *selectedRowArray;
@property(nonatomic,assign)BOOL             haveBeenSelect;
@property(nonatomic,assign)CGRect           oriFrame;
@end

@implementation LNMultiSelectView
-(instancetype)initWithFrame:(CGRect)frame buttonCount:(int)buttonCount{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonCount = buttonCount;
        self.tableViewArray  = [[NSMutableArray alloc]init];
        self.dataDic = [[NSMutableDictionary alloc]init];
        self.oriFrame = frame;
        self.tempTableviewsDataArray = [[NSMutableArray alloc]init];
        self.tableviewsDataArray = [[NSMutableArray alloc]init];
        self.tempSelectedRowArray = [[NSMutableArray alloc]init];
        self.selectedRowArray = [[NSMutableArray alloc]init];
        self.haveBeenSelect = NO;
    }
    return self;
}
-(void)layoutSubviews{
    [self initView];
}
-(void)initView{
    for (int i = 0; i < self.buttonCount; i++) {
        if (self.buttonCount > 1 && i == 0) {
            LNMultiSelectTableView * multiSelectTableView = [[LNMultiSelectTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/self.buttonCount*i, 0, SCREEN_WIDTH/self.buttonCount, self.oriFrame.size.height) selectCellTyp:Seperate_Type];
            multiSelectTableView.tag = i;
            multiSelectTableView.multiSelectDelegate = self;
            [self.tableViewArray addObject:multiSelectTableView];
            [self addSubview:multiSelectTableView];
        }else{
            LNMultiSelectTableView * multiSelectTableView = [[LNMultiSelectTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/self.buttonCount*i, 0, SCREEN_WIDTH/self.buttonCount, self.oriFrame.size
                                                                                                                       .height) selectCellTyp:Line_Type];
            multiSelectTableView.tag = i;
            multiSelectTableView.multiSelectDelegate = self;
            [self.tableViewArray addObject:multiSelectTableView];
            [self addSubview:multiSelectTableView];
        }

    }
}

- (void)reloadMultiTableView:(NSMutableArray *)dataArray tableIndex:(int)index{
    if (index >= self.buttonCount) {
        [self hideAndSaveSelectView:YES];
    }else{
        if (!self.haveBeenSelect || index != 0) {
            LNMultiSelectTableView *tableView = [self.tableViewArray objectAtIndex:index];
            [tableView resetIndex];
            [tableView reloadSelectTableView:dataArray];
            [self.tempTableviewsDataArray insertObject:dataArray atIndex:index];
            for (int i = index +1 ; i < self.tableViewArray.count; i++) {
                LNMultiSelectTableView *tempTableView = [self.tableViewArray objectAtIndex:i];
                [tempTableView resetIndex];
                [tempTableView reloadSelectTableView:nil];
            }
        }
    }
}

-(void)hideAndSaveSelectView:(BOOL)savaView{
    if (savaView) {
        self.haveBeenSelect = YES;
        self.selectedRowArray = [self.tempSelectedRowArray copy];
        self.tableviewsDataArray = [self.tempTableviewsDataArray copy];
    }
    self.hidden = YES;
}
-(void)showMultiSelectView{
    if (self.haveBeenSelect) {
        for (int i = 0 ; i < self.tableviewsDataArray.count; i++) {
            LNMultiSelectTableView *tableView = [self.tableViewArray objectAtIndex:i];
            [tableView reloadSelectTableView: [self.tableviewsDataArray objectAtIndex:i]];
            NSIndexPath *index = [self.selectedRowArray objectAtIndex:i];
            [tableView selectedRow:index.row];
        }
        for (int i = self.tableviewsDataArray.count; i <self.tableViewArray.count; i++) {
            LNMultiSelectTableView *tableView = [self.tableViewArray objectAtIndex:i];
            [tableView resetIndex];
            [tableView reloadSelectTableView:nil];
        }
    }
    self.hidden = NO;
}
- (void)tableView:(UITableView *)tableView multiSelectRowAtIndexPath:(NSIndexPath *)indexPath treeModel:(LNTreeModel *)treeModel{
    if (self.multiSelectDelegate && [self.multiSelectDelegate respondsToSelector:@selector(multiSelectView:tableViewIndex:indexPath:treeModel:)]) {
        int i = tableView.tag;
        if (i == nil) {
            i = 0;
        }
        for (int tabIndex = self.tableViewArray.count -1 ; tabIndex > i;tabIndex -- ) {
            if (self.tempSelectedRowArray.count >tabIndex) {
                [self.tempSelectedRowArray removeObjectAtIndex:tabIndex];
            }
            if (self.tempTableviewsDataArray.count >tabIndex) {
                [self.tempTableviewsDataArray removeObjectAtIndex:tabIndex];
            }
        }
        [self.tempSelectedRowArray insertObject:indexPath atIndex:i];
        [self.multiSelectDelegate multiSelectView:self tableViewIndex:i indexPath:indexPath treeModel:treeModel];
    }
}

@end
