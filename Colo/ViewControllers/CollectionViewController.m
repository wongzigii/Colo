//
//  CollectionViewController.m
//  Colo
//
//  Created by Wongzigii on 11/25/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Parser.h"
#import "ColorCell.h"
#import "AppDelegate.h"
#import "ColorManagerObject.h"
#import "DetailViewController.h"
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "SettingsViewController.h"
#import "CollectionViewController.h"
#import "BaseNavigationController.h"
#import "SwipeUpInteractionTransition.h"
#import "SwitchViewController.h"
#import "Constant.h"
#import "SimpleGetHTTPRequest.h"
#import "MenuView.h"
#import "MBProgressHUD.h"
#import "FavouriteViewController.h"

static NSString *JSHandler;
static NSString *CellIdentifier = @"ColorCell";

@interface CollectionViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, ModalViewControllerDelegate, MenuViewControllerDelegate, SWTableViewCellDelegate>

@property (strong, nonatomic) UITableView    *tableView;
@property (strong, nonatomic) UIView         *bottomView;
@property (strong, nonatomic) UIButton       *settingsButton;
@property (strong, nonatomic) UIButton       *chooseButton;
@property (strong, nonatomic) MenuView         *menuView;
@property (copy,   nonatomic) NSMutableArray *objectArray;
@property (copy,   nonatomic) NSString       *selectedString;
@property (assign, nonatomic) BOOL           didOpenMenu;
@property (strong, nonatomic) BouncePresentAnimation *presentAnimation;
@property (strong, nonatomic) NormalDismissAnimation *dismissAnimation;
@property (strong, nonatomic) SwipeUpInteractionTransition *transitionController;
@property (strong, nonatomic) NSMutableArray *objects;
@property (strong, nonatomic) SimpleGetHTTPRequest *request;
@property (weak,   nonatomic) NSString       *filePath;
@property (weak,   nonatomic) NSString       *countryChoosed;
@property (strong, nonatomic) NSArray        *webSiteArray;
@property (strong, nonatomic) FavouriteViewController *favouriteVC;
@property (strong, nonatomic) NSMutableArray *favouriteArray;
@end

@implementation CollectionViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && (self.view.window == nil)) {
        [_objectArray removeAllObjects];
        [_objects removeAllObjects];
        _selectedString = nil;
        _filePath = nil;
        _menuView = nil;
    }
}

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
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _objects        = [NSMutableArray new];
    _favouriteArray = [NSMutableArray new];
    _countryChoosed = COLO_DefaultCountryChoosed;
    _webSiteArray   = COLO_CountriesArray;
    
    //UI
    [self initializeUI];
    [self addConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self fetchDataFromServer];
}

#pragma mark - Private Methods
- (void)fetchDataFromServer
{
    NSFileManager *manager = [[NSFileManager alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], _countryChoosed];
    BOOL isExisted = [manager fileExistsAtPath:self.filePath];
    if (isExisted) {
        Parser *parser = [[Parser alloc] initWithPath:self.filePath];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [parser startParse];
            if (parser.returnArray) {
                self.objects = nil;
                self.objects = parser.returnArray;
                /// CoreData
                //[weakSelf saveData];
                //[weakSelf fetchDataFromCoreData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        });
        
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSURL *baseUrl = [NSURL URLWithString:@"http://www.wongzigii.com/Colo/"];
        self.request = [[SimpleGetHTTPRequest alloc] initWithURL:[NSURL URLWithString:_countryChoosed relativeToURL:baseUrl]];
        __unsafe_unretained typeof(self) weakSelf = self;
        self.request.completionHandler = ^(id result){
            if ([result isKindOfClass:[NSError class]]) {
                NSLog(@"Error : %@", result);
            }else{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    if (result) {
                        NSString *string = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
                        weakSelf.filePath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0],weakSelf.countryChoosed];
                        NSError *error;
                        [string writeToFile:weakSelf.filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
                        if (error) {
                            NSLog(@"Data can not save to local");
                        }
                        Parser *parser = [[Parser alloc] initWithPath:weakSelf.filePath];
                        [parser startParse];
                        if (parser.returnArray) {
                            weakSelf.objects = parser.returnArray;
                            /// CoreData
                            //[weakSelf saveData];
                            //[weakSelf fetchDataFromCoreData];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                                [weakSelf.tableView reloadData];
                            });
                        }
                    }
                });
            }
        };
        [self.request start];
    }
}

- (void)initializeUI
{
    _tableView      = [UITableView new];
    _bottomView     = [UIView      new];
    _settingsButton = [UIButton    new];
    _chooseButton   = [UIButton    new];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ColorCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view       addSubview:self.tableView];
    
    _menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 49, kDeviceWidth, kDeviceHeight / 2)];
    self.menuView.delegate = self;
    [self.view addSubview:self.menuView];
    
    self.bottomView.backgroundColor = [UIColor blackColor];
    self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchCountry)];
    [self.bottomView addGestureRecognizer:tap];
    tap.numberOfTapsRequired = 2;
    
    self.settingsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.settingsButton setImage:[UIImage imageNamed:@"gear.png"] forState:UIControlStateNormal];
    [self.settingsButton addTarget:self action:@selector(clickSettingsButton)
                  forControlEvents:UIControlEventTouchUpInside];
    
    self.chooseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.chooseButton setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    [self.chooseButton addTarget:self action:@selector(showFavouriteTable)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomView addSubview:self.settingsButton];
    [self.bottomView addSubview:self.chooseButton];
    [self.view       addSubview:self.bottomView];
}

- (void)switchCountry
{
    [self.menuView handleHideOrShow];
}

- (FavouriteViewController *)favouriteVC
{
    if (!_favouriteVC) {
        _favouriteVC = [[FavouriteViewController alloc] init];
    }
    return _favouriteVC;
}

- (void)showFavouriteTable
{
    [self.favouriteVC passFavouriteArray:self.favouriteArray];
    [self presentViewController:self.favouriteVC animated:YES completion:nil];
}

- (void)fetchDataFromCoreData
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Color"
                                                         inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entityDescription;
    
    NSSortDescriptor *indexSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    request.sortDescriptors = @[indexSortDescriptor];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if (!objects){
        NSLog(@"There was an error.");
    }
    
    for (ColorManagerObject *oneObject in objects){
//        NSString *title       = [oneObject valueForKey:@"title"];
//        NSString *star        = [oneObject valueForKey:@"star"];
//        NSString *index       = [oneObject valueForKey:@"index"];
        
        NSString *firstColor  = [oneObject valueForKey:@"firstColor"];
        NSString *secondColor = [oneObject valueForKey:@"secondColor"];
        NSString *thirdColor  = [oneObject valueForKey:@"thirdColor"];
        NSString *fourthColor = [oneObject valueForKey:@"fourthColor"];
        NSString *fifthColor  = [oneObject valueForKey:@"fifthColor"];
        
        UIColor *first  = [UIColor translateWithHexString:firstColor];
        UIColor *second = [UIColor translateWithHexString:secondColor];
        UIColor *third  = [UIColor translateWithHexString:thirdColor];
        UIColor *fourth = [UIColor translateWithHexString:fourthColor];
        UIColor *fifth  = [UIColor translateWithHexString:fifthColor];
        
        NSArray *array = @[first, second, third, fourth, fifth];
        [self.objects addObject:array];
    }
}

- (void)saveData
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSError *error;
    NSUInteger count = [_objectArray count];
    for (NSUInteger index = 0; index < count; index ++)
    {
        //Create fetch request.
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        //Create entity description for context.
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Color"
                                                             inManagedObjectContext:context];
        //Set entity for request.
        [request setEntity:entityDescription];
        
        //
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"index == %d",index];
        [request setPredicate:pred];
        
        //Declare a pointer.(for loading managed object or creating a new managed objcet)
        ColorManagerObject *managedObject;
        
        //Execute fetch request.
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if (!objects){
            NSLog(@"There was an error!");
        }
        
        //Check out objects which return from context by request, if so, load it, otherwise, initilize a new one to store.
        if ([objects count] > 0){
            managedObject = [objects objectAtIndex:0];
        }else{
            managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Color"
                                                    inManagedObjectContext:context];
        }
        
        //datasource
        ColorModel *model = [_objectArray objectAtIndex:index];
        //Key-Value-Coding
        managedObject.firstColor  = [model.colorArray objectAtIndex:0];
        managedObject.secondColor = [model.colorArray objectAtIndex:1];
        managedObject.thirdColor  = [model.colorArray objectAtIndex:2];
        managedObject.fourthColor = [model.colorArray objectAtIndex:3];
        managedObject.fifthColor  = [model.colorArray objectAtIndex:4];
        
        [managedObject setValue:[NSNumber numberWithUnsignedInteger:index] forKey:@"index"];
//        [managedObject setValue:[model.colorArray objectAtIndex:0] forKey:@"firstColor"];
//        [managedObject setValue:[model.colorArray objectAtIndex:1] forKey:@"secondColor"];
//        [managedObject setValue:[model.colorArray objectAtIndex:2] forKey:@"thirdColor"];
//        [managedObject setValue:[model.colorArray objectAtIndex:3] forKey:@"fourthColor"];
//        [managedObject setValue:[model.colorArray objectAtIndex:4] forKey:@"fifthColor"];
        [managedObject setValue:model.title      forKey:@"title"];
        [managedObject setValue:model.star       forKey:@"star"];
    }
    //error
    if (![context save:&error]) {
        NSLog(@"Can't save : %@", [error localizedDescription]);
    }
}

- (void)clickSettingsButton
{
    SettingsViewController *vc = [[SettingsViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)addConstraints
{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView, _bottomView, _settingsButton,_chooseButton);
    
    NSString *format;
    NSArray *constraintsArray;
    
    format = @"V:|[_tableView][_bottomView(49)]|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintsArray];
    
    format = @"H:|[_tableView(_bottomView)]|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintsArray];
    
    format = @"H:|[_bottomView]|";
    constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:constraintsArray];
    
//    [_tableView addConstraint:[NSLayoutConstraint constraintWithItem:_activityView
//                                                           attribute:NSLayoutAttributeCenterX
//                                                           relatedBy:NSLayoutRelationEqual
//                                                              toItem:_tableView
//                                                           attribute:NSLayoutAttributeCenterX
//                                                          multiplier:1.0f
//                                                            constant:0.0f]];
//    
//    [_tableView addConstraint:[NSLayoutConstraint constraintWithItem:_activityView
//                                                           attribute:NSLayoutAttributeCenterY
//                                                           relatedBy:NSLayoutRelationEqual
//                                                              toItem:_tableView
//                                                           attribute:NSLayoutAttributeCenterY
//                                                          multiplier:1.0f
//                                                            constant:0.0f]];

    
    
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

#pragma mark - MenuViewControllerdelegate
- (void)passValueFromMenuToCollectionViewController:(CGFloat)value
{
    NSString *string = [self.webSiteArray objectAtIndex:value];
    self.countryChoosed = string;
    [self fetchDataFromServer];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count] * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlainCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlainCell"];
        }
        cell.frame = CGRectMake(0, 0, kDeviceWidth, 50);
        cell.backgroundColor = [UIColor blackColor];
        cell.userInteractionEnabled = NO;
        return cell;
    }else{
        ColorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //http://objccn.io/issue-1-2/#separatingconcerns
        [cell configureForColor:[self.objects objectAtIndex:indexPath.row / 2]];
        //Auto Layout
        [cell setNeedsUpdateConstraints];
        [cell setRightUtilityButtons:self.rightButtons WithButtonWidth:58.0f];
        cell.delegate = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 100;
    }else return 50;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 100;
    }else return 50;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.isEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        SwitchViewController *switchVC = [[SwitchViewController alloc] init];
        switchVC.delegate = self;
        switchVC.transitioningDelegate = self;
        switchVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self.transitionController wireToViewController:switchVC];
        [self presentViewController:switchVC animated:YES completion:nil];
    }
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

#pragma mark - SWTableViewCellDelegate
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0] icon:[UIImage imageNamed:@"heart"]];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f] icon:[UIImage imageNamed:@"trash"]];
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    ColorModel *model = [self.objects objectAtIndex:cellIndexPath.row / 2];
    if (cellIndexPath.row % 2 == 0) {
        switch (index) {
            case 0:
            {
                if ([self.favouriteArray containsObject:model]) {
                    [self.favouriteArray removeObject:model];
                    [cell.rightUtilityButtons.firstObject setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
                }else{
                    [self.favouriteArray addObject:model];
                    [cell.rightUtilityButtons.firstObject setImage:[UIImage imageNamed:@"heart-selected"] forState:UIControlStateNormal];
                }
                [cell hideUtilityButtonsAnimated:YES];
                break;
            }
            case 1:
            {
                [self.objects removeObjectAtIndex:cellIndexPath.row / 2];
                [self.tableView reloadData];
                break;
            }
        }
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

@end
