//
//  BZCreateTbaleModel.h
//  bzys
//
//  Created by IOSdev on 2017/3/23.
//  Copyright © 2017年 IOSdev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CreateTableCellType) {
    CreateTableNormalCell,
    CreateTableTFCell,
    CreateTableSeparatorCell,
    CreateTableSelectCell,
    CreateTablePhotoCell,
    CreateTableTVCell,
};

@interface CreateTableModel : NSObject
// 名称
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *placeholder;
// 表单对应的字段
@property (nonatomic, copy)NSString *key;
//cell图片
@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,assign) NSInteger maxLength;
// cell的类型
@property (nonatomic, assign)CreateTableCellType cellType;

@property (nonatomic,assign) UIKeyboardType keyboardType;

//图片cell用到
@property (nonatomic,copy) NSString *imgURL;


@property (nonatomic,copy) NSString *controllerName;
@property (nonatomic,assign) BOOL hidesBottomBarWhenPushed;

@property (nonatomic,copy) void (^operationBlock)();

@end
