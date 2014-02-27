//
//  CSCoreDataStack.h
//  CSCoreDataStackExample
//
//  Created by Christian Sampaio on 2/27/14.
//  Copyright (c) 2014 Christian Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCoreDataStack : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *context;
@property (nonatomic, copy, readonly) NSString *username;

/*
 This is the designated initializer
 */
- (instancetype)initWithUserName:(NSString *)username
                 objectModelName:(NSString *)objectModelName;

@end
