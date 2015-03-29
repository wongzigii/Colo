//
//  FavouriteViewController.m
//  Colo
//
//  Created by Wongzigii on 15/3/7.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "FavouriteViewController.h"
#import "MiniColorCell.h"
static NSString *MiniCellIdentifier = @"MiniColorCell";

@interface FavouriteViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, readwrite) NSMutableArray *favouriteArray;
@end

@implementation FavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MiniColorCell class] forCellReuseIdentifier:MiniCellIdentifier];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.tableView.delegate = nil;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MiniColorCell *cell = [tableView dequeueReusableCellWithIdentifier:MiniCellIdentifier];
    cell.firstColor.backgroundColor  = [UIColor redColor];
    cell.secondColor.backgroundColor = [UIColor whiteColor];
    cell.thirdColor.backgroundColor  = [UIColor greenColor];
    cell.fourthColor.backgroundColor = [UIColor orangeColor];
    cell.fifthColor.backgroundColor  = [UIColor purpleColor];
    
    [cell setNeedsUpdateConstraints];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
