//
//  AppDelegate.m
//  LQFLearnDemo
//
//  Created by liqunfei on 2017/7/13.
//  Copyright © 2017年 LQF. All rights reserved.
//

#import "AppDelegate.h"
#import "FHHFPSIndicator.h"
#import "ViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface AppDelegate () <RCIMUserInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //融云初始化
    [[RCIM sharedRCIM] initWithAppKey:@"c9kqb3rdcxkrj"];
    
    //lqf0001:  0+ac83GOKxw1PIbdRM3mc1OH4jTlfiWYGcBGb0nC1HYkgtCpskCdS3WsgNaYoImOBvLXycwmKo12tcvhSbE1aQ==
    //lqf:      WTVLoWwrQl/JopOKx1i61sXfp4PaogOhJhKUIzbyg9UpAQc3D0GTTeMuGUQZG00yJ2Ow7A+Ch+I6MDmWnm1Xog==
    [[RCIM sharedRCIM] connectWithToken:@"0+ac83GOKxw1PIbdRM3mc1OH4jTlfiWYGcBGb0nC1HYkgtCpskCdS3WsgNaYoImOBvLXycwmKo12tcvhSbE1aQ==" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID:%@",userId);
        
        //用户信息
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登录的错误码为:%ld",(long)status);
    } tokenIncorrect:^{
        NSLog(@"token错误");
    }];
    
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    //用户昵称 头像
    if ([userId isEqualToString:@"lqf"]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc] init];
        userInfo.userId = userId;
        userInfo.name = @"Idler";
        userInfo.portraitUri = @"https://static.lagou.com/thumbnail_200x200/image1/M00/00/BB/Cgo8PFTUYDuAXoUYAAAav1V75Pk815.jpg";
        return completion(userInfo);
    }
    else if ([userId isEqualToString:@"lqf0001"]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc] init];
        userInfo.userId = userId;
        userInfo.name = @"Clone";
        userInfo.portraitUri = @"https://static.lagou.com/thumbnail_300x300/image1/M00/00/08/Cgo8PFTUWBCAcSJHAAB-yfiYxHM640.png";
        return completion(userInfo);
    }
    return completion(nil);
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"LQFLearnDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
