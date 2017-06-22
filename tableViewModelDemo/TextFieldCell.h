//
//  TextFieldCell.h
//  tableViewModelDemo
//
//  Created by Johnray on 2017/6/18.
//  Copyright © 2017年 Johnray. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CreateTableModel;
@interface TextFieldCell : UITableViewCell
@property (nonatomic,weak) CreateTableModel *creatTableModel;
@property (nonatomic,weak) NSDictionary *formDict;
//方便外部把控好输入框
- (void)textFieldAddObserver:(id)observer selector:(SEL)selector;
@end
