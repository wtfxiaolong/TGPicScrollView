//
//  ViewController.m
//  TGPicScrollView
//
//  Created by linxiaolong on 15/1/16.
//  Copyright (c) 2015年 linxiaolong. All rights reserved.
//

#import "ViewController.h"
#import "PicScroView.h"

@interface ViewController () <PicScrollDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    CGRect rect = CGRectMake(20, 150, 270, 120);
    
    PicScroView *adView = [[PicScroView alloc] initWithFrame:rect delegate:self imageArray:array];
    [adView startTurnning];
    [self.view addSubview:adView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectedImage:(int)index {
    NSLog(@"%d", index);
}

@end
