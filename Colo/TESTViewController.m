//
//  TESTViewController.m
//  Colo
//
//  Created by Wongzigii on 15/3/7.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "TESTViewController.h"
#import "MinColorsCell.h"

@interface TESTViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TESTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MinColorsCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MinColorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.firstColor.backgroundColor = [UIColor redColor];
    cell.secondColor.backgroundColor = [UIColor whiteColor];
    cell.thirdColor.backgroundColor = [UIColor greenColor];
    cell.fourthColor.backgroundColor = [UIColor orangeColor];
    cell.fifthColor.backgroundColor = [UIColor purpleColor];
    
    [cell setNeedsUpdateConstraints];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
