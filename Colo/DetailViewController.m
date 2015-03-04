//
//  DetailViewController.m
//  Colo
//
//  Created by Wongzigii on 1/11/15.
//  Copyright (c) 2015 Wongzigii. All rights reserved.
//

#import "DetailViewController.h"
#import "PNBarChart.h"
#import "PNChartDelegate.h"
#import "PNColor.h"

@interface DetailViewController ()<PNChartDelegate>
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic)         PNBarChart *barChart;
@end

@implementation DetailViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    self.barChart.delegate = nil;
    self.barChart = nil;
    self.effectView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self initializeBlurBackground];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initializeBarChart];
    [self performSelector:@selector(updateValue) withObject:nil afterDelay:5.0];
}

- (void)updateValue
{
    //[self.barChart updateChartData:@[@(arc4random() % 30),@(arc4random() % 30),@(arc4random() % 30)]];
    [self.barChart updateChartData:@[@250,@250,@250]];
}

- (void)initializeBarChart
{
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, self.view.bounds.size.width, 300.0)];
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yMaxValue = 255.0;
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    self.barChart.labelFont = [UIFont systemFontOfSize:15];
    self.barChart.labelMarginTop = 5.0;
    [self.barChart setXLabels:@[@"Red",@"Green",@"Blue"]];
    
    self.barChart.rotateForXAxisText = true ;
    [self.barChart setYValues:@[@255,@51,@102]];
    [self.barChart setStrokeColors:@[WZRedEndColor, WZGreenEndColor, WZBlueEndColor]];
    // Adding gradient
//    self.barChart.barColorGradientStart = [UIColor orangeColor];
    
//    PNBar *bar1 = [self.barChart.bars objectAtIndex:0];
//    bar1.barColorGradientStart = [UIColor redColor];
//    PNBar *bar2 = [self.barChart.bars objectAtIndex:1];
//    bar2.barColorGradientStart = [UIColor greenColor];
//    PNBar *bar3 = [self.barChart.bars objectAtIndex:2];
//    bar3.barColorGradientStart = [UIColor blueColor];
    
//    PNBar *bar = [self.barChart.bars objectAtIndex:0];
//    bar.barColor = [UIColor redColor];
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    
    [self.effectView addSubview:self.barChart];
}

- (void)initializeBlurBackground
{
    //blur view background
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        self.effectView.frame = self.view.bounds;
        self.effectView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.effectView];
        
        [self.effectView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.effectView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1
                                                               constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.effectView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1
                                                               constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.effectView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1
                                                               constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.effectView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1
                                                               constant:0]];
    }else{
        [self.view setBackgroundColor:[UIColor blackColor]];
    }
}

- (void)done
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
