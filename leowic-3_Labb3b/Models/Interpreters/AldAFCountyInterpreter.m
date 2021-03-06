//
//  AldAFCountyInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFCountyInterpreter.h"
#import "AldAFCounty.h"
#import "AldDataModelConstants.h"

@implementation AldAFCountyInterpreter

-(NSString *) interpretationId
{
    return kAldDataModelSignalCounties;
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    NSArray *counties = [[data objectForKey:@"soklista"] objectForKey:@"sokdata"];
    if (counties == nil || [counties count] < 1) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *countyData in counties) {
        AldAFCounty *county = [[AldAFCounty alloc] initWithDictionary:countyData];
        [result addObject:county];
    }
    
    return result;
}

@end
