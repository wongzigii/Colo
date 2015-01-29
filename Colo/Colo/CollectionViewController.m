//
//  CollectionViewController.m
//  Colo
//
//  Created by Wongzigii on 11/25/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.
//

#import "CollectionViewController.h"
#import "ColorCell.h"
#import "Parser.h"
#import <QuartzCore/QuartzCore.h>
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "SwipeUpInteractionTransition.h"
#import "DetailViewController.h"
#import "SettingsViewController.h"
#import "BaseNavigationController.h"

static NSString *CellIdentifier = @"ColorCell";

@interface CollectionViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, ModalViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView    *tableView;
@property (strong, nonatomic) IBOutlet UIView         *bottomView;
@property (strong, nonatomic) IBOutlet UIButton    *settingsButton;
@property (strong, nonatomic) IBOutlet UIButton    *chooseButton;

@property (strong, nonatomic)          NSMutableArray *objectArray;
@property (strong, nonatomic)          NSMutableArray *titleArray;
@property (strong, nonatomic)          NSMutableArray *likesArray;

@property (strong, nonatomic) BouncePresentAnimation *presentAnimation;
@property (strong, nonatomic) NormalDismissAnimation *dismissAnimation;
@property (strong, nonatomic) SwipeUpInteractionTransition *transitionController;

@end

@implementation CollectionViewController
#pragma mark - LifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _presentAnimation     = [BouncePresentAnimation new];
        _dismissAnimation     = [NormalDismissAnimation new];
        _transitionController = [SwipeUpInteractionTransition new];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [UITableView new];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 144.0;
    self.tableView.bounces = YES;
    [self.tableView registerClass:[ColorCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:self.tableView];

    self.bottomView = [UIView new];
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.bottomView];
    
    self.settingsButton = [UIButton new];
    [self.settingsButton setImage:[UIImage imageNamed:@"gear.png"] forState:UIControlStateNormal];
    self.settingsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bottomView addSubview:self.settingsButton];
    [self.settingsButton addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    
    self.chooseButton = [UIButton new];
    [self.chooseButton setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    self.chooseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bottomView addSubview:self.chooseButton];
    [self.chooseButton addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
    
    _objectArray = [[NSMutableArray alloc] initWithArray:[Parser groupedTheArray:[Parser parseWithHTMLString]]];
    _titleArray  = [[NSMutableArray alloc] initWithArray:[Parser parsewithTitle]];
    _likesArray  = [[NSMutableArray alloc] initWithArray:[Parser parsewithLikes]];
    
    [self addConstraints];
}

- (void)settings
{
    SettingsViewController *vc = [[SettingsViewController alloc] init];
    vc.delegate = self;
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.transitionController wireToViewController:vc];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)choose
{
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pickerView];
    pickerView.showsSelectionIndicator = YES;
}

- (void)addConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView, _bottomView, _settingsButton, _chooseButton);
    
    NSString *format;
    NSArray *constraintsArray;
    
    format = @"V:|[_tableView][_bottomView(49)]|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintsArray];
    
    format = @"H:|[_tableView]|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintsArray];
    
    format = @"H:|[_bottomView]|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintsArray];
    
    
    //settings button
    format = @"V:[_settingsButton(20)]";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintsArray];
    
    [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:_settingsButton
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_bottomView
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0f
                                                             constant:0.0f]];
    
    //choose button
    format = @"V:[_chooseButton(17)]";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintsArray];
    
    [_bottomView addConstraint:[NSLayoutConstraint constraintWithItem:_chooseButton
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_bottomView
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0f
                                                             constant:0.0f]];
    
    format = @"H:|-[_chooseButton(17)]";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [_bottomView addConstraints:constraintsArray];
    
    format = @"H:[_settingsButton(20)]-|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [_bottomView addConstraints:constraintsArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.tableView setDelegate:nil];
    [self.tableView setDataSource:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_objectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ColorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSUInteger index  = [indexPath row];
    ColorModel *model = [_objectArray objectAtIndex:index];
    cell.title.text   = [_titleArray objectAtIndex:index];
    cell.favourites.text   = [_likesArray objectAtIndex:index];
    cell.firstColor.backgroundColor  = [model.colorArray objectAtIndex:0];
    cell.secondColor.backgroundColor = [model.colorArray objectAtIndex:1];
    cell.thirdColor.backgroundColor  = [model.colorArray objectAtIndex:2];
    cell.fourthColor.backgroundColor = [model.colorArray objectAtIndex:3];
    cell.fifthColor.backgroundColor  = [model.colorArray objectAtIndex:4];
    
    //Auto Layout
    [cell setNeedsUpdateConstraints];

    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ColorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell.contentView layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.delegate = self;
    vc.transitioningDelegate = self;
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.transitionController wireToViewController:vc];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transitionController.interacting ? self.transitionController : nil;
}

#pragma mark - ModalViewControllerDelegate
-(void)modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
//statusBar animation
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0 && scrollView.tracking == YES){
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.f;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int number = 0;
    switch (component) {
        case 0:
            number = 17;
            break;
        case 1:
            number = 3;
            break;
    }
    return number;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string;
    NSArray *titleArray = @[@"Dansk", @"Deutsch", @"English", @"Español", @"Français", @"Italiano", @"Nederlands", @"Norsk", @"Polski", @"Português", @"Suomi", @"Svenska", @"Türkçe", @"Pусский", @"繁體中文", @"日本語", @"한국어"];
    NSArray *popularityArray = @[@"周", @"月", @"全部"];
    switch (component) {
        //Country
        case 0:
            string = [titleArray objectAtIndex:row];
            break;
        //Popularity
        case 1:
            string = [popularityArray objectAtIndex:row];
            break;
    }
    return string;
}

@end
