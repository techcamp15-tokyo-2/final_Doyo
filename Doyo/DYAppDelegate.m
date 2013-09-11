//
//  DYAppDelegate.m
//  Doyo
//
//  Created by 小田 祐万 on 13/09/04.
//  Copyright (c) 2013年 小田 祐万. All rights reserved.
//

#import "DYAppDelegate.h"

//#import "DYViewController.h"

//#import "DYOTLViewController.h"
#import "DYTLViewController.h"
#import "DYTopicViewController.h"
#import "DYLogViewController.h"
#import "DYProfileViewController.h"

@implementation DYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.viewController = [[DYViewController alloc] initWithNibName:@"DYViewController" bundle:nil];
    //self.window.rootViewController = self.viewController;
    
    
    UITabBarController *tabCtl = [[UITabBarController alloc] init];
    
    DYTLViewController *tlCtl = [[DYTLViewController alloc] init];
    DYTopicViewController *topicCtl = [[DYTopicViewController alloc] init];
    DYLogViewController *logCtl = [[DYLogViewController alloc] init];
    DYProfileViewController *profileCtl = [[DYProfileViewController alloc] init];
    
    //UINavigationController *navCtl1 = [[UINavigationController alloc] initWithRootViewController:tlCtl];
    UINavigationController *navCtl2 = [[UINavigationController alloc] initWithRootViewController:topicCtl];
    UINavigationController *navCtl3 = [[UINavigationController alloc] initWithRootViewController:logCtl];
    UINavigationController *navCtl4 = [[UINavigationController alloc] initWithRootViewController:profileCtl];
    
    NSArray *tabArray = @[tlCtl, navCtl2, navCtl3, navCtl4];
    [tabCtl setViewControllers:tabArray animated:YES];
    
    self.window.rootViewController = tabCtl;
    
    UIImage *image = [UIImage imageNamed:@"tab_back"];
    UIImage *selectedBackImg = [UIImage imageNamed:@"tab_selected_back"];
    [[UITabBar appearance] setBackgroundImage:image];
    [[UITabBar appearance] setSelectionIndicatorImage:selectedBackImg];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationWillResignActive" object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidBecomeActive" object:nil];
}

/*
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
*/

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
/*
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
*/
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
