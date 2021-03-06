//
//  AldAFOpportunityDetailsInterpreter.m
//  leowic-3_Labb3b
//
//  Created by Leonard Wickmark on 28/10/13.
//  Copyright (c) 2013 LTU. All rights reserved.
//

#import "AldAFOpportunityDetailsInterpreter.h"
#import "AldAFOpportunityDetails.h"
#import "AldDataModelConstants.h"

@implementation AldAFOpportunityDetailsInterpreter

-(NSString *) interpretationId
{
    return kAldDataModelSignalOpportunityDetails;
}

-(id) interpretJSONDictionary: (NSDictionary *)data
{
    NSDictionary *ad = [data objectForKey:@"platsannons"];
    if (ad == nil) {
        return nil;
    }
    
    return [[AldAFOpportunityDetails alloc] initWithDictionary:ad];
}

@end
