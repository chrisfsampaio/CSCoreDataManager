//
//  CSCoreDataManager.m
//  CSCoreDataStackExample
//
//  Created by Christian Sampaio on 2/27/14.
//  Copyright (c) 2014 Christian Sampaio. All rights reserved.
//

#import "CSCoreDataManager.h"
#import <CoreData/CoreData.h>

@interface CSCoreDataManager ()

@property (nonatomic, strong, readwrite) CSCoreDataStack *stack;
@property (nonatomic, copy) NSString *currentUsername;
@property (nonatomic, copy) NSString *objectModelName;

@end

@implementation CSCoreDataManager


+ (instancetype)sharedManager
{
    static CSCoreDataManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [CSCoreDataManager new];
    });
    return _sharedManager;
}

/*
 Get the stack according to the user;
 */
- (CSCoreDataStack *)stack
{
    [self validateUsernameAndObjectModelName];
    
    // if we don't have a stack created, or the current username is different from the last created stack
    // create a brand new stack for the current user
    NSString *currentUsername = self.currentUsername;
    if (!_stack || ![currentUsername isEqualToString:_stack.username])
    {
        _stack = [[CSCoreDataStack alloc] initWithUserName:currentUsername
                                           objectModelName:self.objectModelName];
    }
    return _stack;
}

+ (BOOL)saveContextUsingError:(NSError *__autoreleasing *)error
{
    return [[[[CSCoreDataManager sharedManager] stack] context] save:error];
}

+ (void)registerUsername:(NSString *)username
         objectModelName:(NSString *)objectModelName
{
    NSAssert(username, @"Why would you provide a nil username?");
    NSAssert(objectModelName, @"We need a objectModelName, please");
    CSCoreDataManager *manager = [self sharedManager];
    manager.currentUsername = username;
    manager.objectModelName = objectModelName;
}


- (void)validateUsernameAndObjectModelName
{
    NSAssert(self.currentUsername, [self errorMessageForInvalidUsernameOrObjectModelName]);
    NSAssert(self.objectModelName, [self errorMessageForInvalidUsernameOrObjectModelName]);
}

- (NSString *)errorMessageForInvalidUsernameOrObjectModelName
{
    NSString *errorMessage = @"You need to provide an username and Object Model Name by calling [CSCoreDataManager registerUsername:@\"myUsername\" objectModelName:@\"MYCoreDataObjectModel\"]";
    return errorMessage;
}

@end
