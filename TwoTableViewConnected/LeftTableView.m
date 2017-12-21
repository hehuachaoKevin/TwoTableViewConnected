//
//  LeftTableView.m
//  TwoTableViewConnected
//
//  Created by KevinHe on 2017/12/21.
//  Copyright © 2017年 KevinHehuachao. All rights reserved.
//

#import "LeftTableView.h"

@interface LeftTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign)NSInteger currentSelectedIndex;
@end

@implementation LeftTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        [self initData];
        
    }
    return self;
}

- (void)initData{
    

    
    self.currentSelectedIndex = 0;
    
}

- (void)refreshData:(NSArray*)dataArray{
    
    
    [self.dataSource removeAllObjects];
    
   
    
    [self.tableView reloadData];
    [self setSeletedIndex:self.currentSelectedIndex];
}


- (void)createUI{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*3/10.0, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LeftTableViewUITableViewCell"];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*3/10.0, CGFLOAT_MIN)];
    self.tableView = tableView;
    [self addSubview:self.tableView];
    
    self.backgroundColor =  [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    self.tableView.backgroundColor =  [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
}


- (void)setSeletedIndex:(NSInteger)index{
    if (self.currentSelectedIndex == index) {
        return;
    }
    
    self.currentSelectedIndex = index;
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    if (self.dataSource.count>index) {
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (NSInteger)currentSeletedIndex{
    
    return self.tableView.indexPathForSelectedRow.row;
}

#pragma mark - tableView.dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftTableViewUITableViewCell"];
    
    if (self.currentSelectedIndex == indexPath.row) {
         cell.backgroundColor =  [UIColor whiteColor]; 
    }
    else{
        
        cell.backgroundColor =  [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}





#pragma mark - delegate.tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.currentSelectedIndex = indexPath.row;
    [self.tableView reloadData];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self setCellSelected:cell];
    NSIndexPath *indexPathTemp = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(setCurrentIndexPath:)]) {
        
        [self.delegate setCurrentIndexPath:indexPathTemp];
    }
}

- (void)setCellSelected:(UITableViewCell *)cell{
    if (cell) {
        cell.backgroundColor = [UIColor whiteColor];
    }
 
}


#pragma mark - 分割线的问题
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end

