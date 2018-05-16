//
//  MultiSelectTestVC.m
//  LNCommonView
//
//  Created by nolan on 2018/5/13.
//  Copyright © 2018年 nolan. All rights reserved.
//

#import "MultiSelectTestVC.h"
#import "LNMultiButtonView.h"
#import "LNMultiSelectView.h"
#import "LNTreeModel.h"
@interface MultiSelectTestVC ()<LNMultiSelectDelegate,LNMultiButtonViewDelegate>
@property(nonatomic,strong)LNMultiButtonView  *selectBtn;
@property(nonatomic,strong)LNMultiSelectView  *selectView0;
@property(nonatomic,strong)LNMultiSelectView  *selectView1;
@property(nonatomic,strong)NSMutableArray     *treeModelArray;
@property(nonatomic,strong)LNTreeModel        *selectTreeModel0;
@property(nonatomic,strong)LNTreeModel        *selectTreeModel1;
@property(nonatomic,strong)NSArray            *dataSource;
@end
@implementation MultiSelectTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多选";
    [self initView];
    [self initData];
}


- (void)initView{
    self.selectBtn = [[LNMultiButtonView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) buttonHeight:40 buttonTitle:@"测试1",@"测试2", nil];
    self.selectView0 = [[LNMultiSelectView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT*1/2) buttonCount:3];
    self.selectView1 =  [[LNMultiSelectView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT*1/2) buttonCount:3];
    [self.selectView0 hideAndSaveSelectView:NO animated:NO];
    [self.selectView1 hideAndSaveSelectView:NO animated:NO];
    [self.view addSubview:self.selectView0];
    [self.view addSubview:self.selectView1];
    [self.view addSubview:self.selectBtn];
    self.selectView0.multiSelectDelegate = self;
    self.selectBtn.multiButtonViewDelegate = self;
    self.selectView1.multiSelectDelegate = self;
}

- (void)initData{
    self.treeModelArray = [[NSMutableArray alloc] init];
    self.dataSource = @[@{@"parentID":@"", @"name":@"Node1", @"ID":@"1"},
                    @{@"parentID":@"1", @"name":@"Node10", @"ID":@"10"},
                    @{@"parentID":@"1", @"name":@"Node11", @"ID":@"11"},
                    @{@"parentID":@"10", @"name":@"Node100", @"ID":@"100"},
                    @{@"parentID":@"10", @"name":@"Node101", @"ID":@"101"},
                    @{@"parentID":@"11", @"name":@"Node110", @"ID":@"110"},
                    @{@"parentID":@"11", @"name":@"Node111", @"ID":@"111"},
                    @{@"parentID":@"111", @"name":@"Node1110", @"ID":@"1110"},
                    @{@"parentID":@"111", @"name":@"Node1111", @"ID":@"1111"},
                    @{@"parentID":@"", @"name":@"Node2", @"ID":@"2"},
                    @{@"parentID":@"2", @"name":@"Node20", @"ID":@"20"},
                    @{@"parentID":@"20", @"name":@"Node200", @"ID":@"200"},
                    @{@"parentID":@"20", @"name":@"Node101", @"ID":@"201"},
                    @{@"parentID":@"20", @"name":@"Node202", @"ID":@"202"},
                    @{@"parentID":@"2", @"name":@"Node21", @"ID":@"21"},
                    @{@"parentID":@"21", @"name":@"Node210", @"ID":@"210"},
                    @{@"parentID":@"21", @"name":@"Node211", @"ID":@"211"},
                    @{@"parentID":@"21", @"name":@"Node212", @"ID":@"212"},
                    @{@"parentID":@"211", @"name":@"Node2110", @"ID":@"2110"},
                    @{@"parentID":@"211", @"name":@"Node2111", @"ID":@"2111"},];
    for (NSDictionary *dic in self.dataSource) {
        LNTreeModel *node  = [LNTreeModel nodeWithParentKey:dic[@"parentID"]
                                                          key:dic[@"ID"]
                                                        value:dic[@"name"]];
        [self.treeModelArray addObject:node];
    }
}

#pragma LNMultiSelectDelegate
-(void)multiSelectView:(LNMultiSelectView *)mutiSelectView
        tableViewIndex:(int)tableIndex
             indexPath:(NSIndexPath *)indexPath
             treeModel:(LNTreeModel *)treeModel{
    if (mutiSelectView == self.selectView0) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        tempArray = [LNTreeModel treeArray:self.treeModelArray key:treeModel.key];
        if (tableIndex == 2) {
            [self.selectBtn pickUpButton:0];
            self.selectTreeModel1 = treeModel;
            [self.selectBtn buttonTitle:treeModel.value btnTag:0];
        }
        [self.selectView0 reloadMultiTableView:tempArray tableIndex:tableIndex+1];
        
    }else if(mutiSelectView == self.selectView1){
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        tempArray = [LNTreeModel treeArray:self.treeModelArray key:treeModel.key];
        if (tableIndex == 2) {
            [self.selectBtn pickUpButton:1];
            self.selectTreeModel1 = treeModel;
            [self.selectBtn buttonTitle:treeModel.value btnTag:1];
        }
        [self.selectView1 reloadMultiTableView:tempArray tableIndex:tableIndex+1];
    }
}


#pragma LNMultiButtonViewDelegate

-(void)buttonTap:(int)btnTag selected:(BOOL)isSelect{
    if (btnTag == 0) {
        if (isSelect) {
            [self.selectView0 showMultiSelectView:YES];
            [self.selectView1 hideAndSaveSelectView:NO animated:NO];
            NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in self.dataSource) {
                if ([[dic objectForKey:@"ID"] isEqualToString:@"2"]) {
                    LNTreeModel *node  = [LNTreeModel nodeWithParentKey:dic[@"parentID"]
                                                                    key:dic[@"ID"]
                                                                  value:dic[@"name"]];
                    [tempArray1 addObject:node];
                }
            }
            [self.selectView0 reloadMultiTableView:tempArray1 tableIndex:0];
        }else{
            [self.selectView0 hideAndSaveSelectView:NO animated:YES];
            [self.selectView1 hideAndSaveSelectView:NO animated:YES];
        }
    }else if(btnTag == 1){
        if (isSelect) {
            [self.selectView1 showMultiSelectView:YES];
            [self.selectView0 hideAndSaveSelectView:NO animated:NO];
            NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in self.dataSource) {
                if ([[dic objectForKey:@"ID"] isEqualToString:@"1"]) {
                    LNTreeModel *node  = [LNTreeModel nodeWithParentKey:dic[@"parentID"]
                                                                      key:dic[@"ID"]
                                                                    value:dic[@"name"]];
                    [tempArray1 addObject:node];
                }
            }
            [self.selectView1 reloadMultiTableView:tempArray1 tableIndex:0];
        }else{
            [self.selectView0 hideAndSaveSelectView:NO animated:YES];
            [self.selectView1 hideAndSaveSelectView:NO animated:YES];
        }
        
    }
}

-(void)tapbackGround{
    [self.selectView0 hideAndSaveSelectView:NO animated:YES];
    [self.selectView1 hideAndSaveSelectView:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
