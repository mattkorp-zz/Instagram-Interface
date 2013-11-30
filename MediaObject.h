//
//  MediaObject.h
//  InstApp
//
//  Created by Matthew Korporaal on 11/24/13.
//  Copyright (c) 2013 Matthew Korporaal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaObject : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSURL *imageURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
