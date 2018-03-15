//
//  LvPickerView.m
//  PickViewDemo
//
//  Created by lv on 2018/3/13.
//  Copyright © 2018年 bdl. All rights reserved.
//

#import "LvPickerView.h"
#import <Masonry/Masonry.h>

#define KHeight [UIScreen mainScreen].bounds.size.height
#define KWidth [UIScreen mainScreen].bounds.size.width

@interface LvPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>



@end

@implementation LvPickerView

-(void)initSomething {
    
    self.font = [UIFont systemFontOfSize:18];
    self.animationDuration = 0.3f;
    self.textColor = [UIColor blackColor];
    self.rowHeight = 50;
    
    [self bgView];
    [self contentView];
    [self btnCancel];
    [self btnOK];
    
    [self sendSubviewToBack:self.bgView];
}

-(void)btnOKClick {
    
    if (self.selectOKClick) {
        
        self.selectOKClick(self.component, self.row, self.item);
    }
    
    [self dismiss];
}

-(void)btnCancelClick {
    
    [self dismiss];
}

-(UIButton *)btnOK {
    
    if (_btnOK == nil) {
        
        _btnOK = [[UIButton alloc] init];
        _btnOK.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [_btnOK setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnOK addTarget:self action:@selector(btnOKClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnOK];
        
        [_btnOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(self.contentView);
        }];
    }
    
    return _btnOK;
}

-(UIButton *)btnCancel {
    
    if (_btnCancel == nil) {
        
        _btnCancel = [[UIButton alloc] init];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:16];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnCancel];
        
        [_btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.left.mas_equalTo(self.contentView);
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(self.contentView);
        }];
    }
    
    return _btnCancel;
}


/**
 单列选择
 
 @param items 数据源
 @return self对象
 */
- (instancetype)initWithItem:(NSArray <NSString *> *)items selectOK:(SelectOKClick)selectOK
{
    self = [super init];
    if (self) {
        
        self.selectOKClick = selectOK;
        
        [self initSomething];
        
        self.widthForComponent = KWidth;
        
        self.arrItems = [NSMutableArray arrayWithCapacity:0];
        [self.arrItems addObject:items];
        
        [self pickerView];
        
        
        
    }
    return self;
}


-(UIView *)contentView {
    
    if (_contentView == nil) {
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(self).offset(KHeight * 0.35);
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(KHeight * 0.35);
            
        }];

    }
    
    return _contentView;
}

-(UIView *)bgView {
    
    if (_bgView == nil) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.0;
        [self addSubview:_bgView];
        

        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [_bgView addGestureRecognizer:tap];
    }
    
    return _bgView;
}

-(void)tapClick {
    
    [self dismiss];
    
}



-(void)show {
    
  
    if ([UIApplication sharedApplication].keyWindow == nil) {
        
        NSLog(@"没有主视图");
        
        return;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.superview layoutIfNeeded];//强制绘制
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
    
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        
        self.bgView.alpha = 0.5;
        
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(self).multipliedBy(0.35);
        }];
        
        [self.contentView.superview layoutIfNeeded];//强制绘制
    }];
    
}

-(void)showInView:(UIView *)view {
    
    [view addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.superview layoutIfNeeded];//强制绘制
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
    
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        
        self.bgView.alpha = 0.5;
        
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(self).multipliedBy(0.35);
        }];
        
        [self.contentView.superview layoutIfNeeded];//强制绘制
    }];

}

-(void)dismiss {
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        
        self.bgView.alpha = 0.0;
        
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.bottom.mas_equalTo(self).offset(KHeight * 0.35);
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(KHeight * 0.35);
            
        }];
        
        [self.contentView.superview layoutIfNeeded];//强制绘制
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}


-(UIPickerView *)pickerView {
    
    if (_pickerView == nil) {
        
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self.contentView addSubview:_pickerView];
        
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(50, 0, 0, 0));
        }];
    }
    
    return _pickerView;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.arrItems.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.arrItems[component].count;
}

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
//
//    NSString *string = self.arrItems[component][row];
//
//    NSAttributedString *att = [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName:self.textColor, NSFontAttributeName:self.font}];
//
//    return att;
//}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return self.rowHeight;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return self.widthForComponent;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {

    UILabel *labTitle = (UILabel *)view;

    if (labTitle == nil) {

        labTitle = [[UILabel alloc] init];
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.text = self.arrItems[component][row];
    }

    labTitle.font = self.font;
    labTitle.textColor = self.textColor;

    return labTitle;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"component = %zd, row = %zd", component, row);
    self.row = row;
    self.component = component;
    self.item = self.arrItems[component][row];
    
    if (self.didSelect) {
        
        self.didSelect(component, row, self.item);
    }
}

-(void)setFont:(UIFont *)font {
    
    _font = font;
    
    [self.pickerView reloadAllComponents];
}

-(void)setTextColor:(UIColor *)textColor {
    
    _textColor = textColor;
    
    [self.pickerView reloadAllComponents];
}

@end
