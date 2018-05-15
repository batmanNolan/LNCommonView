//
//  GlobalDefine.h
//  LNCommonView
//
//  Created by nolan on 2018/5/13.
//  Copyright © 2018年 nolan. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

//颜色赋值
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT               ([UIScreen mainScreen].bounds.size.height)


//iphoneX下部安全高度
#define SafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34: 0)

#define SafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)

#endif /* globalDefine_h */
