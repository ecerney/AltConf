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
   
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [super tearDown];
}

#pragma mark - Test Name Setter and Init

- (void)testSetNullNameReturnsNil
{
    
}

- (void)testSetValidNameReturnsName
{

}

- (void)testInitWithInvalidNameSetsNil
{
    
}

- (void)testInitWithValidNameSetsName
{
    
}

#pragma mark - More advanced Unit tests on setting favorites

// Setter Tests
- (void)testSetFavoriteWithNoFavoritesDictionaryCreatesDictionary
{
    
}

- (void)testSetFavoriteTrueWithValidObjectIDSavesToDefaults
{
    
}

- (void)testSetFavoriteFalseWithValidObjectIDRemovesFromDefaults
{
    
}

// Getter Tests

- (void)testIsFavoriteWithTrueDefaults
{
   
}

- (void)testIsFavoriteWithNoFavorites
{
    
}

#pragma mark - Bonus Exception testing

- (void)testSettingFavoriteTrueIfAlreadyTrueThrowsException
{
    
}

@end
