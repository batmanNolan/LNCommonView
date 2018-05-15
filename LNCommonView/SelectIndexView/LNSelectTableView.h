//
//  LNSelectTableView.h
//  LNCommonView
//
//  Created by nolan on 2018/3/7.
//  Copyright © 2018年 LN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LNLoanSelectDelegate<NSObject>
- (void)loanSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface LNSelectTableView : UITableView
-(void)reloadSelectTableView:(NSMutableArray *)dataArray indexArray:(NSMutableArray *)sectionIndexArray;
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style accessoryType:(UITableViewCellAccessoryType)accessType;
@property (nonatomic,weak) id<LNLoanSelectDelegate> loanSelectDelegate;
@end


