//
//  AldAFOfficesInCountyInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 10/14/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFOfficesInCountyInterpreter.h"
#import "AldDataModelConstants.h"
#import "AldAFOffice.h"

@implementation AldAFOfficesInCountyInterpreter

-(NSString *) interpretationId
{
    return kAldDataModelSignalOffices;
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    NSArray *offices = [[data objectForKey:@"arbetsformedlingslista"] objectForKey:@"arbetsformedlingplatsdata"];
    if (offices == nil || [offices count] < 1) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *officeData in offices) {
        AldAFOffice *office = [[AldAFOffice alloc] initWithDictionary:officeData];
        [result addObject:office];
    }
    
    return result;
}

@end
