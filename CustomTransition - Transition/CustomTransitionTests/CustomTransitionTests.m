//
//  CustomTransitionTests.m
//  CustomTransitionTests
//
//  Created by Eric Cerney on 5/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PhotoObject.h"

@interface CustomTransitionTests : XCTestCase

@property (nonatomic, strong) PhotoObject *emptyObject;

@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSDictionary *oldFavoritesDictionary;

@end

@implementation CustomTransitionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.emptyObject = [[PhotoObject alloc] init];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.oldFavoritesDictionary = [self.defaults objectForKey:@"favorites"];
    
    [self.defaults removeObjectForKey:@"favorites"];
    [self.defaults synchronize];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    self.emptyObject = nil;
    
    [self.defaults setObject:self.oldFavoritesDictionary forKey:@"favorites"];
    [self.defaults synchronize];

    [super tearDown];
}

#pragma mark - Test Name Setter and Init

- (void)testSetNullNameReturnsNil
{
    self.emptyObject.name = (NSString *)[NSNull null];
    
    XCTAssertNil(self.emptyObject.name, @"Null name should result in nil string");
}

- (void)testSetValidNameReturnsName
{
    self.emptyObject.name = @"Test Name";
    
    XCTAssertEqual(self.emptyObject.name, @"Test Name", @"Name should have set valid string");
}

- (void)testInitWithInvalidNameSetsNil
{
    PhotoObject *validObject = [[PhotoObject alloc] initWithDictionary:@{@"name": @12345} defaults:nil];
    
    XCTAssertNil(validObject.name, @"Name from number should result in nil");
}

- (void)testInitWithValidNameSetsName
{
    PhotoObject *validObject = [[PhotoObject alloc] initWithDictionary:@{@"name": @"Test Name"} defaults:nil];
    
    XCTAssertEqual(validObject.name, @"Test Name", @"Name should have been set from init method");
}

#pragma mark - More advanced Unit tests on setting favorites

// Setter Tests
- (void)testSetFavoriteWithNoFavoritesDictionaryCreatesDictionary
{
    PhotoObject *photoObject = [[PhotoObject alloc] initWithDictionary:nil defaults:self.defaults];
    
    photoObject.favorite = YES;
    
    NSDictionary *createdDictionary = [self.defaults objectForKey:@"favorites"];
    
    XCTAssertNotNil(createdDictionary, @"Should have created empty favorites dictionary");
}

- (void)testSetFavoriteTrueWithValidObjectIDSavesToDefaults
{
    PhotoObject *photoObject = [[PhotoObject alloc] initWithDictionary:@{@"id": @12345} defaults:self.defaults];
    
    photoObject.favorite = YES;
    
    NSDictionary *createdDictionary = [self.defaults objectForKey:@"favorites"];
    
    XCTAssertEqual(createdDictionary.count, 1, @"Should have saved photo object to defaults");
}

- (void)testSetFavoriteFalseWithValidObjectIDRemovesFromDefaults
{
    PhotoObject *photoObject = [[PhotoObject alloc] initWithDictionary:@{@"id": @12345} defaults:self.defaults];
    photoObject.favorite = YES;
    
    photoObject.favorite = NO;
    
    NSDictionary *createdDictionary = [self.defaults objectForKey:@"favorites"];
    
    XCTAssertEqual(createdDictionary.count, 0, @"Should have saved photo object to defaults");
}

// Getter Tests

- (void)testIsFavoriteWithTrueDefaults
{
    PhotoObject *photoObject = [[PhotoObject alloc] initWithDictionary:@{@"id": @12345} defaults:self.defaults];
    photoObject.favorite = YES;
    
    XCTAssertTrue(photoObject.isFavorite, @"Should have been favorite");
}

- (void)testIsFavoriteWithNoFavorites
{
    PhotoObject *photoObject = [[PhotoObject alloc] initWithDictionary:@{@"id": @12345} defaults:self.defaults];
    
    XCTAssertFalse(photoObject.isFavorite, @"Should not have been favorite");
}

#pragma mark - Bonus Exception testing

- (void)testSettingFavoriteTrueIfAlreadyTrueThrowsException
{
    
}

@end
