//
//  ProjectNavigationController.m
//  PerApp
//
//  Created by Varun Kumar on 24/02/16.
//  Copyright © 2016 Varun. All rights reserved.
//

#import "ProjectNavigationController.h"

#import "UIViewController+MMDrawerController.h"


@interface ProjectNavigationController ()

@end

@implementation ProjectNavigationController



-(UIStatusBarStyle)preferredStatusBarStyle{
    if(self.mm_drawerController.showsStatusBarBackgroundView){
        return UIStatusBarStyleLightContent;
    }
    else {
        return UIStatusBarStyleDefault;
    }
}


-(BOOL)shouldAutorotate
{
    UIViewController *top = self.topViewController;
    return [top shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    UIViewController *top = [[self viewControllers] lastObject];
    return top.supportedInterfaceOrientations;
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
