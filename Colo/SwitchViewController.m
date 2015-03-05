//
//  SwitchViewController.m
//  Colo
//
//  Created by Wongzigii on 15/3/5.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "SwitchViewController.h"
#import "DetailViewController.h"

@interface SwitchViewController ()
@property (nonatomic, strong) DetailViewController *first;
@property (nonatomic, strong) DetailViewController *second;
@property (nonatomic, strong) DetailViewController *third;
@property (nonatomic, strong) DetailViewController *fourth;
@property (nonatomic, strong) DetailViewController *fifth;
@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _first  = [[DetailViewController alloc] init];
    _second = [[DetailViewController alloc] init];
    _third  = [[DetailViewController alloc] init];
    _fourth = [[DetailViewController alloc] init];
    _fifth  = [[DetailViewController alloc] init];
    
    [self addChildViewController:_first];
    [self addChildViewController:_second];
    [self addChildViewController:_third];
    [self addChildViewController:_fourth];
    [self addChildViewController:_fifth];
    // Do any additional setup after loading the view.
}

- (void)dealloc
{   
    self.view = nil;
    self.delegate = nil;
    self.transitioningDelegate = nil;
//    self.first = nil;
//    self.second = nil;
//    self.third = nil;
//    self.fourth = nil;
//    self.fifth = nil;
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
