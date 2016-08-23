//
//  AppDelegate.m
//  PerApp
//
//  Created by Varun Kumar on 24/02/16.
//  Copyright © 2016 Varun. All rights reserved.
//

#import "AppDelegate.h"
#import "ProjectNavigationController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualStateManager.h"


@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)pushToNewsFeedScreen{
    
    [self.window setRootViewController:nil];
    
    UIColor *navBarColor = [UIColor colorWithRed:52.0/255.0 green:56.0/255.0 blue:52.0/255.0 alpha:1.0];
    //tintColor attribute change the background color of the navigation bar
    /*
     barTintColor attribute affect to the color of the
     back indicator image, button titles, button images
     */
    [[UINavigationBar appearance] setBarTintColor:navBarColor];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header"] forBarMetrics:UIBarMetricsDefault];
    // change navigation item title color
//    NSDictionary *titleDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
//    [[UINavigationBar appearance] setTitleTextAttributes:titleDict];

    
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController * leftSideDrawerViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    UIViewController * centerViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    
    ProjectNavigationController * navigationController = [[ProjectNavigationController alloc] initWithRootViewController:centerViewController];
    [navigationController.navigationBar setTranslucent:YES];
    
    
    ProjectNavigationController * leftSideNavController = [[ProjectNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
    [leftSideNavController.navigationBar setTranslucent:YES];
    [leftSideNavController setNavigationBarHidden:YES animated:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    leftSideNavController.navigationBar.barStyle = UIBarStyleBlackTranslucent;

    

    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:leftSideDrawerViewController
                             rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];
    [self.window setRootViewController:self.drawerController];
    
}

@end
