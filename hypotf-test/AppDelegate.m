//
//  AppDelegate.m
//  hypotf-test
//
//  Created by Engin Kurutepe on 12/01/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Adapted from https://gist.github.com/smic/1579069
    NSUInteger numberOfPoints = 1000;
    CGPoint points[numberOfPoints];
    for (NSUInteger pointIndex = 0; pointIndex < numberOfPoints; pointIndex++) {
        points[pointIndex].x = cosf((float)pointIndex / numberOfPoints * M_PI);
        points[pointIndex].y = sinf((float)pointIndex / numberOfPoints * M_PI);
        //            NSLog(@"%lu.Point = %@", pointIndex + 1, NSStringFromPoint(points[pointIndex]));
    }
    
    NSUInteger numberOfLoops = 1000000;
    
    CGFloat length = 0;
    NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate];
    for (NSUInteger loopIndex = 0; loopIndex < numberOfLoops; loopIndex++) {
        for (NSUInteger pointIndex = 1; pointIndex < numberOfPoints; pointIndex++) {
            CGFloat dx = points[pointIndex].x - points[pointIndex - 1].y;
            CGFloat dy = points[pointIndex].x - points[pointIndex - 1].y;
            length += sqrtf(dx * dx + dy * dy);
        }
    }
    time = [NSDate timeIntervalSinceReferenceDate] - time;
    NSLog(@"Result %f in %f seconds (Sqrt)", length, time);
    
    length = 0;
    time = [NSDate timeIntervalSinceReferenceDate];
    for (NSUInteger loopIndex = 0; loopIndex < numberOfLoops; loopIndex++) {
        for (NSUInteger pointIndex = 1; pointIndex < numberOfPoints; pointIndex++) {
            CGFloat dx = points[pointIndex].x - points[pointIndex - 1].y;
            CGFloat dy = points[pointIndex].x - points[pointIndex - 1].y;
            length += hypotf(dx, dy);
        }
    }
    time = [NSDate timeIntervalSinceReferenceDate] - time;
    NSLog(@"Result %f in %f seconds (Hypot)", length, time);
    
    length = 0;
    time = [NSDate timeIntervalSinceReferenceDate];
    for (NSUInteger loopIndex = 0; loopIndex < numberOfLoops; loopIndex++) {
        for (NSUInteger pointIndex = 1; pointIndex < numberOfPoints; pointIndex++) {
            CGFloat dx = fabs(points[pointIndex].x - points[pointIndex - 1].y);
            CGFloat dy = fabs(points[pointIndex].x - points[pointIndex - 1].y);
            length += dx+dy;
        }
    }
    time = [NSDate timeIntervalSinceReferenceDate] - time;
    NSLog(@"Result %f in %f seconds (Taxi-Cab)", length, time);
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

@end
