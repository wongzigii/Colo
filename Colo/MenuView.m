//
//  MenuView.m
//  Colo
//
//  Created by Wongzigii on 15/3/7.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "MenuView.h"
#import "Constant.h"
#import "CollectionViewController.h"

@interface MenuView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *titleArray;
@property (nonatomic, readwrite) BOOL     didOpenMenu;

@end

@implementation MenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight / 2)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.didOpenMenu = NO;
        self.titleArray = @[@"Dansk", @"Deutsch", @"English", @"Español", @"Français", @"Italiano", @"Nederlands", @"Norsk", @"Polski", @"Português", @"Suomi", @"Svenska", @"Türkçe", @"Pусский", @"繁體中文", @"日本語", @"한국어"];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)handleHideOrShow
{
    if (!self.didOpenMenu) {
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self setFrame:CGRectMake(0, kDeviceHeight / 2 - 49, kDeviceWidth, kDeviceHeight / 2)];
                         }
                         completion:^(BOOL finished) {
                             self.didOpenMenu = YES;
                         }];
    }else{
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self setFrame:CGRectMake(0, kDeviceHeight - 49, kDeviceWidth, kDeviceHeight / 2)];
                         }
                         completion:^(BOOL finished) {
                             self.didOpenMenu = NO;
                         }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Futura" size:16.0];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.didOpenMenu) {
        [UIView animateWithDuration:0.3 animations:^{
            [self setFrame:CGRectMake(0, kDeviceHeight - 49, kDeviceWidth, kDeviceHeight / 2)];
        } completion:^(BOOL finished) {
            self.didOpenMenu = NO;
        }];
    }
    [self.delegate passValueFromMenuToCollectionViewController:indexPath.row];
}

@end
