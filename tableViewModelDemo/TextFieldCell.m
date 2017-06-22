//
//  TextFieldCell.m
//  tableViewModelDemo
//
//  Created by Johnray on 2017/6/18.
//  Copyright © 2017年 Johnray. All rights reserved.
//

#import "TextFieldCell.h"
#import "CreateTableModel.h"

@interface TextFieldCell()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UITextField *textField;
@end

@implementation TextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.label = [UILabel new];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    self.textField = [UITextField new];
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label.mas_right).offset(10);
        make.centerY.equalTo(self.label);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:self.textField];
}

#pragma mark --textField添加通知回调
- (void)textFieldAddObserver:(id)observer selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)setCreatTableModel:(CreateTableModel *)creatTableModel
{
    _creatTableModel = creatTableModel;
    
    self.label.text = creatTableModel.title;
     self.textField.placeholder = creatTableModel.placeholder;
}

- (void)setFormDict:(NSMutableDictionary *)formDict
{
    _formDict = formDict;
    self.textField.text = [formDict valueForKey:self.creatTableModel.key];
}

//将输入的内容保存到formDict里面
- (void)textFieldValueChanged:(NSNotification *)note
{
    if (!self.creatTableModel) {
        return;
    }
    [self.formDict setValue:self.textField.text forKey:self.creatTableModel.key];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

@end
