//
//  PhotoObject.m
//  CustomTransition
//
//  Created by Eric Cerney on 6/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import "PhotoObject.h"

@interface PhotoObject() <NSCoding>

@end

@implementation PhotoObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary defaults:(NSUserDefaults *)defaults
{
    if (self = [super init]) {
        self.photoID = [dictionary[@"id"] stringValue];
        self.name = dictionary[@"name"];
        self.thumbnailURLString = [dictionary[@"image_url"] firstObject];
        self.imageURLString = [dictionary[@"image_url"] lastObject];
        
        self.defaults = defaults;
    }
    
    return self;
}

- (NSString *)stringFromAPIResponse:(id)response
{
    if ([response isKindOfClass:[NSString class]]) {
        return response;
    }
    else {
        return nil;
    }
}

- (NSUserDefaults *)defaults
{
    return (_defaults) ? _defaults : [NSUserDefaults standardUserDefaults];
}

#pragma mark - Object Property Setters

- (void)setName:(NSString *)name
{
    _name = [self stringFromAPIResponse:name];
}

- (void)setThumbnailURLString:(NSString *)thumbnailURLString
{
    _thumbnailURLString = [self stringFromAPIResponse:thumbnailURLString];
}

- (void)setImageURLString:(NSString *)imageURLString
{
    _imageURLString = [self stringFromAPIResponse:imageURLString];
}

#pragma mark - Favorite Getter / Setter

- (void)setFavorite:(BOOL)favorite
{
    NSMutableDictionary *favoritesDictionary = [[self.defaults objectForKey:@"favorites"] mutableCopy];
    
    if (!favoritesDictionary)
        favoritesDictionary = [NSMutableDictionary dictionary];
    
    if (favorite) {
        if (self.photoID && self.photoID.length) {
            NSData *objectData = [NSKeyedArchiver archivedDataWithRootObject:self];
            [favoritesDictionary setObject:objectData forKey:self.photoID];
        }
    }
    else {
        [favoritesDictionary removeObjectForKey:self.photoID];
    }
    
    [self.defaults setObject:favoritesDictionary forKey:@"favorites"];
    [self.defaults synchronize];
}

- (BOOL)isFavorite
{
    NSDictionary *favoritesDictionary = [self.defaults objectForKey:@"favorites"];
    
    return [favoritesDictionary objectForKey:self.photoID];
}

#pragma mark - NSCoding Protocol Methods

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.photoID forKey:@"photoID"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.thumbnailURLString forKey:@"thumbnailURLString"];
    [aCoder encodeObject:self.imageURLString forKey:@"imageURLString"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.photoID = [aDecoder decodeObjectForKey:@"photoID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.thumbnailURLString = [aDecoder decodeObjectForKey:@"thumbnailURLString"];
        self.imageURLString = [aDecoder decodeObjectForKey:@"imageURLString"];
    }
    return self;
}


@end
