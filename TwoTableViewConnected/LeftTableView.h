//
//  LeftTableView.h
//  TwoTableViewConnected
//
//  Created by KevinHe on 2017/12/21.
//  Copyright © 2017年 KevinHehuachao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Header.h"
@protocol LeftTableViewDelegate <NSObject>

- (void)setCurrentIndexPath:(NSIndexPath*)indexPath;

@end

@interface LeftTableView : UIView



@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataSource;


@property (nonatomic,weak)id <LeftTableViewDelegate> delegate;

//返回当前选择的cell的行
- (NSInteger)currentSeletedIndex;


//设选中的cell
- (void)setSeletedIndex:(NSInteger)index;


- (void)refreshData:(NSArray*)dataArray;

@end
