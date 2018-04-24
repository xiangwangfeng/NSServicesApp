//
//  AppDelegate.m
//  archiver
//
//  Created by amao on 2018/4/24.
//  Copyright © 2018年 www.xiangwangfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "M80Service.h"
@import AppKit;

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@property (nonatomic,strong) M80Service *service;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    _service = [M80Service new];
    NSApp.servicesProvider = _service;
    
    NSUpdateDynamicServices();
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
