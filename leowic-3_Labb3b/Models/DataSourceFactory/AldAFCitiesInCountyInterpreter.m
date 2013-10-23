//
//  AldAFCitiesInCountyInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/23/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFCitiesInCountyInterpreter.h"
#import "AldAFCity.h"
#import "AldDataModelConstants.h"

@implementation AldAFCitiesInCountyInterpreter

-(NSString *) interpretationId
{
    return kAldDataModelSignalCity;
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    id cities = [[data objectForKey:@"soklista"] objectForKey:@"sokdata"];
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSDictionary *cityData in cities) {
        AldAFCity *city = [[AldAFCity alloc] initWithDictionary:cityData];
        [result addObject:city];
    }
    
    return result;
}

@end
