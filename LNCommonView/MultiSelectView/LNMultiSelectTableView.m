//
//  LNMultiSelectTableView.m
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import "LNMultiSelectTableView.h"
#import "LNTreeModel.h"

@interface LNMultiSelectTableView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)SelectedCellType cellType;
@property(nonatomic,strong)NSMutableArray   *dataArray;
@property(nonatomic,assign)NSIndexPath      *selectedIndexPath;
@end
@implementation LNMultiSelectTableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithFrame:frame selectCellTyp:Line_Type];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame selectCellTyp:(SelectedCellType) cellType{
    self = [super initWithFrame: frame];
    if (self) {
        self.cellType = cellType;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self initView];
    }
    return self;
}

-(void)initView{
    if (self.cellType == Line_Type) {
        [self setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
    }else if(self.cellType == Seperate_Type){
        [self setBackgroundColor:[UIColor colorWithRed:82.0f/255.0f green:190.0f/255.0f blue:166.0f/255.0f alpha:0.2]];
    }
}

-(void)reloadSelectTableView:(NSMutableArray *)dataArray{
    self.dataArray = dataArray;
    [self reloadSelectTableView];

}

-(void)reloadSelectTableView{
    if ([NSThread isMainThread]) {
        [self reloadData];
    } else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LNMultiSelectTableViewCell *cell = [LNMultiSelectTableViewCell cellWithTableView:tableView cellType:self.cellType];
    LNTreeModel *treeModel = [self.dataArray objectAtIndex:indexPath.row];
    if (self.selectedIndexPath != nil) {
        BOOL equal = ([self.selectedIndexPath compare:indexPath] == NSOrderedSame) ? YES : NO;
        if (equal) {
            [cell selectedCell:NO];
        }else{
            [cell selectedCell:YES];
        }
    }else{
        [cell selectedCell:YES];
    }
    cell.treeModel = treeModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36.f;
}

-(void)selectedRow:(int)row{
    self.selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self reloadSelectTableView];
}

-(void)resetIndex{
    self.selectedIndexPath = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.multiSelectDelegate && [self.multiSelectDelegate respondsToSelector:@selector(tableView:multiSelectRowAtIndexPath:treeModel:)]) {
        LNMultiSelectTableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
        self.selectedIndexPath = indexPath;
        [self reloadSelectTableView];
        [self.multiSelectDelegate tableView:tableView multiSelectRowAtIndexPath:indexPath treeModel:cell.treeModel];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
