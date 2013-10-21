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
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:data forKey:dataKey];
    return [self initWithData:dict];
}

@end
