//
//  LNMultiButtonView.h
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import <UIKit/UIKit.h>
//多级button的处理，这里除了可以展示view意外还可以展示其他的选择页面
@protocol LNMultiButtonViewDelegate<NSObject>
-(void)buttonTap:(int)btnTag selected:(BOOL)isSelect;
-(void)tapbackGround;
@end
@interface LNMultiButtonView : UIView
-(instancetype)initWithFrame:(CGRect)frame buttonTitle:(NSString *)titles,...NS_REQUIRES_NIL_TERMINATION;
@property(nonatomic,weak) id<LNMultiButtonViewDelegate> multiButtonViewDelegate;
@property(nonatomic,strong)NSMutableArray *dataArray;
-(void)pickUpButton:(int)btnTag;
-(void)buttonTitle:(NSString *)title btnTag:(int)btnTag;
-(void)pickupView;
@end
