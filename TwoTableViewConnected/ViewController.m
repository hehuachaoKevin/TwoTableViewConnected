//
//  ViewController.m
//  TwoTableViewConnected
//
//  Created by KevinHe on 2017/12/21.
//  Copyright © 2017年 KevinHehuachao. All rights reserved.
//

#import "ViewController.h"
#import "LeftTableView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,LeftTableViewDelegate>
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,weak)LeftTableView *leftTableView;
@property (nonatomic,assign)BOOL leftTableViewNeedScroll;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self initData];
}

- (void)initData{
    //注意 要初始化
    self.leftTableViewNeedScroll = YES;
}


- (void)createUI{
    
    //左边视图
    LeftTableView *leftTableView = [[LeftTableView  alloc]init];
    [self.view addSubview:leftTableView];
    _leftTableView = leftTableView;
    _leftTableView.frame = CGRectMake(0, 64, SCREEN_WIDTH*3/10, SCREEN_HEIGHT-64);

    self.leftTableView.delegate = self;
    
    self.leftTableView.backgroundColor =  [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    
    
    
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3/10.0, 64, SCREEN_WIDTH*7/10.0, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.bounces = NO;
   
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    tableView.backgroundColor = [UIColor grayColor];
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    //ios 11 以上的问题
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
}


#pragma mark - scrollView.delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self getCurrentSection];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    self.leftTableViewNeedScroll = YES;
    
}

//调整左边的tableview
- (void)getCurrentSection{
    
    NSArray *array = [self.tableView visibleCells];
    
    if (array.count) {
        UITableViewCell *cell = [array objectAtIndex:0];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if (indexPath) {
            
            if ([self.leftTableView currentSeletedIndex]!=indexPath.section
                && self.leftTableViewNeedScroll) {
                
                [self.leftTableView setSeletedIndex:indexPath.section];
            }
            
        }
    }
}




#pragma mark - delegate.LeftTableView
- (void)setCurrentIndexPath:(NSIndexPath*)indexPath{
    self.leftTableViewNeedScroll = NO;
    NSArray *array = [self.tableView visibleCells];
    
    if (array.count) {
        UITableViewCell *cell = [array objectAtIndex:0];
        NSIndexPath *indexPathTemp = [self.tableView indexPathForCell:cell];
        if (indexPath) {
            
            if (indexPathTemp.section!=indexPath.section) {
                
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            }
            
        }
    }
    
}

#pragma mark - tableView.delegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, SCREEN_WIDTH, 36);
    label.text = [NSString stringWithFormat:@"%ld",(long)section];
    return label;
}


- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 36;
    
}


#pragma mark - tableView.dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];

    cell.textLabel.text = [NSString stringWithFormat:@"section=%ld row=%ld",indexPath.section,indexPath.row];
    
    return cell;
}


#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
