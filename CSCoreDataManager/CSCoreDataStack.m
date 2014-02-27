//
//  CSCoreDataStack.m
//  CSCoreDataStackExample
//
//  Created by Christian Sampaio on 2/27/14.
//  Copyright (c) 2014 Christian Sampaio. All rights reserved.
//

#import "CSCoreDataStack.h"

@interface CSCoreDataStack ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *context;
@property (nonatomic, copy, readwrite) NSString *username;

@end

@implementation CSCoreDataStack

- (instancetype)initWithUserName:(NSString *)username
                 objectModelName:(NSString *)objectModelName
{
    self = [super init];
    if (self)
    {
        self.username = username;
        [self setupWithObjectModelName:objectModelName];
    }
    return self;
}

/*
 Setup the stack - load data model, database, setup context, persistent store, etc
 */
- (void)setupWithObjectModelName:(NSString *)objectModelName
{
    
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    NSManagedObjectModel *objectModel = [self objectModelWithName:objectModelName];
    self.context.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:objectModel];
    NSError *error = nil;
    NSURL *storeURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                             inDomain:NSUserDomainMask
                                                    appropriateForURL:nil
                                                               create:YES
                                                                error:NULL];
    NSString *usernameDB = [NSString stringWithFormat:@"%@-db.sqlite", self.username];
    storeURL = [storeURL URLByAppendingPathComponent:usernameDB];
    
    [self.context.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                          configuration:nil
                                                                    URL:storeURL
                                                                options:nil
                                                                  error:&error];
    
    if (error)
    {
        @throw [NSException exceptionWithName:@"CoreData Setup Fail"
                                       reason:[error.userInfo description]
                                     userInfo:error.userInfo];
    }
    
    self.context.undoManager = [NSUndoManager new];
}

- (NSManagedObjectModel *)objectModelWithName:(NSString *)objectModelName
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:objectModelName
                                              withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return model;
}

@end
