//
//  AppDelegate.m
//  OCBaseKnowledge
//
//  Created by conan on 2019/8/14.
//  Copyright © 2019年 conan. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *homeVC = [[ViewController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = homeNav;
    
    
    /**
     不推荐使用new
     homeVC = [ViewController new];

     [className new]基本等同于[[className alloc] init]；
     区别只在于alloc分配内存的时候使用了zone.
     这个zone是个什么东东呢？
     它是给对象分配内存的时候，把关联的对象分配到一个相邻的内存区域内，以便于调用时消耗很少的代价，提升了程序处理速度；
     
     如果使用new的话，初始化方法被固定死只能调用init.
     
     而你想调用initXXX怎么办？没门儿！据说最初的设计是完全借鉴Smalltalk语法来的。
     
     传说那个时候已经有allocFromZone:这个方法
     
     new和alloc/init在功能上几乎是一致的，分配内存并完成初始化。
     
     差别在于，采用new的方式只能采用默认的init方法完成初始化，
     
     采用alloc的方式可以用其他定制的初始化方法。
     
     [NSArray array] 和 [[NSArray alloc]init] （包括字典等同类） 的使用方法的区别：
     alloc （内存分配）以及init（初始化） Objective-C 协议分为非正式协议和正式协议 .
     这两个方式都是建立一个空的Array
     [NSArray array]不需要release，使用autoreleasepool机制。
     [[NSArray alloc] init]需要自己手动release
     
     作者：单线程Jack
     链接：https://www.jianshu.com/p/0c2f9aa747d9
     来源：简书
     简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
     */
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
