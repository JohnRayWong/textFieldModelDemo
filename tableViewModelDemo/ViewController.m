//
//  ViewController.m
//  tableViewModelDemo
//
//  Created by Johnray on 2017/6/18.
//  Copyright © 2017年 Johnray. All rights reserved.
//

#import "ViewController.h"
#import "TextFieldCell.h"
#import "CreateTableModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *formDict;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.formDict = [NSMutableDictionary dictionary];
    [self creatData];
}

- (void)commitAction
{
    NSLog(@"%@",self.formDict);
}

- (void)creatData
{
    self.dataArray = @[].mutableCopy;
    
    CreateTableModel *name = [CreateTableModel new];
    name.cellType = CreateTableTFCell;
    name.title = @"名字";
    name.placeholder = @"请输入名字";
    //提交到服务器的key
    name.key = @"name";
    [self.dataArray addObject:name];
    
    CreateTableModel *nickName = [CreateTableModel new];
    nickName.cellType = CreateTableTFCell;
    nickName.title = @"昵称";
    nickName.placeholder = @"请输入昵称";
    //提交到服务器的key
    nickName.key = @"nickName";
    [self.dataArray addObject:nickName];
    
    CreateTableModel *separator = [CreateTableModel new];
    separator.cellType = CreateTableSeparatorCell;
    [self.dataArray addObject:separator];
    
    CreateTableModel *psw = [CreateTableModel new];
    psw.cellType = CreateTableTFCell;
    psw.title = @"密码";
    psw.placeholder = @"请输入密码";
    //提交到服务器的key
    psw.key = @"psw";
    [self.dataArray addObject:psw];
    
    CreateTableModel *psw2 = [CreateTableModel new];
    psw2.cellType = CreateTableTFCell;
    psw2.title = @"确认密码";
    psw2.placeholder = @"请确认密码";
    //提交到服务器的key
    psw2.key = @"psw2";
    [self.dataArray addObject:psw2];
}

#pragma mark - UITableDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateTableModel *model = self.dataArray[indexPath.row];
    if (model.cellType == CreateTableSeparatorCell) {
        static NSString *cellID = @"SeparatorCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor lightGrayColor];
        }

        return cell;
    }else if (model.cellType == CreateTableTFCell){
        static NSString *cellID = @"textFieldCellID";
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //监听textField输入
            [cell textFieldAddObserver:self selector:@selector(textFieldValueChange:)];
        }
                
        cell.creatTableModel = model;
        cell.formDict = self.formDict;
        return cell;
        
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateTableModel *model = self.dataArray[indexPath.row];
    if (model.cellType == CreateTableSeparatorCell) {
        return 15;
    }
    
    return 44;
}

- (void)textFieldValueChange:(NSNotification *)note
{

    UITextField *textField = note.object;
    //可以这样取值
    NSString *name = self.formDict[@"name"];
    NSString *nickName = self.formDict[@"nickName"];
    NSString *psw = self.formDict[@"psw"];
    NSString *psw2 = self.formDict[@"psw2"];
    
    NSLog(@"现在输入的是：%@\nname = %@,\nnickName = %@,\npsw = %@,\npsw2 = %@,\n",textField.text,
          name,
          nickName,
          psw,
          psw2);
}

//因为监听了textField通知，所以记得要在注销时，注销通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
