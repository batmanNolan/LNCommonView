//
//  ViewController.m
//  LNCommonView
//
//  Created by nolan on 2018/5/13.
//  Copyright © 2018年 nolan. All rights reserved.
//

#import "ViewController.h"
#import "MultiSelectTestVC.h"
#import "SelectIndexTestVC.h"
@interface ViewController (){
    NSArray *btnNameArray;
    NSMutableArray *btnArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LN页面组件Demo";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    btnNameArray = @[@"首字母检索TableView", @"多选Tableview"];
    NSArray *colorArray = @[UIColorFromRGB(0xEA87FF), UIColorFromRGB(0xF8837D), UIColorFromRGB(0xFEC536), UIColorFromRGB(0xD63A36), UIColorFromRGB(0x00BFFF)];
    
    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height-44-20;
    CGFloat gap = 40;
    CGFloat btnHeight = (viewHeight-40*(btnNameArray.count+1))/btnNameArray.count;
    
    btnArray = [NSMutableArray array];
    for (int i = 0; i < btnNameArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(gap, (i+1)*gap+btnHeight*i, viewWidth-gap*2, btnHeight);
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
        [btn setBackgroundColor:colorArray[i]];
        [btn setTitle:btnNameArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnPsd:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [btnArray addObject:btn];
    }
}

- (void)btnPsd:(UIButton *)btn {
    if (btn.tag == 0) {
        SelectIndexTestVC *vc = [[SelectIndexTestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(btn.tag == 1){
        MultiSelectTestVC *vc = [[MultiSelectTestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
