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
@property (nonatomic, strong)    UITableView       *tableView;
@property (nonatomic, readwrite) NSMutableArray    *favouriteArray;
@property (nonatomic, strong)    UIButton          *closeButton;
@end

@implementation FavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:39.0 / 255.0 green:39.0 / 255.0 blue:39.0 / 255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MiniColorCell class] forCellReuseIdentifier:MiniCellIdentifier];
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 25, 25)];
    [self.closeButton setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
    self.closeButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    [self.closeButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.closeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.tableView.delegate = nil;
}

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)passFavouriteArray:(NSMutableArray *)array
{
    self.favouriteArray = array;
}

- (NSMutableArray *)favouriteArray
{
    if (!_favouriteArray) {
        _favouriteArray = [NSMutableArray new];
    }
    return _favouriteArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favouriteArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MiniColorCell *cell = [tableView dequeueReusableCellWithIdentifier:MiniCellIdentifier];
    [cell configureForColor:[self.favouriteArray objectAtIndex:indexPath.row]];
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
        [self.favouriteArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
