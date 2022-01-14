//
//  AppDelegate.m
//  Wallpaper
//
//  Created by 曾 on 2021/12/16.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
     UINavigationController *nav = [UINavigationController rootVC:[ViewController new] translationScale:NO];
//    nav.gk_openScrollLeftPush = YES;
//    nav.gk_openSystemNavHandle = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
   
    // Override point for customization after application launch.
    return YES;
}




@end
