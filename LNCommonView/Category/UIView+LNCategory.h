//
//  UIView+LNCategory.h
//  LNCommonView
//
//  Created by nolan on 2018/5/13.
//  Copyright © 2018年 nolan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LNCategory)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;


- (void)removeAllSubviews;
- (UIViewController *)viewController;


@end
