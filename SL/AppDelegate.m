//
//  AppDelegate.m
//  ShuLianNet
//
//  Created by SD0025A on 15/4/3.
//  Copyright (c) 2015年 邵兰霞. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTAMViewController.h"
#import "SLLoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [NSThread sleepForTimeInterval:1.0];
    //    [self setNeedsStatusBarAppearanceUpdate];
    //    增加标识，用于判断是否是第一次启动应用...
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"first"].length <= 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"first" forKey:@"first"];
        first = YES;
    }
    if (first) {
        
        IndexViewController *indexController = [[IndexViewController alloc] init];
        indexController.delegate = self;
        self.window.rootViewController = indexController;
        [self.window setBackgroundColor:[UIColor whiteColor]];
        [self.window makeKeyAndVisible];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
    }else {
        
        NSUserDefaults *userdefault=[NSUserDefaults standardUserDefaults];
        BOOL isLogin=[[userdefault objectForKey:@"isLogin"] boolValue];
        if (isLogin) {
            RootTAMViewController* rootVc = [[RootTAMViewController alloc] init];
            self.window.rootViewController = rootVc;
            [self.window setBackgroundColor:[UIColor whiteColor]];
            [self.window makeKeyAndVisible];
            [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
            
        }else{
            SLLoginViewController* login = [[SLLoginViewController alloc] init];
            UINavigationController *loginnav=[[UINavigationController alloc]initWithRootViewController:login];
            self.window.rootViewController = loginnav;
            [self.window setBackgroundColor:[UIColor whiteColor]];
            [self.window makeKeyAndVisible];
            [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
        }
        //        [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    }
    
    
    return YES;
}

//mark-引导页回调
-(void)firstIn{
    
    SLLoginViewController* rootVc = [[SLLoginViewController alloc] init];
    UINavigationController *loginVC = [[UINavigationController alloc]initWithRootViewController:rootVc];
    self.window.rootViewController = loginVC;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:147.0/255.0 blue:236.0/255.0 alpha:1.0]];
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

@end
