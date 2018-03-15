//
//  LvPickerView.h
//  PickViewDemo
//
//  Created by lv on 2018/3/13.
//  Copyright © 2018年 bdl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectOKClick)(NSInteger component, NSInteger row, NSString *item);
typedef void(^DidSelect)(NSInteger component, NSInteger row, NSString *item);
@interface LvPickerView : UIView

@property(nonatomic, strong)NSMutableArray <NSArray<NSString *> *>*arrItems;
@property(nonatomic, strong)UIPickerView *pickerView;
@property(nonatomic, strong)UIFont *font;
@property(nonatomic, strong)UIColor *textColor;
@property(nonatomic, assign)CGFloat animationDuration;
@property(nonatomic, assign)CGFloat rowHeight;
@property(nonatomic, assign)CGFloat widthForComponent;

@property(nonatomic, assign)CGFloat component;
@property(nonatomic, assign)CGFloat row;
@property(nonatomic, strong)NSString *item;

@property(nonatomic, copy)SelectOKClick selectOKClick;
@property(nonatomic, copy)DidSelect didSelect;

@property(nonatomic, strong)UIView *contentView;
@property(nonatomic, strong)UIView *bgView;

@property(nonatomic, strong)UIButton *btnCancel;
@property(nonatomic, strong)UIButton *btnOK;

/**
 单列选择
 
 @param items 数据源
 @return self对象
 */
- (instancetype)initWithItem:(NSArray <NSString *> *)items selectOK:(SelectOKClick)selectOK;

-(void)show;
-(void)showInView:(UIView *)view;
-(void)dismiss;

@end
