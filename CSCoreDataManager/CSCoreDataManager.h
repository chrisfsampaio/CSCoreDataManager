//
//  CSCoreDataManager.h
//  CSCoreDataStackExample
//
//  Created by Christian Sampaio on 2/27/14.
//  Copyright (c) 2014 Christian Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSCoreDataStack.h"

@interface CSCoreDataManager : NSObject

/*
 Returns a unique stack for the current user
 */
@property (nonatomic, strong, readonly) CSCoreDataStack *stack;

+ (void)registerUsername:(NSString *)username
         objectModelName:(NSString *)objectModelName;
+ (instancetype)sharedManager;
+ (BOOL)saveContextUsingError:(NSError *__autoreleasing *)error;

@end
