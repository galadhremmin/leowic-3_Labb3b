//
//  AldAFOpportunityInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 27/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFOpportunityInterpreter.h"
#import "AldDataModelConstants.h"
#import "AldAFOpportunity.h"

@implementation AldAFOpportunityInterpreter

-(NSString *)interpretationId
{
    return kAldDataModelSignalOpportunities;
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    id opportunities = [[data objectForKey:@"matchningslista"] objectForKey:@"matchningdata"];
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *opportunityData in opportunities) {
        AldAFOpportunity *opportunity = [[AldAFOpportunity alloc] initWithDictionary:opportunityData];
        [result addObject:opportunity];
    }
    
    return result;
}

@end
