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
{
    BOOL _vcBeenLayout;
}
@property(nonatomic,strong)NSMutableArray       *tableViewArray;
@property(nonatomic,assign)int                  buttonCount;
@property(nonatomic,strong)NSMutableDictionary  *dataDic;
@property(nonatomic,strong)NSMutableArray   *tempTableviewsDataArray;
@property(nonatomic,strong)NSMutableArray   *tableviewsDataArray;
@property(nonatomic,strong)NSMutableArray   *tempSelectedRowArray;
@property(nonatomic,strong)NSMutableArray   *selectedRowArray;
@property(nonatomic,assign)BOOL             haveBeenSelect;
@property(nonatomic,assign)int              tableViewheight;
@end

@implementation LNMultiSelectView
-(instancetype)initWithFrame:(CGRect)frame buttonCount:(int)buttonCount{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, SCREEN_HEIGHT)];
    self.tableViewheight = frame.size.height;
    if (self) {
        self.buttonCount = buttonCount;
        self.tableViewArray  = [[NSMutableArray alloc]init];
        self.dataDic = [[NSMutableDictionary alloc]init];
        self.tempTableviewsDataArray = [[NSMutableArray alloc]init];
        self.tableviewsDataArray = [[NSMutableArray alloc]init];
        self.tempSelectedRowArray = [[NSMutableArray alloc]init];
        self.selectedRowArray = [[NSMutableArray alloc]init];
        self.haveBeenSelect = NO;
        _vcBeenLayout = NO;
    }
    return self;
}
-(void)layoutSubviews{
    if (_vcBeenLayout == NO) {
        _vcBeenLayout = YES;
        [self initView];
    }
}
-(void)initView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.width, self.height)];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickupView)];
    [backView addGestureRecognizer:tapGesturRecognizer];
    [backView setBackgroundColor: [UIColor clearColor]];
    [self addSubview:backView];
    
    for (int i = 0; i < self.buttonCount; i++) {
        if (self.buttonCount > 1 && i == 0) {
            LNMultiSelectTableView * multiSelectTableView = [[LNMultiSelectTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/self.buttonCount*i, 0, SCREEN_WIDTH/self.buttonCount, self.tableViewheight) selectCellTyp:Seperate_Type];
            multiSelectTableView.tag = i;
            multiSelectTableView.multiSelectDelegate = self;
            [self.tableViewArray addObject:multiSelectTableView];
            [self addSubview:multiSelectTableView];
        }else{
            LNMultiSelectTableView * multiSelectTableView = [[LNMultiSelectTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/self.buttonCount*i, 0, SCREEN_WIDTH/self.buttonCount, self.tableViewheight) selectCellTyp:Line_Type];
            multiSelectTableView.tag = i;
            multiSelectTableView.multiSelectDelegate = self;
            [self.tableViewArray addObject:multiSelectTableView];
            [self addSubview:multiSelectTableView];
        }
    }
    NSLog(@"数目:%d",[self.tableViewArray count]);
}

- (void)reloadMultiTableView:(NSMutableArray *)dataArray tableIndex:(int)index{
    if (index >= self.buttonCount) {
        [self hideAndSaveSelectView:YES animated:YES];
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

-(void)hideAndSaveSelectView:(BOOL)savaView animated:(BOOL)animated{
    if (savaView) {
        self.haveBeenSelect = YES;
        self.selectedRowArray = [self.tempSelectedRowArray copy];
        self.tableviewsDataArray = [self.tempTableviewsDataArray copy];
    }
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT/2);
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }else{
        self.hidden = YES;
    }
}
-(void)showMultiSelectView:(BOOL)animated{
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
    if (animated) {
        self.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT/2);
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
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

-(void)pickupView{
    if (self.multiSelectDelegate &&[self.multiSelectDelegate respondsToSelector:@selector(tapBackView)]) {
        [self.multiSelectDelegate tapBackView];
    }
}

@end
