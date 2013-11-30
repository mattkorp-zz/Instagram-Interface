//
//  MediaManager.h
//  InstApp
//
//  Created by Matthew Korporaal on 11/24/13.
//  Copyright (c) 2013 Matthew Korporaal. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MediaManager : NSObject

- (void)fetchPopularMediaWithCompletionBlock:(void (^)(NSArray *media, NSError *error))completionBlock;

- (void)downloadImage:(NSURL *)imageURL withCompletionBlock:(void (^)(NSURL *location, NSError *error))completionBlock;

@end