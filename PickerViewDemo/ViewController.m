//
//  ViewController.m
//  PickerViewDemo
//
//  Created by lv on 2018/3/13.
//  Copyright © 2018年 bdl. All rights reserved.
//

#import "ViewController.h"
#import "LvPickerView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property(nonatomic, strong)UIButton *btnShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self btnShow];
}

-(void)btnClick {
    
    LvPickerView *pickerView  = [[LvPickerView alloc] initWithItem:@[@"选项1", @"选项2", @"选项1", @"选项2"] selectOK:^(NSInteger component, NSInteger row, NSString *item) {
       NSLog(@"component = %zd, row = %zd", component, row);
    }];
    [pickerView showInView:self.view];
}

-(UIButton *)btnShow {
    
    if (_btnShow == nil) {
        
        _btnShow = [[UIButton alloc] init];
        [_btnShow setTitle:@"客户" forState:UIControlStateNormal];
        [_btnShow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnShow addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.view addSubview:_btnShow];
        
        [_btnShow mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.view);
            make.width.mas_equalTo(200);
            make.top.mas_equalTo(self.view).offset(100);
            make.height.mas_equalTo(44);
            
        }];
    }
    
    return _btnShow;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
