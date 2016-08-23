//
//  SplashViewController.m
//  TourTravel
//
//  Created by abhayam rastogi on 02/02/16.
//  Copyright © 2016 Intelligrape. All rights reserved.
//

#import "SplashViewController.h"

#import "AppDelegate.h"
#import "Utility.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self gotoNewsFeedController];
}

-(void)gotoNewsFeedController{
    
    [(AppDelegate *)APPDELEGATE() pushToNewsFeedScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
