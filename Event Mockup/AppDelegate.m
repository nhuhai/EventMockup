//
//  AppDelegate.m
//  Event Mockup
//
//  Created by Hai Nguyen on 12/7/13.
//  Copyright (c) 2013 Hai Nguyen. All rights reserved.
//

#import "AppDelegate.h"

#import "SWRevealViewController.h"
#import "MyEventViewController.h"
#import "RearViewController.h"

@interface AppDelegate()<SWRevealViewControllerDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    MyEventViewController *myEventViewController = [[MyEventViewController alloc] init];
    RearViewController *rearViewController = [[RearViewController alloc] init];
    
    UINavigationController *myEventNavigationController = [[UINavigationController alloc] initWithRootViewController:myEventViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:myEventNavigationController];
    revealController.delegate = self;
    
    self.viewController = revealController;
    self.window.rootViewController = self.viewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
