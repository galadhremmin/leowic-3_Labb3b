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
    NSArray *opportunities = [[data objectForKey:@"matchningslista"] objectForKey:@"matchningdata"];
    if (opportunities == nil || [opportunities count] < 1) {
        return nil;
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *opportunityData in opportunities) {
        AldAFOpportunity *opportunity = [[AldAFOpportunity alloc] initWithDictionary:opportunityData];
        [result addObject:opportunity];
    }
    
    return result;
}

@end
