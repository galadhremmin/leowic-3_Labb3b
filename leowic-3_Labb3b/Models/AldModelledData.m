//
//  AldModelledData.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/21/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldModelledData.h"

@implementation AldModelledData

-(id) initWithData: (id)data
{
    self = [super init];
    if (self) {
        self.data = data;
        self.lastUpdate = CFAbsoluteTimeGetCurrent();
    }
    
    return self;
}

-(id) initWithData: (id)data forKey: (NSString *)dataKey
{
    if (dataKey == nil) {
        return [self initWithData:data];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:data forKey:dataKey];
    return [self initWithData:dict];
}

-(id) searchForEntityWithId: (NSString *)entityId
{
    if (_data == nil) {
        return nil;
    }
    
    if ([_data isKindOfClass:[NSArray class]]) {
        return [self searchInArray:_data forKey:entityId withPath:@"entityId"];
    }
    
    if ([_data isKindOfClass:[NSDictionary class]]) {
        NSArray *keys = [_data allKeys];
        id value = nil;
        for (NSString *key in keys) {
            value = [self searchInArray:[_data objectForKey:key] forKey:entityId withPath:@"entityId"];
            if (value != nil) {
                return value;
            }
        }
    }
    
    [NSException raise:@"Unrecognised data container to search in." format:@"What kind of class is %@?", NSStringFromClass([_data class])];
    return nil;
}

-(id) searchInArray: (NSArray *)dataArray forKey: (NSString *)key withPath: (NSString *)path
{
    if (dataArray == nil) {
        return nil;
    }
    
    if (key == nil) {
        return nil;
    }
    
    if (path == nil) {
        return nil;
    }
    
    id soughtClass = [NSString class];
    for (id entity in dataArray) {
        id value = [entity valueForKeyPath:path];
        if ([value isKindOfClass:soughtClass] && [value isEqualToString:key]) {
            return entity;
        }
    }
    
    return nil;
}

@end
