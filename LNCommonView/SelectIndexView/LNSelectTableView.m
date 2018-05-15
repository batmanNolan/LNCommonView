//
//  LNSelectTableView.m
//  LNCommonView
//
//  Created by nolan on 2018/3/7.
//  Copyright © 2018年 LN. All rights reserved.
//

#import "LNSelectTableView.h"
#import "LNSelectIndexModel.h"
#import "Masonry.h"
static NSString * instCellId = @"inst_cell_id";

@interface LNSelectTableView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *resourceData;
@property(nonatomic,strong)NSMutableArray *indexData;
@property(nonatomic,assign)UITableViewCellAccessoryType accessType;
@property(nonatomic,strong)NSMutableArray *defaultIndexArray;
@end

@implementation LNSelectTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style accessoryType:(UITableViewCellAccessoryType)accessType{
    self = [super initWithFrame:frame style:style];
    if (self){
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:instCellId];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = UIColorFromRGB(0xF5F5F5);
        self.sectionIndexColor = UIColorFromRGB(0x52BEA6);
        self.accessType = accessType;
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        self.resourceData = [NSMutableArray new];
        self.indexData = [NSMutableArray new];
        self.delegate = self;
        self.dataSource = self;
        self.defaultIndexArray = [[NSMutableArray alloc]init];
        for (NSInteger i='A'; i<='Z'; i++) {
            [self.defaultIndexArray addObject:[NSString stringWithFormat:@"%C",(unichar)i]];
        }
    }
    return self;
}

-(void)reloadSelectTableView:(NSMutableArray *)dataArray indexArray:(NSMutableArray *)sectionIndexArray{
    self.resourceData = dataArray;
    self.indexData    = sectionIndexArray;
    if ([NSThread isMainThread]) {
        [self reloadData];
    } else {
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indexData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *indexArray = [self.resourceData objectAtIndex:section];
    return indexArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:instCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:instCellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = self.accessType;
    
    NSMutableArray *indexArray = [self.resourceData objectAtIndex:indexPath.section];
    LNSelectIndexModel *instModel = [indexArray objectAtIndex:indexPath.row];
    cell.textLabel.text = instModel.text;
    cell.textLabel.font = [UIFont systemFontOfSize:16.f];
    cell.textLabel.textColor = UIColorFromRGB(0x333333);
    if (indexPath.row < indexArray.count) {
        UIView * line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = UIColorFromRGB(0xf7f7f7);
        [cell addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1.0f);
            make.left.equalTo(cell).offset(15);
            make.right.bottom.equalTo(cell);
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22.f;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    int searchIndex = -1;
    for (int i = 0; i <self.indexData.count; i ++) {
        if ([[self.indexData objectAtIndex:i] isEqualToString:title]) {
            searchIndex = i;
        }
    }
    if (searchIndex >= 0) {
        return searchIndex;
    }else{
        return NSNotFound;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
    view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    UILabel *indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 20, 22)];
    NSMutableArray *indexArray = [self.resourceData objectAtIndex:section];
    LNSelectIndexModel *instModel = [indexArray firstObject];
    [indexLabel setTextColor:UIColorFromRGB(0x999999)];
    indexLabel.font = [UIFont systemFontOfSize:12.f];
    indexLabel.text = instModel.sortKey;
    [view addSubview:indexLabel];
    return view;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    if (self.indexData == nil) {
        return nil;
    }
    return self.indexData;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexData objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.loanSelectDelegate && [self.loanSelectDelegate respondsToSelector:@selector(loanSelectRowAtIndexPath:)]) {
        [self.loanSelectDelegate loanSelectRowAtIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end


