//
//  CSCoreDataManagerTests.m
//  CSCoreDataStackExample
//
//  Created by Christian Sampaio on 2/27/14.
//  Copyright (c) 2014 Christian Sampaio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSCoreDataManager.h"

@interface CSCoreDataManagerTests : XCTestCase

@end

@implementation CSCoreDataManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testCallingStackWithoutUsernameOrObjectModelNameWillCrash
{
    CSCoreDataManager *manager = [CSCoreDataManager sharedManager];
    XCTAssertThrows([manager stack]);
}

- (void)testRegisteringUsernameAndObjectModelName
{
    NSString *username = @"myUsername",
    *objectModelName = @"CSCoreDataStackExample";
    
    [CSCoreDataManager registerUsername:username objectModelName:objectModelName];
    CSCoreDataManager *manager = [CSCoreDataManager sharedManager];
    XCTAssertEqual(manager.stack.username, username);
    
    // Asserting there is no error by saving
    NSError *error = nil;
    XCTAssertTrue([CSCoreDataManager saveContextUsingError:&error]);
    XCTAssertNil(error);
}

@end
