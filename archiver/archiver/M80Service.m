//
//  M80Service.m
//  archiver
//
//  Created by amao on 2018/4/24.
//  Copyright © 2018年 www.xiangwangfeng. All rights reserved.
//

#import "M80Service.h"
@import AppKit;

@implementation M80Service

- (void)archive:(NSPasteboard *)pboard
       userData:(NSString *)data
          error:(NSString **)error
{
    NSString *rootDir = [self dirName];
    NSArray *classes = @[[NSURL class]];
    NSDictionary *options = @{};
    NSArray *files = [pboard readObjectsForClasses:classes
                                           options:options];
    for (NSURL *url in files)
    {
        NSString *filename = [[url path] lastPathComponent];
        NSString *dstPath = [rootDir stringByAppendingPathComponent:filename];
        NSURL *dstURL = [NSURL fileURLWithPath:dstPath];
        if (url && dstURL)
        {
            [[NSFileManager defaultManager] moveItemAtURL:url
                                                    toURL:dstURL
                                                    error:nil];
        }
    }
}

- (NSString *)dirName
{
    
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *parentDir = [documents stringByAppendingPathComponent:@"archives"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:parentDir])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:parentDir
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *dirName = [formatter stringFromDate:[NSDate date]];
    NSString *path = [parentDir stringByAppendingPathComponent:dirName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    return path;
}
@end
