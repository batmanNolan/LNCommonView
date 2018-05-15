//
//  LNMultiSelectTableViewCell.m
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import "LNMultiSelectTableViewCell.h"
#import "Masonry.h"
@interface LNMultiSelectTableViewCell()
@property(nonatomic,assign)SelectedCellType cellType;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UILabel *valueLabel;
@end

@implementation LNMultiSelectTableViewCell

+(LNMultiSelectTableViewCell *)cellWithTableView:(UITableView *)tableView {
    LNMultiSelectTableViewCell * cell = [LNMultiSelectTableViewCell cellWithTableView:tableView cellType:Line_Type];
    return cell;
}

+(LNMultiSelectTableViewCell *)cellWithTableView:(UITableView *)tableView cellType:(SelectedCellType)cellType{
    LNMultiSelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:multicellId];
    if (!cell) {
        cell = [[LNMultiSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:multicellId cellType:cellType];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(SelectedCellType)cellType{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.touched = NO;
    self.cellType = cellType;
    if (self) {
        [self masonryLayout];
    }
    return self;
}

-(void)masonryLayout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.width/18);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(self.width/12);
        make.right.equalTo(self).offset(-10);
    }];
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        [self.line setBackgroundColor:UIColorFromRGB(0xe0e0e0)];
        if (self.cellType == Seperate_Type) {
            self.line.hidden = YES;
        }
        [self addSubview:self.line];
    }
    return _line;
}

-(UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueLabel.font = [UIFont systemFontOfSize:14.f];
        _valueLabel.textColor = UIColorFromRGB(0x999999);
        [_valueLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.valueLabel];
    }
    return _valueLabel;
}

-(void)setTreeModel:(LNTreeModel *)treeModel{
    _treeModel = treeModel;
    self.valueLabel.text =treeModel.value;
}


-(void)selectedCell:(BOOL)touched{
    if (touched) {
        if (self.cellType == Line_Type) {
            self.valueLabel.textColor = UIColorFromRGB(0x999999);
            [self.line setBackgroundColor:UIColorFromRGB(0xe0e0e0)];
        }else if (self.cellType == Seperate_Type) {
            [self setBackgroundColor:[UIColor clearColor]];
        }
    }else{
        if (self.cellType == Line_Type) {
            self.valueLabel.textColor = UIColorFromRGB(0x52BEA6);
            [self.line setBackgroundColor:UIColorFromRGB(0x52BEA6)];
        }else if (self.cellType == Seperate_Type) {
            [self setBackgroundColor:UIColorFromRGB(0xFFFFFF)];
        }
    }
}

@end
