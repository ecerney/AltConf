//
//  PhotoObject.h
//  CustomTransition
//
//  Created by Eric Cerney on 6/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoObject : NSObject

@property (nonatomic, copy) NSString *photoID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *thumbnailURLString;
@property (nonatomic, copy) NSString *imageURLString;

@property (nonatomic, getter = isFavorite) BOOL favorite;

@property (nonatomic, strong) NSUserDefaults *defaults;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary defaults:(NSUserDefaults *)defaults;

@end
