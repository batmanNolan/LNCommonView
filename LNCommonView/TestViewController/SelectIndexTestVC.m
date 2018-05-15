//
//  SelectIndexVC.m
//  LNCommonView
//
//  Created by nolan on 2018/5/13.
//  Copyright © 2018年 nolan. All rights reserved.
//

#import "SelectIndexTestVC.h"
#import "LNSelectTableView.h"
#import "LNSelectIndexModel.h"
#import "Masonry.h"
@interface SelectIndexTestVC ()<LNLoanSelectDelegate>
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)LNSelectTableView *selectTableView;
@end

@implementation SelectIndexTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView{
    [self.selectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    }];
}


- (void)initData{
    NSArray *locationArray = @[@{@"key":@"B", @"name":@"北京", @"id":@"1"},
                        @{@"key":@"C", @"name":@"成都", @"id":@"2"},
                        @{@"key":@"C", @"name":@"重庆", @"id":@"3"},
                        @{@"key":@"G", @"name":@"广东", @"id":@"4"},
                        @{@"key":@"G", @"name":@"广西", @"id":@"5"},
                        @{@"key":@"G", @"name":@"贵州", @"id":@"6"},
                        @{@"key":@"H", @"name":@"海南", @"id":@"7"},
                        @{@"key":@"H", @"name":@"河北", @"id":@"8"},
                        @{@"key":@"H", @"name":@"湖北", @"id":@"9"},
                        @{@"key":@"H", @"name":@"湖南", @"id":@"10"},
                        @{@"key":@"J", @"name":@"降息", @"id":@"11"},
                        @{@"key":@"J", @"name":@"江苏", @"id":@"12"},
                        @{@"key":@"S", @"name":@"陕西", @"id":@"13"},
                        @{@"key":@"S", @"name":@"山东", @"id":@"14"},
                        @{@"key":@"S", @"name":@"上海", @"id":@"15"},
                        @{@"key":@"Z", @"name":@"浙江", @"id":@"16"}];
    NSMutableArray *selectArray = [[NSMutableArray alloc]init];
    for (int i =0; i<locationArray.count; i++) {
        NSDictionary *dic = [locationArray objectAtIndex:i];
        LNSelectIndexModel *model = [LNSelectIndexModel setIndexModel:dic[@"name"] sortKey:dic[@"key"] key:dic[@"id"]];
        [selectArray addObject:model];
    }
    self.dataSource =[LNSelectIndexModel characterSum:selectArray];
    NSMutableArray *indexArray = [LNSelectIndexModel indexSum:self.dataSource];
    [self.selectTableView reloadSelectTableView:self.dataSource indexArray:indexArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LNSelectTableView *)selectTableView{
    if (!_selectTableView) {
        _selectTableView = [[LNSelectTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain accessoryType:UITableViewCellAccessoryDisclosureIndicator];
        _selectTableView.loanSelectDelegate = self;
        [self.view addSubview:_selectTableView];
    }
    return _selectTableView;
}

- (void)loanSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *indexArray = [self.dataSource objectAtIndex:indexPath.section];
    LNSelectIndexModel *instModel = [indexArray objectAtIndex:indexPath.row];
}

@end
