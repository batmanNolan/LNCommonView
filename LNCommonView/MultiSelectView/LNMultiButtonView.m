//
//  LNMultiButtonView.m
//  LNCommonView
//
//  Created by nolan on 2018/4/24.
//  Copyright © 2018年 LN. All rights reserved.
//

#import "LNMultiButtonView.h"
#define buttonTag       10
#define tableviewTag    100
@interface LNMultiButtonView()
@property(nonatomic,strong)NSMutableArray *btnTagArray;
@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic,assign)int            buttonHeight;
@end
@implementation LNMultiButtonView
-(instancetype)initWithFrame:(CGRect)frame buttonTitle:(NSString *)titles,...NS_REQUIRES_NIL_TERMINATION{
    self = [super initWithFrame:frame];
    self.buttonHeight = frame.size.height;
    if (self) {
        self.btnTagArray = [[NSMutableArray alloc] init];
        self.btnArray = [[NSMutableArray alloc] init];
        if (titles) {
            [self.btnTagArray addObject:titles];
            va_list argList;
            va_start(argList, titles);
            id arg;
            while((arg = va_arg(argList, id))){
                [self.btnTagArray addObject:arg];
            }
            va_end(argList);
        }
    }
    return self;
}

-(void)layoutSubviews{
    for (int i = 0; i <self.btnTagArray.count; i++) {
        UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/self.btnTagArray.count *i, 0, SCREEN_WIDTH/self.btnTagArray.count, self.buttonHeight)];
        [tempBtn setBackgroundColor:[UIColor whiteColor]];
        [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [tempBtn setTitle:[self.btnTagArray objectAtIndex:i] forState:UIControlStateNormal];
        [tempBtn setFont:[UIFont systemFontOfSize:14.f]];
        tempBtn.tag =buttonTag+i;
        [tempBtn addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:tempBtn];
        [self addSubview:tempBtn];
        UIImageView *angelView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/self.btnTagArray.count - 22, (self.buttonHeight -6)/2, 10, 6)];
        angelView.image = [UIImage imageNamed:@"qfm_broker_downarrow"];
        [tempBtn addSubview:angelView];
        if (i != 0) {
            UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/self.btnTagArray.count *i, self.buttonHeight/6, 1.0f, self.buttonHeight*2/3)];
            [line setBackgroundColor:UIColorFromRGB(0xf2f2f2)];
            [self addSubview:line];
        }
    }
}

-(void)buttonTap:(UIButton *)button{
    if (self.multiButtonViewDelegate && [self.multiButtonViewDelegate respondsToSelector:@selector(buttonTap:selected:)]) {
        int tag = button.tag -buttonTag;
        UIImageView *angelView = [[button subviews] objectAtIndex:0];
        if (button.isSelected) {
            [button setSelected:NO];
            angelView.image = [UIImage imageNamed:@"qfm_broker_downarrow"];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }else{
            [button setSelected:YES];
            angelView.image = [UIImage imageNamed:@"qfm_broker_uparrow"];
            [button setTitleColor:UIColorFromRGB(0x52bea6) forState:UIControlStateNormal];
        }
        if (tag == nil) {
            tag = 0;
        }
        for (int i =0 ; i<self.btnArray.count; i++) {
            if (i != tag) {
                [self pickUpButton:i];
            }
        }
        [self.multiButtonViewDelegate buttonTap:tag selected:button.isSelected];
    }
}
//收回button时候的按键变化
-(void)pickUpButton:(int)btnTag{
    UIButton *button = [self.btnArray objectAtIndex:btnTag];
    UIImageView *angelView = [[button subviews] objectAtIndex:0];
    [button setSelected:NO];
    angelView.image = [UIImage imageNamed:@"qfm_broker_downarrow"];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void)pickupView{
    for (int i = 0; i<self.btnArray.count; i++) {
        UIButton *button = [self.btnArray objectAtIndex:i];
        UIImageView *angelView = [[button subviews] objectAtIndex:0];
        [button setSelected:NO];
        angelView.image = [UIImage imageNamed:@"qfm_broker_downarrow"];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    if (self.multiButtonViewDelegate && [self.multiButtonViewDelegate respondsToSelector:@selector(tapbackGround)]) {
        [self.multiButtonViewDelegate tapbackGround];
    }
}

//点击后button时候的按键变化
-(void)buttonTitle:(NSString *)title btnTag:(int)btnTag{
    UIButton *button = [self.btnArray objectAtIndex:btnTag];
    [button setTitle:title forState:UIControlStateNormal];
    
}

@end
